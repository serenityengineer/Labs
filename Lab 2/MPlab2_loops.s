
	.data

Z:	.word	2
i:	.word	0
const1:	.word	1
const20: .word	20
const100: .word	100

	.text
	
main:

	lw t0, Z
	lw a0, i 
	lw s0, const1
	lw s1, const20
	lw s2, const100
	
	for:
	addi t0, t0, 1
	addi, a0, a0, 2
	blt a0, s1, for
	
	do:
	addi t0, t0, 1
	blt t0, s2, do
	
	while:
	sub t0, t0, s0
	sub a0, a0, s0
	bge a0, zero, while
	
	
	
