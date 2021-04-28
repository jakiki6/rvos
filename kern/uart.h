#include <stdint.h>

void uart_setup(uint64_t base_address);
uint8_t uart_read(uint64_t base_address);
void uart_write(uint64_t base_address, uint8_t data);
