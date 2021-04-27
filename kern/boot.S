.option norvc

.section .text
.global _start
_start:
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

wait_for_jmp:
	csrr t0, mhartid
	li t1, 2
        bltu t1, t0, halt

	addi t0, t0, -1
	slli t0, t0, 3
	la t1, smp_boot_table
	add a0, t0, t1

.wait:	ld t0, (a0)
	bne t0, zero, .wait

	jr a0

halt:
	wfi
	j halt

.section .bss
__boot_stack:
	.space 32768, 0

.global smp_boot_table

smp_boot_table:
	.space 8 * 8, 0
