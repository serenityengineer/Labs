
	.data
	

	a:	.word	0
	b:	.word	0
	c:	.word	0
	

		.text
	main:
		addi	t0, zero, 5		# i = 5
		addi	t1, zero, 10	# j = 10
		addi	sp, sp, -8	# allocate memory
		sw	t0, 0(sp)	# store 5 in stack
		sw	t1, 4(sp)	# store 10 in stack
		jal	addItUp		# function call
		
		sw	a0, a, t6
		lw 	s3, a
		
		lw	t1, 4(sp)
		sw	t1, 0(sp)	# store 10 in stack
		jal addItUp		# function call
		
		sw	a0, b, t6
		lw 	s4, b
		
		add 	t5, s3, s4	# c = a + b
		sw 	t5, c, t6 
		lw	s5, c	
	

	addItUp:
		lw	a2, 0(sp)	# load n into register a2 
		addi 	t0, zero, 0	# t0 = x = 0
		addi	t1, zero, 0	# t1 = i = 0
		j forLoop
		
		forLoop:
			add	t0, t0, t1	# x = x + i
			addi	t0, t0, 1	# x = x + 1
			addi	t1, t1, 1	# i++
			blt	t1, a2, forLoop
		
        add	a0, zero, t0	# store x into a0 so it can be returned
		ret
