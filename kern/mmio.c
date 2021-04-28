#include <stdint.h>

void mmio_write(uint64_t address, int offset, uint8_t value) {
	volatile char *reg = (char *) address;

	*(reg + offset) = value;
}

uint8_t mmio_read(uint64_t address, int offset) {
	volatile char *reg = (char *) address;

	return *(reg + offset);
}
