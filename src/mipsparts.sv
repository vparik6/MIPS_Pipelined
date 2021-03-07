// Components used in MIPS processor
module regfile(input  logic        clk, 
               input  logic        we3, 
               input  logic [4:0]  ra1, ra2, wa3, 
               input  logic [31:0] wd3, 
               output logic [31:0] rd1, rd2);

  logic [31:0] rf[31:0];
  
  always
	begin
	if(clk)
	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
        #5;
     if (we3) rf[wa3] <= wd3;
	end
endmodule

module adder(input  logic [31:0] a, b,
             output logic [31:0] y);

	assign y = a + b;
endmodule

module sl2(input  logic [31:0] a,
           output logic [31:0] y);

	assign y = {a[29:0], 2'b00}; 		// shift left by 2
endmodule

module eqcmp(input logic [31:0] a, b,
			 output logic 		isEqual);
	
	assign isEqual = (a === b) ? 1 : 0;
endmodule

module zeroext(input  logic [15:0] a,
               output logic [31:0] y);
					
	assign y = {16'b0, a};
endmodule
	
module signext(input  logic [15:0] a,
               output logic [31:0] y);
              
	assign y = {{16{a[15]}}, a};
endmodule

module signext8(input  logic [7:0]  a,
				output logic [31:0] y);

	assign y = {{24{a[7]}}, a};
endmodule

module flopr #(parameter WIDTH = 8)
              (input  logic  			clk, reset,
               input  logic [WIDTH-1:0] d, 
               output logic [WIDTH-1:0] q);

	always_ff @(posedge clk, posedge reset)
		if (reset) q <= 0;
		else       q <= d;
endmodule

module floprc #(parameter WIDTH = 8)
			   (input logic  			 clk, reset, clear,
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
			assign {hi, lo} = a * b;
		else
		begin
			assign lo = a / b;
			assign hi = a % b;
		end
endmodule