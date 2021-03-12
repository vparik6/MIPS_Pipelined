module maindecTB();

	logic [5:0] op, funct;
    logic      	memtoreg, memwrite;
    logic       branch, bne, alusrc;
    logic [1:0] regdst;
    logic 	 	regwrite;
    logic 	  	jump, jal, jr, lb, sb;
    logic 	  	multordiv, hlwrite;
    logic [1:0] mvhl;
    logic [1:0] aluop;
	
	logic clk = 0;
	logic [30:0] testvector[0:29];
	logic [18:0] expected_output;
	logic [31:0] index, errors;
	
	maindec DUT(.*);
	
	always #5 clk = ~clk;
	
	initial begin
		$readmemb("C:/Users/visha/Downloads/2. Winter 2021/ECE 571/MIPS_Pipelined/testfiles/maindec_test.txt", testvector); //change testvec location before running test
		index = 0; errors = 0;
		$monitor("index = %0d, testvector = %b", index, testvector[index]);
	end
	
	always_ff@(posedge clk)
		{op, funct, expected_output} = testvector[index];
	
	always@(negedge clk) begin
        if(expected_output != {regwrite, regdst, alusrc, branch, bne,
			memwrite, memtoreg, jump, jal, jr, lb, sb,
			multordiv, hlwrite, mvhl, aluop})
            begin
                $display("Error: op=%b, funct=%b", op, funct);
                $display("Outputs = %b, expected = %b",{regwrite, regdst, alusrc, branch, bne,
														memwrite, memtoreg, jump, jal, jr, lb, sb,
														multordiv, hlwrite, mvhl, aluop}, expected_output);
                errors = errors + 1;
            end
            index++;
        if(testvector[index]==='x)
            begin
                $display("%0d tests completed and %0d errors found", index, errors);
                $finish;
            end
	end
	
endmodule