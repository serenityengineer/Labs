
	.data
	
	.text

main:
	li a0, 5 #load i into a0
	jal AddItUp

	li a1, 10 #load j into a1
	jal AddItUp
	
AddItUp:
	
	addi sp, sp, -8 # making space on stack
	sw t0, 0(sp) # saving i
	sw t1, 4(sp) #saving j
	
	add t0, zero, zero # new i
	add t1, zero, zero # new x
	
	forloop:
		add, t1, t1, t0
		addi t1, t1, 1
		blt t0, a2, forloop
	add a0, zero, t1 # returning x
		
	lw t0, 0(sp) #loading original i
	lw t1, 4(sp) # loading original j
	addi sp, sp, 8 # deleting stack spaces
	j main
		
	
