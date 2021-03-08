//External memories used by MIPS processor
//Instruction Memory
module imem(input  logic [5:0]  a,
            output logic [31:0] rd);

	logic [31:0] InstMem[39:0];		

	initial
    begin
      $readmemh("C:/Users/airum/Desktop/src/test1.dat", InstMem); // initialize memory
    end

	assign rd = InstMem[a]; // word aligned
endmodule

//Data Memory
module dmem(input  logic        clk, we, sb, //sb signal to store byte or word
            input  logic [31:0] a, wd,
            output logic [31:0] rd);

	logic [31:0] DataMem[9:0];

	assign rd = DataMem[a[31:2]]; // word aligned
  
	always @(posedge clk)
    if (we)
		if(sb)
			DataMem[a[31:2]] <= {DataMem[a[31:2]][31:8], wd[7:0]};
		else
			DataMem[a[31:2]] <= wd;

endmodule