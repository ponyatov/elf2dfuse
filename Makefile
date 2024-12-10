ifeq ($(OS),Windows_NT)
	EXE_SUFFIX := .exe
endif

ELF2DFUSE_C := elf2dfuse.c
TARGET := elf2dfuse$(EXE_SUFFIX)

.PHONY: all
all: $(TARGET)

$(TARGET): Makefile $(ELF2DFUSE_C)
	$(CC) $(ELF2DFUSE_C) -o $@ $(CFLAGS)
	strip $@

.PHONY: clean
clean:
	rm -f $(TARGET)

# install
.PHONY: install update ref gz
install: ref gz
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -uy `cat apt.$(shell lsb_release -si)`
ref: $(REF)
gz:  $(GZ)
