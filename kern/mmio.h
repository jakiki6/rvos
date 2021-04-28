#include <stdint.h>

void mmio_write(uint64_t address, int offset, uint8_t value);
uint8_t mmio_read(uint64_t address, int offset);
