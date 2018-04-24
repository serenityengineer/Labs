# Working with variables in memory

    .data   # Data declaration section

varA:   .word   1
varB:   .word   2
varC:   .word   10
varD:   .word   20
varE:   .word   0

    .text

main:       # Start of code section

    # Read variables from memory to registers (option 1)
    la  t0, varA        # Load A
    lw  s0, 0(t0)

    la  t0, varB        # Load B
    lw  s1, 0(t0)

    la  t0, varC        # Load C
    lw  s2, 0(t0)

    la  t0, varD        # Load D
    lw  s3, 0(t0)

    
    # Read variables from memory to registers (option 2)
    lw  s4, varA        # Load A
    lw  s5, varB        # Load B
    lw  s6, varC        # Load C
    lw  s7, varD        # Load D

    
    # Store register value to memory variable (option 1)
    sw  s0, varE, t0
    sw  s1, varE, t0
    sw  s2, varE, t0
    sw  s3, varE, t0

    # Store register value to memory variable (option 2)
    la  t0, varE
    sw  s4, 0(t0)
    sw  s5, 0(t0)
    sw  s6, 0(t0)
    sw  s7, 0(t0)
    
    
    li  a7,10       #system call for an exit
    ecall

# END OF PROGRAM
