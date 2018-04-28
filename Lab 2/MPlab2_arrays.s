
	.data

arrA:	.word	0, 0, 0, 0, 0
arrB:	.word	1, 2, 4, 8, 16
i:	.word	0

	.text
	
main:

	la s0, arrA
	la a0, arrB
	lw t0, i
	
	