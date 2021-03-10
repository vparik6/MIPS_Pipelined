main:       addi $2, $0, 5 # $2 = 5                   0       20020005
	    addi $3, $0, 12 # $3 = 12                 4       2003000c
	    addi $7, $3, -9 # $7 = 3                  8       2067fff7
	    or $4, $2, $3 # $4 = (5 OR 12) = 13       c       00432025
	    and $5, $3, $4 # $5 = (12 AND 13) = 12   10       00642824
	    add $5, $5, $4 # $5 = 12 + 13 = 25       14       00a42820
	    slt $17, $7, $5 # $17 = 1 ($7 < $5)?     18       00e5882a
	    slti $18, $7, 20 # $18 = 1($7 < 20)?     1c       28f20014
	    beq $5, $7, end # shouldn't be taken     20       10a70014
	    addi $3, $0, 4095 # $3 = 0fff            24       20030fff
	    addi $16, $0, 20206 # $16 = 4eee         28       20104eee
	    mult $3, $16 # hi, lo = 04ee,9112        2c       00700018
	    mfhi $1 # $1 = hi = 04ee                 30       00000810
	    mflo $1 # $1 = lo = 9112 		      34       00000812
	    bne $4, $17, around # should be taken    38       14910001
	    addi $5, $0, 10 # shouldn't happen       3c       2005000a
around:     slt $4, $7, $2 # $4 = 3 < 5 = 1          40       00e2202a
	    sll $19, $5, 3 # $19 = $5 << 3 = 200     44       000598c0
	    srl $20, $5, 2 # $20 = $5 >> 2 = 6       48       0005a082
	    jal func  #                              4c       0c10001f
	    addi $8, $0, 31693 # $8 = 00007bcd       50       20087bcd
      	    addi $9, $0, 22136 # $9 = 00005678       54       20095678
            sw $8, 0($0) # [0] = 00007bcd            58       ac080000
            lb $10, 0($0) # $10 = ffffffcd           5c       800a0000
            lb $11, 1($0) # $11 = 0000007b           60       800b0001
            sw $9, 4($0) # [4] = 00005678            64       ac090004
            sb $11, 4($0) # [4] = 0000567b           68       a00b0004
            lw $12, 4($0) # $12 = 0000567b           6c       8c0c0004
	    j end # should be taken 3c 08000011      70       0810001e
	    addi $1, $0, 1 # shouldn't happen        74       20010001
end:        sw $1, 8($0) # [8] = 04ee9112            78       ac010008          
func:       add $6, $18, $19 # $6 = (1+200) = 201    7c       02533020
	    sub $6, $6, $5 # $6 = (201-25) = 176     80       00c53022
	    div $19, $5 # hi, lo = 8                 84       0265001a
	    mflo $14 # $1 = lo = 8      	      88       00007012
	    jr $31 # return ra                       8c       03e00008
