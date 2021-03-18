// Components used in MIPS processor
// register files
module regfile(input  logic        clk, we3, 
               input  logic [4:0]  ra1, ra2, wa3, 
               input  logic [31:0] wd3, 
               output logic [31:0] rd1, rd2,
			   output logic [31:0] Register[31:0]);

	always_ff @(negedge clk)
		if (we3) 
			Register[wa3] <= wd3;	

	assign rd1 = (ra1 != 0) ? Register[ra1] : 0;
	assign rd2 = (ra2 != 0) ? Register[ra2] : 0;
endmodule
// adder
module adder(input  logic [31:0] a, b,
             output logic [31:0] y);

	assign y = a + b;
endmodule
// shift left by 2
module sl2(input  logic [31:0] a,
           output logic [31:0] y);

	assign y = a << 2;
endmodule
// comparator
module eqcmp(input logic [31:0] a, b,
			 output logic 		isEqual);
	
	assign isEqual = (a === b) ? 1 : 0;
endmodule

/*
 extop: 2'b00 - zeros extend
		2'b01 - sign extend
		2'b10 - lui
*/
module signext #(parameter WIDTH = 16)
				(input logic [WIDTH-1:0] a,
				 input [1:0] extop,
				 output logic [31:0] y);
	always_comb
		case(extop)
			2'b00:
				y = {{(32-WIDTH){1'b0}}, a};
			2'b01:
				y = {{(32-WIDTH){a[WIDTH-1]}}, a};
			2'b10:
				y = {a,{(32-WIDTH){1'b0}}};
			default:
				y = '0;
		endcase
endmodule


module flopr #(parameter WIDTH = 8)
              (input  logic  clk, reset,
               input  logic [WIDTH-1:0] d, 
               output logic [WIDTH-1:0] q);

	always_ff @(posedge clk, posedge reset)
		if (reset) q <= 0;
		else       q <= d;
endmodule

module floprc #(parameter WIDTH = 8)
			   (input logic  clk, reset, clear,
				input logic  [WIDTH-1:0] d,
				output logic [WIDTH-1:0] q);

	always_ff @(posedge clk, posedge reset)
		if 		(reset)	q <= 0;
		else if (clear) q <= 0;
		else 			q <= d;
endmodule

module flopenr #(parameter WIDTH = 8)
                (input  logic             clk, reset, en,
                 input  logic [WIDTH-1:0] d, 
                 output logic [WIDTH-1:0] q);
 
	always_ff @(posedge clk, posedge reset)
		if      (reset) q <= 0;
		else if (en)    q <= d;
endmodule

module flopenrc #(parameter WIDTH = 8)
				 (input logic 			   clk, reset,
				  input logic 			   en, clear,
				  input logic  [WIDTH-1:0] d,
				  output logic [WIDTH-1:0] q);

	always_ff @(posedge clk, posedge reset)
		if 		(reset) q <= 0;
		else if (clear) q <= 0;
		else if (en) 	q <= d;
endmodule

module mux2 #(parameter WIDTH = 8)
             (input  logic [WIDTH-1:0] d0, d1, 
              input  logic             s, 
              output logic [WIDTH-1:0] y);

	assign y = s ? d1 : d0; 
endmodule

module mux3 #(parameter WIDTH = 8)
             (input  logic [WIDTH-1:0] d0, d1, d2,
              input  logic [1:0]       s, 
              output logic [WIDTH-1:0] y);

	assign y = s[1] ? d2 : (s[0] ? d1 : d0); 
endmodule

module mux4 #(parameter WIDTH = 8)
             (input  logic [WIDTH-1:0] d0, d1, d2, d3,
              input  logic [1:0]       s, 
              output logic [WIDTH-1:0] y);

	always_comb
		case(s)
			2'b00: y = d0;
			2'b01: y = d1;
			2'b10: y = d2;
			2'b11: y = d3;
		endcase
endmodule

// high and low assignment unit
module hiandlo(input logic 		   clk, we,
			   input logic  [31:0] wdhi, wdlo,
			   output logic [31:0] rdhi, rdlo);

	logic [31:0] hi, lo;

	always @(posedge clk)
	begin
		if (we)
		begin
			hi <= wdhi;
			lo <= wdlo;
		end
	end 
	
	assign rdhi = hi;
	assign rdlo = lo;
endmodule

//division and multiplication unit
module multdivunit(input logic 	[31:0] a, b,
				   input logic 		   multordiv,
				   output logic [31:0] hi, lo);

	always_comb
		if (multordiv)
			{hi, lo} = a * b;
		else
		begin
			lo = a / b;
			hi = a % b;
		end
endmodule