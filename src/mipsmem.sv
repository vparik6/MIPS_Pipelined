//External memories used by MIPS processor
//Instruction Memory
module imem(input  logic [5:0]  a,
            output logic [31:0] rd);

	logic [31:0] RAM[1023:0];

	initial
    begin
      $readmemh("C:/Users/visha/Downloads/2. Winter 2021/ECE 571/MIPS_Pipelined/src/memfile.dat", RAM); // initialize memory
    end

	assign rd = RAM[a]; // word aligned
endmodule

//Data Memory
module dmem(input  logic        clk, we, sb, //sb signal to store byte or word
            input  logic [31:0] a, wd,
            output logic [31:0] rd);

	logic [31:0] RAM[1023:0];

	assign rd = RAM[a[31:2]]; // word aligned
  
	always @(posedge clk)
    if (we)
		if(sb)
			RAM[a[31:2]] <= {RAM[a[31:2]][31:8], wd[7:0]};
		else
			RAM[a[31:2]] <= wd;
endmodule
