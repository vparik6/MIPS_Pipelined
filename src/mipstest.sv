// Testbench for top level
`timescale 1ns/1ns
module mipstest();

    bit          clk;
    bit          reset = 1'b1;
    logic [31:0] writedata, dataadr;
    bit [31:0] DataMem[9:0];
    logic [31:0] Register[31:0];
	int error;
    // instantiate device to be tested
    mipstop dut(clk, reset, writedata, dataadr, DataMem, Register);

    initial begin
      #0 reset = 0;
	  forever #5 clk = ~clk;
    end

    initial
    begin
		repeat(14) @(negedge clk);
		if(Register[23] == 32'h8) $display("ALU test passed");
		else error++;

		repeat(8) @(negedge clk);
		if(DataMem[6] == 32'hab)  $display("Load byte store byte test passed");
	        else error++;
		
		repeat(11) @(negedge clk);
		if(Register[27] == 32'h447a)  $display("RAW test passed");
		else error++;		
		
		repeat(36) @(negedge clk);
                if(dataadr == 8 && writedata == 32'h04ee9112)  $display("Passed full instruction set test\n"); 
		else error++;
	    
		assert(error == 0) else begin
			$display("Did not pass the full test");
			$stop;
		end
		$display("%0b erros found in the test", error);
		$display("Final Data Memory and register values: ");
		foreach(DataMem[i])
			if(DataMem[i] !== 'x) $display("Mem[%0d] = %h",i,DataMem[i]);
		foreach(Register[i])
			if(Register[i] !== 'x) $display("Register[%0d] = %h",i,Register[i]);
        $finish;
    end
endmodule