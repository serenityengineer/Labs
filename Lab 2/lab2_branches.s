	
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

blt t0, t1, AND1 # A < B
bge t0, t1, ELSE1 # A > B
AND1: bge t2, s0, THEN1 # C > 5
blt t2, s0, OR1 # C < 5

THEN1: addi a0, zero, 1 # Z = 1
	beq a0, s2, SWITCH

ELSE1: addi a0, zero, 2 # Z = 2
	beq a0, s3, SWITCH
OR1: addi t2, t2, 1 # C = C+1
     beq t2, s1, ELSE1 # C+1 = 7
     bne t2, s1, THEN2

THEN2: addi a0, zero, 3 # Z = 3
	beq a0, s4, SWITCH
	
SWITCH: beq a0, s2, CASE1
	beq a0, s3, CASE2
	beq a0, s4, CASE3
	bne a0, s4, DEFAULT
	
CASE1: addi a0, zero, -1
Exit:
CASE2: addi a0, zero, -2
Exit1:
CASE3: addi a0, zero, -3
Exit2:
DEFAULT: addi a0, zero, 0
	
	





