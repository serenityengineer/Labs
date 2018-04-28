addi t0, zero, 15	# A = 15
addi t1, zero, 10	# B = 10

sub t1, t0, t1		# B = A-B
 
addi t2, zero, 5	# C = 5
addi t3, zero, 2	# D = 2

mul t3, t2, t3		# D = C*D

addi t4, zero, 18	# E = 18
addi t5, zero, 3	# F = 3

sub t4, t4, t5		# E = E-F

add t1, t1, t3		# B = (A-B) + (D*C)
add t1, t1, t4  	# B = (A-B) + (D*C) + (E-F)

div t0, t0, t2		# A = A/C

sub a1, t1, t0		# a0 = (A-B) + (D*C) + (E-F) - (A/C)