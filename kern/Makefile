export PATH:=$(shell ../toolchain/use-it.sh):$(PATH)

TARGET = kern

CC = riscv64-elf-gcc
LD = riscv64-elf-ld
STRIP = riscv64-elf-strip
OBJCOPY = riscv64-elf-objcopy
AR = riscv64-elf-ar
AS = riscv64-elf-as

CFILES := $(shell find . -type f -name '*.c')
ASMFILES := $(shell find . -type f -name '*.S')
OBJ    := $(CFILES:.c=.o) $(ASMFILES:.S=.o)

all: run

run: $(TARGET)
	qemu-system-riscv64 -cpu rv64 -d guest_errors,unimp -D log.txt -bios none -kernel $<

$(TARGET): $(OBJ)
	$(LD) -Tlinker.ld -o $@ $^

%.o: %.c
	$(CC) -c -nostdlib -ffreestanding -o $@ $<

%.o: %.S
	$(AS) -o $@ $<

clean:
	rm $(TARGET) *.o 2> /dev/null || true

.PHONY: all clean
