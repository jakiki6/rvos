#include <stdint.h>

#include "config.h"
#include "uart.h"

extern uint64_t smp_boot_table[CONFIG_SMP_CORES];

void boot_kernel(int argc, char *argv[]) {
	// we need early console somehow
	uart_setup(0x10000000);

	// test it
	uart_write(0x10000000, '@');

	return;
}
