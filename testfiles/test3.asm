# read after write test
main: addi $2, $0, 8765  # $2 = 0000223D
      sw $2, 4($0)       # [4] = 0000223D
      lw $3, 4($0)       # $3 = 0000223D
      add $5, $3, $3     # $5 = 0000447A
      