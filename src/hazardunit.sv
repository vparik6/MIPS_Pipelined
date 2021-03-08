/*
forward=10 -> from M to E
forward=01 -> from WB to E
*/

module hazard(input logic [4:0] rsD, rtD, rsE, rtE,
			  input logic [4:0] writeregE, writeregM, writeregW,
			  input logic regwriteE, regwriteM, regwriteW,
			  input logic memtoregE, memtoregM, branchD, bneD,
			  output logic forwardaD, forwardbD,
			  output logic [1:0] forwardaE, forwardbE,
			  output logic stallF, stallD, flushE);

	logic lwstallD, branchstallD;

	// forwarding sources to D stage (branch equality)
	assign forwardaD = (rsD !=0 & rsD == writeregM & regwriteM);
	assign forwardbD = (rtD !=0 & rtD == writeregM & regwriteM);

	// forwarding sources to E stage (ALU)
	always_comb
	begin		
		if ((rsE != 0) & (rsE == writeregM) & regwriteM)        forwardaE = 2'b10;	
		else if ((rsE != 0) & (rsE == writeregW) & regwriteW)	forwardaE = 2'b01;
		else forwardaE = 2'b00;
		
		if ((rtE != 0) & (rtE == writeregM) & regwriteM)        forwardbE = 2'b10;	
		else if ((rtE != 0) & (rtE == writeregW) & regwriteW)	forwardbE = 2'b01;
		else forwardbE = 2'b00;
	end

	// stalls
	assign lwstallD = (rtE == rsD | rtE == rtD) & memtoregE;
	
	assign branchstallD = (branchD | bneD) & (regwriteE & (writeregE == rsD | writeregE == rtD) |
		   memtoregM &(writeregM == rsD | writeregM == rtD));
	assign stallD = lwstallD | branchstallD;
	assign stallF = stallD;
	assign flushE = stallD;
	
endmodule
