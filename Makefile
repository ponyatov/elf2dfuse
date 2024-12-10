TARGET ?= linux-x86_64
# linux-x86_64
# win32-i686

ifeq ($(OS),Windows_NT)
	EXE_SUFFIX := .exe
endif

C += $(wildcard src/*.c*)

.PHONY: all
all:
	cmake --preset linux-x86_64 -S . -B tmp/linux-x86_64
	cmake --build tmp/linux-x86_64

.PHONY: clean
clean:
	rm -rf tmp/$(TARGET) bin/$(TARGET)

# install
.PHONY: install update ref gz
install: ref gz
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -uy `cat apt.$(shell lsb_release -si)`
ref: $(REF)
gz:  $(GZ)
