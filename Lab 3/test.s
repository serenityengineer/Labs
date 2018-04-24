# Test program to match Lab 3 test bench

.data


.text
main:	
# Adder/Subtracter tests
    li   t0, 0x4F302C85
    li   t1, 0x7A222578
    add  t2, t0, t1
    sub  t2, t0, t1

    li   t0, 0xC0765A22
    li   t1, 0xB4059ADD
    add  t2, t0, t1
    sub  t2, t0, t1


# Shifter tests
    li   t0, 0x5a5a5a5a
    slli t1, t0, 1
    srli t1, t0, 2
    srli t1, t0, 3
    slli t1, t0, 1
	
