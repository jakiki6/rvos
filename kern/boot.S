.option norvc

.section .text
.global _start
_start:
.option push
.option norelax
	la gp, __data_start
.option pop

	# wait for IPI if we're not the right hart
	csrr t0, mhartid
	bnez t0, halt

	# set SATP to zero
	csrw satp, zero

zero_bss:
	la a0, __bss_start
	la a1, __bss_end
	bgeu a0, a1, setup_stack

zero_bss_loop:
	sd zero, (a0)
	addi a0, a0, 8
	bltu a0, a1, zero_bss_loop

setup_stack:
	la sp, __boot_stack_bottom

	# argc = 0, argv = 0
        li a0, 0
        li a1, 0
.extern boot_kernel
	j boot_kernel

halt:
	wfi
	j halt

.section .bss
__boot_stack_top:
	.space 32768, 0
__boot_stack_bottom:
