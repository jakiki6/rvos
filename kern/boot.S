.option norvc

.section .text
.global _start
_start:
	# disable interrupts
	csrw mie, zero

	# wait for IPI if we're not the right hart
	csrr t0, mhartid
	bnez t0, wait_for_jmp

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
	la sp, __boot_stack

	# argc = 0, argv = 0
        li a0, 0
        li a1, 0
.extern boot_kernel
	j boot_kernel

wait_for_jmp:
	csrr t0, mhartid
	li t1, 8
        bgeu t0, t1, halt

	addi t0, t0, -1
	slli t0, t0, 3
	la t1, smp_boot_table
	add a0, t0, t1

.wait:	ld t0, (a0)
	bne t0, zero, .wait

	# argc = 0, argv = 0
	mv a2, a0
	li a0, 0
	li a1, 0
	jr a2

halt:
	wfi
	j halt

.section .bss
__boot_stack:
	.space 32768, 0

.global smp_boot_table

smp_boot_table:
	.space 8 * 8, 0
