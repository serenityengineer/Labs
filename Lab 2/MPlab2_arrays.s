
	.data
	 
arrA: .word 0,0,0,0,0 
arrB: .word 1,2,4,8,16
i: .word 0
size: .word 5 

	.text
	
main: 
	la s0, arrA
	la s1, arrB
	lw s2, i
	lw s3, size
	
for: 
	beq s2, s3, next # s2 = s3 => next
    	slli s4, s2, 2
    	add s6, s4, zero
    	add s4, s4, s1 # B address in B[i]
    	lw s5, 0(s4)
    	addi s5, s5, -1 
    	add s6, s6, s0
    	sw s5, 0(s6) # s5 => A[i]
    	addi s2, s2, 1 # i++
    	j for 

next: # increments element
	addi s2, s2, -1
	li a0, -1
	la s0, arrA
	la s1, arrB

while:
	beq s2, a0, Exit 
    	slli s4, s2, 2 
    	add s6, s4, zero
    	add s4, s4, s1 # B location in B[i]
    	lw s5, 0(s4) 
    	add s6, s6, s0 # address of A[i] => s6
    	lw s7, 0(s6)
    	add s5, s5, s7
    	add s5, s5, s5 
    	sw s5, 0(s6)
    	addi s2, s2, -1
    	j while
    	
exit:
