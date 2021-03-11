// Testbench for top level
module mipstest();

    bit          clk;
    bit          reset;
    logic [31:0] writedata, dataadr;
    logic [31:0] DataMem[9:0];
    logic [31:0] Register[31:0];

    // instantiate device to be tested
    mipstop dut(clk, reset, writedata, dataadr, DataMem, Register);
  
    initial begin
      reset = 1; # 12; reset = 0;
    end

    initial begin
	  forever #5 clk = ~clk;
    end

    // check that address 8 has data 'h04ee9112
    always@(negedge clk)
    begin
        if(dataadr == 8 & writedata == 'h04ee9112) begin
          $display("Simulation succeeded\n\n");
          
          $display("Final Data Memory and register values: ");
		  foreach(DataMem[i])
			 if(DataMem[i] !== 'x) $display("Mem[%0d] = %h",i,DataMem[i]);
		  foreach(Register[i])
			 if(Register[i] !== 'x) $display("Register[%0d] = %h",i,Register[i]);	
          $stop;
		end
    end

endmodule