# test2.asm
main: ori $8, $0, 0x8000
addi $9, $0, -32768
ori $10, $8, 0x8001
beq $8, $9, there
slt $11, $9, $8
bne $11, $0, here
j there
here: sub $10, $10, $8
ori $8, $8, 0xFF
there: add $11, $11, $10
sub $8, $10, $8
sw $8, 82($11)