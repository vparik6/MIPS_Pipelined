module controllertb();
logic	clk, reset;
logic  [5:0] opD, functD;
logic		 flushE, equalD;
logic 		 memtoregE, memtoregM;
logic 		 memtoregW, memwriteM;
logic 		 pcsrcD, branchD, bneD, alusrcE;
logic [1:0] regdstE;
logic 		 regwriteE, regwriteM, regwriteW, jumpD;
logic 		 jalD, jalW, jrD, lbW, sbM;
logic 		 multordivE, hlwriteE, hlwriteM, hlwriteW;
logic [1:0] mfhlW;
logic [3:0] alucontrolE;

controller dut (.clk(clk), .reset(reset), .opD(opD), .functD(functD), .flushE(flushE), .equalD(equalD), .memtoregE(memtoregE), .memtoregM(memtoregM), .memtoregW(memtoregW), .memwriteM(memwriteM), .pcsrcD(pcsrcD), .branchD(branchD), .bneD(bneD), .alusrcE(alusrcE), .regdstE(regdstE), .regwriteE(regwriteE), .regwriteM(regwriteM), .regwriteW(regwriteW), .jumpD(jumpD), .jalD(jalD), .jalW(jalW), .jrD(jrD), .lbW(lbW), .sbM(sbM), .multordivE(multordivE), .hlwriteE(hlwriteE), .hlwriteM(hlwriteM), .hlwriteW(hlwriteW), .mfhlW(mfhlW), .alucontrolE(alucontrolE));

initial
begin
	clk = 0;
	reset = 1; 
	forever 
		#5 clk = ~clk;
end

initial
begin
	#40;
	reset = 0;
	opD = 6'b000000;
	functD = 6'b001000;
	flushE = '0;
	equalD = '0;
	#1
	if(branchD !== '0)
		$display("Error with branchD signal");
	if (bneD !== '0)
		$display("Error with bneD signal");
	if (jumpD !== '0)
		$display("Error with jumpD signal");
	if (jalD !== '0)
		$display("Error with jalD signal");
	if (jrD !== '0)
		$display("Error with jrD signal");
	if (pcsrcD !== equalD?branchD:bneD)
		$display("Error with pcsrcD signal");
	#10
	if (memtoregE !== '0)
		$display("Error with memtoregE signal");
	if (alusrcE !== '0)
		$display("Error with alusrcE signal");
	if (regdstE !== '0)
		$display("Error with regdstE signal");
	if (regwriteE !== '0)
		$display("Error with regwriteE signal");
	if (alucontrolE !== 'x)
		$display("Error with alucontrolE signal");
	if (multordivE !== '0)
		$display("Error with multordivE signal");
	if (hlwriteE !== '0)
		$display("Error with hlwriteE signal");
	#10
	if (memtoregM !== '0)
		$display("Error with memtoregM signal");
	if (memwriteM !== '0)
		$display("Error with memwriteM signal");
	if (regwriteM !== '0)
		$display("Error with regwriteM signal");
	if (hlwriteM !== '0)
		$display("Error with hlwriteM signal");
	if (sbM !== '0)
		$display("Error with sbM signal");
	#10
	if (memtoregW !== '0)
		$display("Error with memtoregW signal");
	if (regwriteW !== '0)
		$display("Error with regwriteW signal");
	if (jalW !== '0)
		$display("Error with jalW signal");
	if (lbW !== '0)
		$display("Error with lbW signal");
	if (hlwriteW !== '0)
		$display("Error with hlwriteW signal");
	if (mfhlW !== '0)
		$display("Error with mfhlW signal");
		
	
	$finish();
end

endmodule