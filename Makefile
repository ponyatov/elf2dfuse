TARGET ?= linux-x86_64
# linux-x86_64
# win32-i686

ifeq ($(OS),Windows_NT)
	EXE_SUFFIX := .exe
endif

# dirs
CWD = $(CURDIR)
BIN = $(CWD)/bin
SRM = $(CWD)/src
TMP = $(CWD)/tmp

# src
C += $(wildcard $(SRC)/*.c*)

# all
.PHONY: all
all:
	cmake -S $(CWD) -B $(TMP)/$(TARGET) --preset $(TARGET)
	cmake --build      $(TMP)/$(TARGET)
	cmake --install    $(TMP)/$(TARGET)

.PHONY: clean
clean:
	rm -rf $(TMP)/$(TARGET) $(BIN)/$(TARGET)

# install
.PHONY: install update ref gz
install: ref gz
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -uy `cat apt.$(shell lsb_release -si)`
ref: $(REF)
gz:  $(GZ)
