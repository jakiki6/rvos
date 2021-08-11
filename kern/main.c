#include <stdint.h>

#include "uart.h"

void boot_kernel(int argc, char *argv[]) {
	// we need early console somehow
	uart_setup(0x10000000);

	// test it
	uart_write(0x10000000, '@');

	return;
}
