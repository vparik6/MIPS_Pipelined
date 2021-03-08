module hazardTB();

	logic [4:0] rsD, rtD, rsE, rtE;
	logic [4:0] writeregE, writeregM, writeregW;
	logic regwriteE, regwriteM, regwriteW;
	logic memtoregE, memtoregM, branchD, bneD;
	logic forwardaD, forwardbD;
	logic [1:0] forwardaE, forwardbE;
	logic stallF, stallD, flushE;
	
	logic clk = 0;
	logic [50:0] testvector[0:29];
	logic [8:0] expected_output;
	logic [31:0] index, errors;
	
	hazard t(.*);
	
	always #1 clk = ~clk;
	
	initial begin
		$readmemb("C:/Users/airum/Desktop/src/hazard_test.txt",testvector);
		index = 0; errors = 0;
		$monitor("index = %0d, testvector = %b", index, testvector[index]);
	end
	
	always_ff@(posedge clk)
		{rsD,rtD,rsE,rtE,writeregE,writeregM,writeregW,regwriteE,regwriteM,regwriteW,memtoregE,memtoregM,branchD,bneD,expected_output} = testvector[index];
	
	always@(negedge clk) begin
        if(expected_output!={forwardaD,forwardbD,forwardaE,forwardbE,stallF,stallD,flushE})
            begin
                $display("Error: rsD=%b, rtD=%b, rsE=%b, writeregE=%b, writeregM=%b, writeregW=%b, regwriteE=%b, regwriteM=%b, regwriteW=%b, memtoregE=%b, memtoregM=%b, branchD=%b, bneD=%b",
			             rsD,rtD,rsE,rtE,writeregE,writeregM,writeregW,regwriteE,regwriteM,regwriteW,memtoregE,memtoregM,branchD,bneD);
                $display("outputs = %b, expected = %b",{forwardaD,forwardbD,forwardaE,forwardbE,stallF,stallD,flushE}, expected_output);
                errors = errors+1;
            end
            index++;
        if(testvector[index]==='x)
            begin
                $display("%0d tests completed and %0d errors found", index, errors);
                $finish;
            end
	end
	
endmodule