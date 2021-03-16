module alu(input logic [31:0]  A, B,
		   input logic [3:0]   F,
		   input logic [4:0]   shamt,
		   output logic [31:0] Y,
		   output logic zero);
	
	logic [31:0] temp;

	assign zero = (Y == 32'b0);
	
	always_comb 
	begin
		case (F[3:0])
			4'b0000: Y = A & B;		   // AND
			4'b0001: Y = A | B;		   // OR
			4'b0010: Y = A + B;		   // ADD
			4'b1010: begin			   // SUB
			            if (A>=B) 
							Y = A - B;
						else begin 
							temp = ~B + 1;
						    Y = A + temp;
						end
					 end
			4'b0011: Y = ~(A | B);     // NOR
			4'b0111: Y = A ^ B;        // XOR
			4'b1011: Y = (A < B)? 1:0; // SLT
			4'b0100: Y = B << shamt;   // SLL
			4'b0101: Y = B >> shamt;   // SRL
		endcase
	end
endmodule
