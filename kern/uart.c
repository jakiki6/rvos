#include <stdint.h>

#include "mmio.h"

void uart_setup(uint64_t base_address) {
	// lcr
	mmio_write(base_address, 3, (1 << 0) | (1 << 1));
	// enable fifo
	mmio_write(base_address, 2, 1 << 0);
	// enable receive buffer interrupts
	mmio_write(base_address, 1, 1 << 0);

	uint16_t divisor = 592;
	uint8_t divisor_least = divisor & 0xff;
	uint8_t divisor_most = divisor >> 8;

	// enable divisor latch to write divisor
	mmio_write(base_address, 3, (1 << 0) | (1 << 1) | (1 << 7));
	// write divisor
	mmio_write(base_address, 0, divisor_least);
	mmio_write(base_address, 1, divisor_most);

	// restore lcr
	mmio_write(base_address, 3, (1 << 0) | (1 << 1));
}

uint8_t uart_read(uint64_t base_address) {
	while (mmio_read(base_address, 5) & 1 == 0);
	return mmio_read(base_address, 0);
}

void uart_write(uint64_t base_address, uint8_t data) {
	mmio_read(base_address, 0);
}
