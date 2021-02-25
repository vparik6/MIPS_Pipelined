module RCA_32bit(
	input logic [31:0] A, B, 
	input logic cin,
	output logic [31:0] sum,
	output logic OF);
	logic [31:0]cout;

	adderr f(A[0], B[0], cin, sum[0], cout[0]);
	genvar i;
	generate
		for(i = 1; i < 32; i++) 
		begin: ADD
			adderr f0(A[i], B[i], cout[i-1], sum[i], cout[i]);
		end: ADD
	endgenerate
	
	assign OF = cout[30]^cout[31];
endmodule

module adderr(input logic a, b, cin, output logic sum, cout);
  	assign sum = a^b^cin;
  	assign cout = (a&b | (cin & (a^b)));
endmodule //adder