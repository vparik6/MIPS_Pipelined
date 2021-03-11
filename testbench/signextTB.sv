module signextTB;
	parameter WIDTH = 16;
	bit [WIDTH-1:0] a;
	bit [1:0] extop;
	bit [31:0] y;

	signext #(WIDTH) uut(.*);
	
	initial begin
		$monitor("a=%b, extop=%b, y=%b", a, extop, y);
		a = 16'hFFF0; extop = 2'b00; #1;
		if (y !== 32'h0000FFF0) $display("Error in zero extend");
		extop = 2'b01; #1;
		if (y !== 32'hFFFFFFF0) $display("Error in sign extend");
		extop = 2'b10; #1; 
		if (y !== 32'hFFF00000) $display("Error to load upper immediate");
		a = 16'h00FF; #1;
		if (y !== 32'h00FF0000) $display("Error to load upper immediate");
		extop = 2'b01; #1;
		if (y !== 32'h000000FF) $display("Error in sign extend");
		extop = 2'b00; #1;
		if (y !== 32'h000000FF) $display("Error in zero extend");	
		$finish;
	end
	
endmodule