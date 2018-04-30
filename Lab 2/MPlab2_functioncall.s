
	.data
	myArray:	.word	5, 10
	.text

main:
	la a0, myArray #load address of array
	li a1, 4
	jal AddItUp
#	add a1, zero, a0 #store a0 new value

#	li a0, 10 #load j into a1
#	jal AddItUp
#	add a2, zero, a0 #store a0 new value
	
AddItUp:
	slli	t1, a1, 2	#t1 has the address sent from main: t1=4*k
	add		t1, a0, t1	#reg t1=address of myArray[k]
	lw		t0, 0(t1)	#reg t0=i
	add t2, zero, zero # t2 = x = 0
	
	#addi sp, sp, -8 # making space on stack
	#sw t0, 0(sp) # saving i
	#sw t1, 4(sp) #saving j
	
	#add t0, zero, zero # new i
	#add t1, zero, zero # new x
	
	forloop:
		add, t2, t2, t3
		addi t2, t2, 1
		blt t3, a2, forloop
	add a0, zero, t1 # returning x
		
	#lw t0, 0(sp) #loading original i
	#lw t1, 4(sp) # loading original j
	#addi sp, sp, 8 # deleting stack spaces
	ret a0
		
	
