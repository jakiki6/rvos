/* Tell the linker that we want the symbol _start to be our entry point */
ENTRY(_start)

SECTIONS
{
    . = 0x80000000;
    __kernel_start = .;

    /* Then let's place all the other traditional executable sections afterwards. */
    __text_start = .;
    .text ALIGN(4K) : {
	*(.boot)
        *(.text*)
    }
    __text_end = .;

    __data_start = .;
    .data ALIGN(4K) : {
        *(.data* .rodata .rodata.*)
    }
    __data_end = .;

    __bss_start = .;
    .bss ALIGN(4K) : {
        *(COMMON)
        *(.bss*)
    }
    __bss_end = .;

   .text : { *(.text) }
   .data : { *(.data) }
   .bss  : { *(.bss)  }
   /DISCARD/ : { *(.comment) *(.riscv.attributes) }

   __kernel_end = .;
}
