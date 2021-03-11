/*
MIPS pipelined processor
*/

module mips(input  logic        clk, reset,
			input  logic [31:0] instrF,
			input  logic [31:0] readdataM,
            output logic [31:0] pcF,           
            output logic 		memwriteM, sbM,
			output logic [31:0] aluoutM, writedataM,			
			output logic [31:0] Register[31:0]);
	
	logic [5:0] opD, functD;
	logic [1:0] regdstE, mfhlW;
	logic 		alusrcE, pcsrcD, memtoregE, 
				memtoregM, memtoregW, regwriteE, 
				regwriteM, regwriteW;
	logic [3:0] alucontrolE;
	logic 		flushE, equalD, jrD, jalD;

	controller c(clk, reset, opD, functD, flushE, equalD, memtoregE, memtoregM,
				memtoregW, memwriteM, pcsrcD, branchD, bneD, alusrcE, regdstE, regwriteE,
				regwriteM, regwriteW, jumpD, jalD, jalW, jrD, lbW, sbM,
				multordivE, hlwriteE, hlwriteM, hlwriteW, mfhlW, alucontrolE);

	datapath dp(clk, reset, memtoregE, memtoregM, memtoregW, pcsrcD, branchD, bneD,
				alusrcE, regdstE, regwriteE, regwriteM, regwriteW, jumpD, jalD, jalW, jrD, lbW,
				multordivE, hlwriteE, hlwriteM, hlwriteW, mfhlW, alucontrolE, instrF, readdataM, equalD, pcF,
				aluoutM, writedataM, opD, functD, flushE, Register);
endmodule