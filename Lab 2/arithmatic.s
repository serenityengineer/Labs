
main :
addi t0, zero, 15 # A
addi t1, zero, 10 # B
addi t2, zero, 5 # C
addi t3, zero, 2 # D
addi t4, zero, 18 # E
addi t5, zero, 0 # Z

sub t1, t0, t1 # using B's temp register because we only use B once
mul t6, t2, t3 

add t3, t1, t6 # first part of Z

sub t0, t4, t5 
div t1, t0, t2

sub t6, t0, t1 # second part of Z

add a1, t3, t6 # Z's total value
