/*
		MIPS top level module		
*/

module mipstop(input  logic clk, reset, 
			   output logic [31:0] writedata, dataadr,
			   output 	bit [31:0] DataMem[9:0],
			   output logic [31:0] Register[31:0]);

	logic [31:0] pc, instr, readdata;
	logic sb;
  
	// instantiate processor and memories
	mips mips(clk, reset, instr, readdata, pc, memwrite, sb, dataadr, writedata, Register);

	imem imem(pc[7:2], instr);

	dmem dmem(clk, memwrite, sb, dataadr, writedata, readdata, DataMem);
endmodule
