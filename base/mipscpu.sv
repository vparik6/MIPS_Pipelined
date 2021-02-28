###########Files Needed###########
mipscpu.sv
mipscpu_tb.sv
mux.sv  (mux_pc, mux_ex1, mux_ex2, mux_wb)
ProgramCounter.sv
InstructionMemory.sv
ControlUnit.sv
SignExtend.sv (done)
RegisterFile.sv
DataMemory.sv
StallUnit.sv
IF_ID.sv
ID_EX.sv
EX_MEM.sv
MEM_WB.sv
alu.sv
##################################

module mipscpu(clk,reset);
	input clk, reset;

	wire [31:0] PCPlus4F;
	wire [31:0] PCPlus4D;
	wire [31:0] PCPlus4E;
	wire [31:0] PCBranchE, PCBranchM;
	wire PCSrcM;
	wire [31:0] pc_in;
	wire [31:0] pc_out;
	wire [31:0] InstrF;
	wire [31:0] InstrD;
	wire stallF, stallD, FlushE;
	wire [31:0] rd1_ID, rd2_ID, rd1_EX, rd2_EX;
	wire [31:0] SignImmD, SignImmE;
	wire [4:0] RsD, RtD, RdD;
	wire [4:0] RsE, RtE, RdE;
	wire [4:0] WriteRegE, WriteRegM, WriteRegW;
	wire [31:0] SrcAE, SrcBE, WriteDataE, WriteDataM;
	wire [31:0] ALUOutE, ALUOutM, ALUOutW;
	wire [31:0] ReadDataM, ReadDataW;
	wire [31:0] ResultW;
	
	wire RegWriteD,MemtoRegD,MemWriteD,ALUSrcD,RegDstD,BranchD;
	wire RegWriteE,MemtoRegE,MemWriteE,ALUSrcE,RegDstE,BranchE;
	wire [2:0] ALUControlD,ALUControlE;
	wire RegWriteM,MemtoRegM,MemWriteM,BranchM;
	wire RegWriteW,MemtoRegW;

	
	//  Fetch Stage	
	mux_pc m1(PCSrcM,PCBranchM,PCPlus4F,pc_in);
	
	ProgramCounter pc(clk,reset,pc_in,stallF,pc_out);
	
	InstructionMemory inst(pc_out,InstrF);
	
	IF_ID fd(clk,reset,InstrF,PCPlus4F,stallD,InstrD,PCPlus4D);
 	
	assign PCPlus4F = pc_out+4;
	
	
	//  Decode Stage
	ControlUnit ctr(InstrD[31:26],InstrD[5:0],RegWriteD,MemtoRegD,MemWriteD,ALUControlD,ALUSrcD,RegDstD,BranchD);
	
	SignExtend se(InstrD[15:0],SignImmD);
	
    RegisterFile rf(.clk(clk),.reset(reset),A1(InstrD[25:21]),.A2(InstrD[20:16]),.A3(WriteRegW),.WD3(ResultW),,WE3(RegWriteW),.RD1(rd1_ID),.RD2(rd2_ID));
	
	ID_EX ie(clk,reset,FlushE,RegWriteD,MemtoRegD,MemWriteD,ALUControlD,ALUSrcD,RegDstD,BranchD,rd1_ID,rd2_ID,RsD,RtD,RdD,SignImmD,PCPlus4D, //input signals
				rd1_EX,rd2_EX,RsE,RtE,RdE,SignImmE,PCPlus4E);    //output signals
	
	assign RsD = InstrD[25:21];
	assign RtD = InstrD[20:16];
	assign RdD = InstrD[15:11];
	
	
	//  Execute Stage
    mux_ex1 m2(RegDstE,RtE,RdE,WriteRegE);
	
	mux_ex2 m3(ALUSrcE,rd2_EX,SignImmE,SrcBE);
	
	alu a(ALUControlE,SrcAE,SrcBE,ZeroE,ALUOutE);
	
	EX_MEM em(clk,reset,RegWriteE,MemtoRegE,MemWriteE,BranchE,ZeroE,ALUOutE,WriteDataE,WriteRegE,PCBranchE, //input signals
				  RegWriteM,MemtoRegM,MemWriteM,BranchM,ZeroM,ALUOutM,WriteDataM,WriteRegM,PCBranchM);  //output signals
	
	
	assign SrcAE = rd1_EX; 
	assign WriteDataE = rd2_EX;
	assign PCBranchE = SignImmE[31:2]+PCPlus4E;
	
	
	// Memory Access Stage
    DataMemory d(clk,MemWriteM,ALUOutM,WriteDataM,ReadDataM);
		
    MEM_WB mw(clk,reset,RegWriteM,MemtoRegM,ReadDataM,ALUOutM,WriteRegM,  //inpust signals
		      RegWriteW,MemtoRegW,ReadDataW,ALUOutW,WriteRegW);          //output signals
	
	assign PCSrcM = BranchM&ZeroM;
	
	
	// Write Back Stage
	mux_wb m4(MemtoRegW,ALUOutW,ReadDataW,ResultW);
	
	
	// Stall Unit
	StallUnit su(MemtoRegE,RegWriteM,RegWriteW,stallF,stallD,FlushE);

endmodule


############Work Distribution##############
P1: pc, instruction memory, data memory, register file, alu
P2: control unit
P3: stall unit, Mux
P4: (IF_ID), ID_EX, EX_MEM, (MEM_WB)