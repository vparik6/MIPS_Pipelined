module alu(
	input logic [31:0] A, B,
	input logic [2:0] F,
	output logic [31:0] Y,
	output logic zero);
	
	logic [31:0]BB, sum, AND, OR;
	logic SLT, OF;
	
	RCA_32bit add(A, BB, F[2], sum, OF); //sum
	//{OF,Y} = A + BB + F[2];
	always_comb 
	begin
		case (F[2])
			1'b0: BB = B; // for add
			1'b1: BB = ~B; // for sub
		endcase

		AND = A&BB; // A AND B
		OR = A|BB; //A OR B
		
		// SLT
		if (A[31] !== B[31]) begin
			if (A[31] > B[31]) SLT = 1;
			else SLT = 0;
		end 
		else begin 
			if (A < B) SLT = 1; 
			else SLT = 0; 
		end
	
		case ({F[1],F[0]})
			2'b00: Y = AND;
			2'b01: Y = OR;
			2'b10: begin
				if (OF === 1) Y = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
				else Y = sum; 
			end
			2'b11: Y = SLT;
		endcase

		if (Y == 0) zero = 1;
		else zero = 0;
	end
endmodule //32bit alu
