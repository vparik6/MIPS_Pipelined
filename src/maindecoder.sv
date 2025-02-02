module maindec(input  logic [5:0] op, funct,
               output logic       memtoreg, memwrite,
               output logic       branch, bne, alusrc,
			   output logic [1:0] regdst,
			   output logic 	  regwrite,
			   output logic 	  jump, jal, jr, lb, sb,
			   output logic 	  multordiv, hlwrite,
			   output logic [1:0] mvhl,
			   output logic [1:0] aluop);

	logic [18:0] controls;

	assign {regwrite, regdst, alusrc, branch, bne,
			memwrite, memtoreg, jump, jal, jr, lb, sb,
			multordiv, hlwrite, mvhl, aluop} = controls;

	always_comb
		case(op)
			6'b000000: //Rtype
				case(funct)
					6'b001000: controls = 19'b0_0000_0000_0100_0000_00; //JR
					6'b011000: controls = 19'b0_0000_0000_0000_1100_00; //MULT
					6'b011010: controls = 19'b0_0000_0000_0000_0100_00; //DIV
					6'b010010: controls = 19'b1_0100_0000_0000_0001_00; //MFLO
					6'b010000: controls = 19'b1_0100_0000_0000_0010_00; //MFHI	
					default:   controls = 19'b1_0100_0000_0000_0000_10; //Rtype
				endcase
			6'b100011: controls = 19'b1_0010_0010_0000_0000_00; //LW
			6'b101011: controls = 19'b0_0010_0100_0000_0000_00; //SW
			6'b000100: controls = 19'b0_0001_0000_0000_0000_01; //BEQ
			6'b000101: controls = 19'b0_0000_1000_0000_0000_01; //BNE
			6'b001000: controls = 19'b1_0010_0000_0000_0000_00; //ADDI
			6'b000010: controls = 19'b0_0000_0001_0000_0000_00; //J
			6'b100000: controls = 19'b1_0010_0010_0010_0000_00; //LB
			6'b000011: controls = 19'b1_1000_0001_1000_0000_00; //JAL
			6'b001010: controls = 19'b1_0010_0000_0000_0000_11; //SLTI
			6'b101000: controls = 19'b0_0010_0100_0001_0000_00; //SB
			default:   controls = 19'bxxxxxxxxxxxxxxxxxxx; //???
		endcase
endmodule