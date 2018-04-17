#  Example program to compute the sum of diagonal
#  in a square two­dimensional array
#  Demonstrates multi­dimension array indexing.
#  Assumes row­major ordering.
# ­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­

#  Data Declarations
.data

mdArray: 	.word 11, 12, 13, 14, 15
         	.word 16, 17, 18, 19, 20
		.word 21, 22, 23, 24, 25
	 	.word 26, 27, 28, 29, 30
	 	.word 31, 32, 33, 34, 35

size: 		.word 5
dSum: 		.word 0

DATASIZE:	.word 4 		# 4 bytes for words

finalMsg: 	.ascii "Two­Dimensional Diagonal" 
	  	.ascii "Summation\n\n"
	  	.asciz "Diagonal Sum = "


# ­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­
#  Text/code section
.text
.globl main

main:

# ­­­­­
#  Call function to sum the diagaonal
# (of square two­dimensional array)

    la  a0, mdArray 	# base address of array
    lw  a1, size 		# array size
    jal diagSummer
    sw  a0, dSum, t0

# ­­­­­
#  Display final result.

    li  a7, 4 			# print prompt string
    la  a0, finalMsg
    ecall
    
    li  a7, 1 			# print integer
    lw  a0, dSum
    ecall

# ­­­­­
# Done, terminate program.

    li  a7, 10 			# call code for terminate
    ecall 				# system call

.end main


# ­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­
#  Simple function to sum the diagonals of a
#  square two­dimensional array.

#  Approach
#	loop i = 0 to len­1
#		sum = sum + mdArray[i][i]

#  Note, for two­dimensional array:
#   addr = baseAddr+(rowIndex*colSize+colIndex) * dataSize
#  Since the two­dimensional array is given as square, the 
#  row and column dimensions are the same (i.e., size).

# ­­­­­
#  Arguments
#	$a0 ­ array base address
#	$a1 ­ size (of square two­dimension array)
#  Returns
#	$a0 ­ sum of diagonals

.globl diagSummer

diagSummer:

    li  t0, 0 				# sum=0
    li  t1, 0 				# loop index, i=0
    mv  t2, a0

diagSumLoop:
    mul t3, t1, a1 			# (rowIndex * colSize
    add t3, t3, t1 			#              + colIndex)
							# note, rowIndex=colIndex
    lw	t5, DATASIZE
    mul t3, t3, t5 			#              * dataSize
    add t4, a0, t3 			# + base address

    lw  t5, (t4) 			# get mdArray[i][i]

    add t0, t0, t5 			# sum = sum+mdArray[i][i]

    addi t1, t1, 1			# i = i + 1
    blt t1, a1, diagSumLoop

    mv	a0, t0
    ret



