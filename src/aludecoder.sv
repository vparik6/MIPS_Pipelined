module aludec(input  logic [5:0] funct,
              input  logic [1:0] aluop,
              output logic [3:0] alucontrol);

	always_comb
		case(aluop)
			2'b00: alucontrol = 4'b0010;  // JR, MULT, DIV, MFLO, MFHI, LW, SW, LB, SB, ADDI, J, JAL
			2'b01: alucontrol = 4'b1010;  // BEQ, BNE
			2'b11: alucontrol = 4'b1011;  // SLTi
			default: case(funct)          // RTYPE
						6'b100000: alucontrol = 4'b0010; // ADD
						6'b100010: alucontrol = 4'b1010; // SUB
						6'b100100: alucontrol = 4'b0000; // AND
						6'b100101: alucontrol = 4'b0001; // OR
						6'b100111: alucontrol = 4'b0011; // NOR
						6'b100110: alucontrol = 4'b0111; // XOR
						6'b101010: alucontrol = 4'b1011; // SLT
						6'b000000: alucontrol = 4'b0100; // SLL
						6'b000010: alucontrol = 4'b0101; // SRL
						default:   alucontrol = 4'bxxxx; // ???
					endcase
		endcase
endmodule