module aludecTB();

	logic [5:0] funct;
	logic [1:0] aluop;
	logic [3:0] alucontrol;
	
	logic clk = 0;
	logic [11:0] testvector[0:29];
	logic [3:0] expected_output;
	logic [31:0] index, errors;
	
	aludec DUT(.*);
	
	always #5 clk = ~clk;
			
	initial begin
		$readmemb("C:/Users/visha/Downloads/2. Winter 2021/ECE 571/MIPS_Pipelined/testfiles/aludec_test.txt", testvector); //change testvec location before running test
		index = 0; errors = 0;
		$monitor("index = %0d, testvector = %b", index, testvector[index]);
	end
	
	always_ff@(posedge clk)
		{funct, aluop, expected_output} = testvector[index];
	
	always@(negedge clk) begin
        if(expected_output != alucontrol)
            begin
                $display("Error: aluop=%b, funct=%b", aluop, funct);
                $display("Output = %b, expected = %b", alucontrol, expected_output);
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