	
	.data
	
varA:	.word	10
varB:	.word	15
varC: 	.word	6

varZ:	.word	0

const5:	.word	5
const7:	.word	7
ans1:	.word	1
ans2: 	.word	2
ans3:	.word	3

	.text
main:

lw t0, varA
lw t1, varB
lw t2, varC
lw a0, varZ

lw s0, const5
lw s1, const7
lw s2, ans1
lw s3, ans2
lw s4, ans3

bge t0, t1, jump # A > B

condition: 
	blt t2, s0, condition2 # C < 5
	addi a0, zero, 1 # Z = 1
	beq a0, s2, case1
	 

jump:
	addi a0, zero, 2 # Z = 2
	beq a0, s3, case2
	
condition2:
	addi t2, t2, 1 # C = C+1
	beq t2, s1, jump # C = 7
	add a0, a0, s4 # Z = 3
	beq a0, s4, case3
	
case1:
	addi a0, zero, -1
	beq a0, a0, exit
case2:
	addi a0, zero, -2
	beq a0, a0, exit
case3:
	addi a0, zero, -3
	beq a0, a0, exit
	
exit:
	
	
	
	
	
	
	
