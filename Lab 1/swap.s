# Lab 1

	.data	# Data declaration section

zing:	.word	0, 1, 2, 3, 4, 5, 6, 7
str1:	.asciz	"zing[4] now has "
str2:	.asciz	"\nzing[5] now has "

	.text

main:	
	la	a0, zing	#address of zing array
	li	a1, 4
	jal	swap
	
	li	a7, 4		#system call for printing a string
	la	a0, str1
	ecall

	li	a7, 1		#system call for printing an integer in ASCII
	lw	a0, 0(t1)
	ecall

	li	a7, 4		#system call for printing a string
	la	a0, str2
	ecall
	
	li	a7, 1		#system call for printing an integer in ASCII
	lw	a0, 4(t1)
	ecall
	
	li	a7, 11		#system call for printing a character in ASCII
	li	a0, 10
	ecall
	
	li	a7, 10		#system call for an exit
	ecall
	

swap:	
	slli	t1, a1, 2	#reg t1=k*4
	add		t1, a0, t1	#reg t1=address of zing[k]
				
	lw		t0, 0(t1)	#reg t0=zing[k]
	lw		t2, 4(t1)	#reg t2=zing[k+1]
				
	sw		t2, 0(t1)	
	sw		t0, 4(t1)
	addi  		t4, zero, 5	
	ret		

# END OF PROGRAM
