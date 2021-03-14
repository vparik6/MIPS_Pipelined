//External memories used by MIPS processor
//Instruction Memory
module imem(input  logic [5:0]  a,
            output logic [31:0] rd);

	logic [31:0] InstMem[70];		// Instruction memory array of size 70
	// supported opcode/func by mips processor 
    bit [5:0] validOpcode[] = '{'h08,'h00,'h23,'h2b,'h20,'h28,'h04,'h05,'h0a,'h02,'h03};
	bit [5:0] validFunc[] = '{'h00,'h02,'h08,'h18,'h1a,'h12,'h10,'h20,'h22,'h24,'h25,'h26,'h27,'h2a};
	
	initial
    begin
      $readmemh("C:/Users/airum/Desktop/src/final.dat", InstMem); // initialize memory      
      checkInstr();
    end
    
    task checkInstr;
      foreach(InstMem[i]) begin
        if(InstMem[i] !== 'x) begin 
		     assert (InstMem[i][31:26] inside {validOpcode}) else begin
		          $warning("Line %0d: Cannot decode the opcode (%b) into a valid instruction", i+1, InstMem[i][31:26]);
				  InstMem[i] = '0;      // assert nop
		     end
			 if(InstMem[i][31:26] == 'h00) assert (InstMem[i][5:0] inside {validFunc}) else begin
				  $warning("Line %0d: Cannot decode the function (%b) into a valid instruction", i+1, InstMem[i][5:0]);
				  InstMem[i] = '0;      // assert nop
			 end
	    end 
	  end 
    endtask

	assign rd = InstMem[a]; // word aligned
	
endmodule

//Data Memory
module dmem(input  logic  clk, we, sb, //sb signal to store byte or word
            input  logic [31:0] a, wd,
            output logic [31:0] rd,
			output bit [31:0] DataMem[9:0]);
    
    initial begin
        DataMem[5] = 32'hABCD1234;
    end
	assign rd = DataMem[a[31:2]]; // word aligned
  
	always @(posedge clk)
    if (we)
		if(sb)
			DataMem[a[31:2]] <= {DataMem[a[31:2]][31:8], wd[7:0]};
		else
			DataMem[a[31:2]] <= wd;
	
	property writecheck;
		@(posedge clk) we |-> (!$isunknown(wd));
	endproperty
	assert property(writecheck) else $warning("write data is unknown");
	
endmodule