module controller(input  logic [5:0] op, funct,
                  input  logic       zero,
                  output logic       memtoreg, memwrite,
                  output logic       pcsrc, 
				  output logic [1:0] alusrc,
                  output logic       regdst, regwrite,
                  output logic       jump,
                  output logic [2:0] alucontrol);

  logic [1:0] aluop;
  logic       branch;

  maindec md(op, memtoreg, memwrite, branch,
             alusrc, regdst, regwrite, jump,
             aluop);
  aludec  ad(funct, aluop, alucontrol);

  assign pcsrc = (branch & zero) || (branch & ~zero & regdst);
endmodule

module maindec(input  logic [5:0] op,
               output logic       memtoreg, memwrite,
               output logic       branch, 
			   output logic [1:0] alusrc,
               output logic       regdst, regwrite,
               output logic       jump,
               output logic [1:0] aluop);

  logic [9:0] controls;

  assign {regwrite, regdst, alusrc,
          branch, memwrite,
          memtoreg, jump, aluop} = controls;

  always_comb
    case(op)
      6'b000000: controls = 10'b1100000010; //Rtype
      6'b100011: controls = 10'b1001001000; //LW
      6'b101011: controls = 10'b0001010000; //SW
      6'b000100: controls = 10'b0000100001; //BEQ
	  6'b000101: controls = 10'b0100100001; //BNE
      6'b001000: controls = 10'b1001000000; //ADDI
	  6'b001101: controls = 10'b1010000011; //ORI
      6'b000010: controls = 10'b0000000100; //J
      default:   controls = 10'bxxxxxxxxxx; //???
    endcase
endmodule

module aludec(input  logic [5:0] funct,
              input  logic [1:0] aluop,
              output logic [2:0] alucontrol);

  always_comb
    case(aluop)
      2'b00: alucontrol = 3'b010;  // add
      2'b01: alucontrol = 3'b110;  // sub
	  2'b11: alucontrol = 3'b001;  // OR
      default: case(funct)          // RTYPE
          6'b100000: alucontrol = 3'b010; // ADD
          6'b100010: alucontrol = 3'b110; // SUB
          6'b100100: alucontrol = 3'b000; // AND
          6'b100101: alucontrol = 3'b001; // OR
          6'b101010: alucontrol = 3'b111; // SLT
          default:   alucontrol = 3'bxxx; // ???
        endcase
    endcase
endmodule