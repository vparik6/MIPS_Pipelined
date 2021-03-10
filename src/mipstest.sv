// Testbench for top level
module mipstest();

  bit          clk;
  logic        reset;
  logic [31:0] writedata, dataadr;
  logic        memwrite;

  // instantiate device to be tested
  mipstop dut(clk, reset, writedata, dataadr, memwrite);
  
  initial
    begin
      reset <= 1; # 12; reset <= 0;
    end

  initial begin
	  forever #5 clk = ~clk;
  end

  // check that address 8 has data 'h04ee9112
  always@(negedge clk)
    begin
        if(dataadr == 8 & writedata == 'h04ee9112) begin
          $display("Simulation succeeded");
          $stop;
		end
    end
endmodule