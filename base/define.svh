`ifndef MIPS_DEFINE
`define MIPS_DEFINE

// instruction set
`define opcode_rtype 6'h00
`define funct_add    6'h20
`define funct_sub    6'h22
`define funct_and    6'h24
`define funct_or     6'h25
`define funct_xor    6'h26
`define funct_nor    6'h27
`define funct_slt    6'h2A

`define opcode_addi  6'h08
`define opcode_andi  6'h0c
`define opcode_lw    6'h23
`define opcode_sw    6'h2B
`define opcode_andi  6'h0c
`define opcode_beq   6'h04
`define opcode_jump  6'h02


`define opcode  31:26

// R type instruction
`define r_rs    25:21
`define r_rt    20:16
`define r_rd    15:11
`define r_shift 10:6
`define r_funct 5:0
// I type instruction
`define i_rs    25:21
`define i_rt    20:16
`define i_imm   15:0
// J type instruction
`define j_target 25:0


`endif