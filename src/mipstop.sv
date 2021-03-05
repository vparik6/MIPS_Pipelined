//------------------------------------------------
// Top level system including MIPS and memories
//------------------------------------------------

module mipstop(input  logic clk, reset, 
			   output logic [31:0] writedata, dataadr, 
			   output logic memwrite);

	logic [31:0] pc, instr, readdata;
	logic 		 sb; //To choose load/store 'Byte' or 'Word'
  
	// instantiate processor
	mips mips(clk, reset, pc, instr, memwrite, sb, dataadr, writedata, readdata);
	// instantiate instr memory
	imem imem(pc[7:2], instr);
	// instantiate data memory
	dmem dmem(clk, memwrite, sb, dataadr, writedata, readdata);
endmodule
