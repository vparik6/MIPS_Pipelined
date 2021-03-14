// Testbench for top level

module mipstest();

    bit          clk;
    bit          reset = 1'b1;
    logic [31:0] writedata, dataadr;
    logic [31:0] DataMem[9:0];
    logic [31:0] Register[31:0];
	bit   [3:0]  pass_flag;
    // instantiate device to be tested
    mipstop dut(clk, reset, writedata, dataadr, DataMem, Register);

    initial begin
      #0; reset = 0;
	  forever #5 clk = ~clk;
    end

    // check that address 8 has data 'h04ee9112
    initial
    begin
		repeat(14) @(negedge clk);
		if(Register[23] == 'h8) begin
			$display("ALU test passed");
			pass_flag[0] = 1'b1;
		end
		repeat(8) @(negedge clk);
		if(DataMem[6] == 'hab) begin
			$display("Load byte store byte test passed");
			pass_flag[1] = 1'b1;		
		end
		repeat(11) @(negedge clk);
		if(Register[27] == 'h447a) begin
			$display("RAW test passed");
			pass_flag[2] = 1'b1;		
		end
		repeat(36) @(negedge clk);
        if(dataadr == 8 && writedata == 'h04ee9112) begin
		    pass_flag[3] = 1'b1;
		    assert(pass_flag == 4'b1111) else begin
				  $display("Did not pass the full test");
				  $stop;
		    end
            $display("Passed full instruction set test\n");    
            $display("Final Data Memory and register values: ");
		    foreach(DataMem[i])
			   if(DataMem[i] !== 'x) $display("Mem[%0d] = %h",i,DataMem[i]);
		    foreach(Register[i])
			   if(Register[i] !== 'x) $display("Register[%0d] = %h",i,Register[i]);	
            $stop;
		end
    end

endmodule