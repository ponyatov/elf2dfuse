# cross
TARGET ?= linux-x86_64
# linux-x86_64
# win32-i686

# var
MODULE = $(notdir $(CURDIR))
REL    = $(shell git rev-parse --short=4    HEAD)
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
NOW    = $(shell date +%d%m%y)

ifeq ($(OS),Windows_NT)
	OS = MinGW
else
	OS = $(shell lsb_release -si)
endif

# dirs
CWD = $(CURDIR)
BIN = $(CWD)/bin
DOC = $(CWD)/doc
INC = $(CWD)/inc
SRC = $(CWD)/src
TMP = $(CWD)/tmp

# tool
CURL   = curl -L -o
CF     = clang-format -style=file -i

# src
C += $(wildcard $(SRC)/*.c*)
H += $(wildcard $(INC)/*.h*)

# all
.PHONY: all
all:
	cmake -S $(CWD) -B $(TMP)/$(TARGET) --preset $(TARGET)
	cmake --build      $(TMP)/$(TARGET)
	cmake --install    $(TMP)/$(TARGET)

# clean
.PHONY: clean
clean:
	rm -rf $(TMP)/$(TARGET) $(BIN)/$(TARGET)

# format
.PHONY: format
format: tmp/format_cpp
tmp/format_cpp: $(C) $(H)
	$(CF) $? && touch $@

# doc

# DOCS += $(DOC)/Cpp/modern-cmake.pdf
$(DOC)/Cpp/modern-cmake.pdf:
	$(CURL) $@ https://cliutils.gitlab.io/modern-cmake/modern-cmake.pdf

.PHONY: doc
doc: $(DOCS)

# install
.PHONY: install update update_$(OS) ref gz
install: doc ref gz
	$(MAKE) update
update: update_$(OS)
ref:    $(REF)
gz:     $(GZ)

update_Debian:
	sudo apt update
	sudo apt install -uy `cat apt.Debian`
update_MinGW:
	pacman -Suy
	pacman -S `cat $< | tr '[ \t\r\n]+' ' ' `

# merge
.PHONY: release
release:
	git tag $(NOW)_$(REL)_$(BRANCH)
	git push -v --tags

ZIP = tmp/$(MODULE)_$(NOW)_$(REL)_$(BRANCH).zip
zip: $(ZIP)
$(ZIP): doxy
	git archive --format zip --output $(ZIP) HEAD
