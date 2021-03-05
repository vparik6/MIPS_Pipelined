module alu(input logic [31:0]  A, B,
		   input logic [3:0]   F,
		   input logic [4:0]   shamt,
		   output logic [31:0] Y,
		   output logic zero);
	
	logic [31:0] BorBbar, sum;
	
	assign BorBbar = F[3] ? ~B:B;
	assign sum = A + BorBbar + F[3];
	assign zero = (Y == 32'b0);
	
	always_comb 
	begin
		case (F[2:0])
			3'b000: Y = A & BorBbar;
			3'b001: Y = A | BorBbar;
			3'b010: Y = sum;
			3'b011: Y = sum[31];
			3'b100: Y = sum << shamt;
			3'b101: Y = sum >> shamt;
		endcase
	end
endmodule //32bit alu
