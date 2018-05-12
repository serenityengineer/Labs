.data

Val1:  .float 6.45
Val2:  .float 1014.78

.text
    flw    f0, Val1, t0     # load Val1 into f0
    flw    f8, Val2, t0     # load Val2 into f8
    fadd.s f10, f0, f8      # add values
    fsw    f10, Val2, t0    # save f10 to Val2
