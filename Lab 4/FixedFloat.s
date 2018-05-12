	.data
begn:	.asciz	"Number one: "
cont:	.asciz  "Number two: "
announ:	.asciz	"Product is: "
ann2x:	.asciz	"Prod 2x is: "
inhex:	.asciz	"In HEX is : "
newln:	.asciz	"\r\n"

fpVal:	.float	2.0
		
	.text
main:	
	jal	fixed		# the call to the function
	jal	floats
Exit:
	j	Exit

#----------------------------------------------------------------
	.globl	fixed
fixed:
	li	a7,4			#system call for print string
	la	a0,begn
	ecall
	li	a7,5			#system call for reading int
	ecall
	
	add	t0, zero, a0	#save to t0
	
	li	a7,4			#system call for print string
	la	a0,cont
	ecall	
	li	a7,5			#system call for reading int
	ecall
	
	add	t1, zero, a0	#save to t1
	
	mul		t2, t1, t0	# low 32 bits
	mulh	t3, t1, t0	# high 32 bits

	li	a7,4			#system call for print string
	la	a0,announ
	ecall
	li	a7,1			#system call for printing int in ascii
	mv	a0, t2			#get the LO value	
	ecall

	li	a7,4			#system call for print string
	la	a0,newln
	ecall

	ret
#-----------------------------------------------------------------
	.globl	floats
floats:
	flw	ft0, fpVal, t0	#load FP val from memory
	
	li	a7,4			#system call for print string
	la	a0,begn
	ecall
	li	a7,6			#system call for reading floating point
	ecall
	
	fmv.s	ft1,fa0		#save result in ft1

	li	a7,4			#system call for print string
	la	a0,cont
	ecall
	li	a7,6			#system call for reading floating point
	ecall

	fmv.s	ft2,fa0		#save result in ft2

	fmul.s	ft3, ft1, ft2	# mult fp numbers
	fmul.s	ft3, ft3, ft0	# mult fp numbers

	fmv.s	fa0, ft3	# copy FP value from ft3 to fa0
	fmv.x.s	t1, ft3		# copy FP value to t reg

	fsw	fa0, fpVal, t0	#store FP val to memory

	li	a7,4			#system call for print string
	la	a0,ann2x
	ecall
	li	a7,2			#system call for printing float fa0 in ascii
	ecall
	li	a7,4			#system call for print string
	la	a0,newln
	ecall

	li	a7,4			#system call for print string
	la	a0,inhex
	ecall
	li	a7,34			#system call for printing int in hex
	mv	a0, t1			#print IEEE format of FP value	
	ecall
	li	a7,4			#system call for print string
	la	a0,newln
	ecall

	ret
#-----------------------------------------------------------------
