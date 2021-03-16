module controller(input logic 		 clk, reset,
				  input logic  [5:0] opD, functD,
                  input logic		 flushE, equalD,
                  output logic 		 memtoregE, memtoregM,
				  output logic 		 memtoregW, memwriteM,
				  output logic 		 pcsrcD, branchD, bneD, alusrcE,
				  output logic [1:0] regdstE,
				  output logic 		 regwriteE, regwriteM, regwriteW, jumpD,
				  output logic 		 jalD, jalW, jrD, lbW, sbM,
				  output logic 		 multordivE, hlwriteE, hlwriteM, hlwriteW,
				  output logic [1:0] mfhlW,
				  output logic [3:0] alucontrolE);

	logic [1:0] aluopD;
	logic 		memtoregD, memwriteD, alusrcD;
	logic [1:0] regdstD;	
	logic 		regwriteD;
	logic [3:0] alucontrolD;
	logic 		memwriteE;
	logic 		lbD, lbE, lbM, sbD, sbE;
	logic 		jalE, jalM;
	logic 		multordivD, hlwriteD;
	logic [1:0] mfhlD, mfhlE, mfhlM;

	maindec md(opD, functD, memtoregD, memwriteD, branchD, bneD,
			   alusrcD, regdstD, regwriteD, jumpD, jalD, jrD, lbD, sbD,
			   multordivD, hlwriteD, mfhlD, aluopD);

	aludec  ad(functD, aluopD, alucontrolD);

	// pipeline registers
	floprc #(17) IDEX(clk, reset, flushE, //ID-EX REG
					 {memtoregD, memwriteD, alusrcD, regdstD, regwriteD, alucontrolD, jalD, lbD, multordivD, hlwriteD, mfhlD, sbD},
					 {memtoregE, memwriteE, alusrcE, regdstE, regwriteE, alucontrolE, jalE, lbE, multordivE, hlwriteE, mfhlE, sbE});

	flopr #(9) EXMEM(clk, reset, //EX-MEM REG
				   {memtoregE, memwriteE, regwriteE, jalE, lbE, hlwriteE, mfhlE, sbE},
				   {memtoregM, memwriteM, regwriteM, jalM, lbM, hlwriteM, mfhlM, sbM});

	flopr #(7) MEMWB(clk, reset, //MEM-WB REG
				   {memtoregM, regwriteM, jalM, lbM, hlwriteM, mfhlM},
				   {memtoregW, regwriteW, jalW, lbW, hlwriteW, mfhlW});
				   
	assign pcsrcD = (branchD & equalD) | (bneD & ~equalD); // PCSrc
	
	property pipelineFlushed;
		@(posedge clk) disable iff (reset)
		flushE |=> ({memtoregE, memwriteE, alusrcE, regdstE, regwriteE, alucontrolE, jalE, lbE, multordivE, hlwriteE, mfhlE, sbE} =='0);
	endproperty
	assert property(pipelineFlushed) else $warning("pipeline is not being flushed properly");
	
	property pipelinedIDEX;
		@(posedge clk) disable iff (reset | flushE)
		(opD) |=> ({memtoregE, memwriteE, alusrcE, regdstE, regwriteE, alucontrolE, jalE, lbE, multordivE, hlwriteE, mfhlE, sbE} ==
		$past({memtoregD, memwriteD, alusrcD, regdstD, regwriteD, alucontrolD, jalD, lbD, multordivD, hlwriteD, mfhlD, sbD}));
	endproperty	
	c1: assert property(pipelinedIDEX) else $warning("pipeline at IDEX is not working correctly");
	
	property pipelinedEXMEM;
	    @(posedge clk) disable iff (reset | flushE)
		(opD) |=> ({memtoregM, memwriteM, regwriteM, jalM, lbM, hlwriteM, mfhlM, sbM} ==
		$past({memtoregE, memwriteE, regwriteE, jalE, lbE, hlwriteE, mfhlE, sbE}));
	endproperty
	c2: assert property(pipelinedEXMEM) else $warning("pipeline at EXMEM is not working correctly");
	
	property pipelinedMEMWB;
	    @(posedge clk) disable iff (reset | flushE)
		(opD) |=> ({memtoregW, regwriteW, jalW, lbW, hlwriteW, mfhlW} == $past({memtoregM, regwriteM, jalM, lbM, hlwriteM, mfhlM}));
	endproperty
	c3:assert property(pipelinedMEMWB) else $warning("pipeline at MEMWB is not working correctly");
	
endmodule