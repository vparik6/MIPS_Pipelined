module datapath_tb();
logic 		clk, reset;
logic  		memtoregE, memtoregM, memtoregW;
logic  		pcsrcD, branchD, bneD;
logic  		alusrcE;
logic  [1:0]  regdstE;
logic  		regwriteE, regwriteM, regwriteW;
logic  		jumpD, jalD, jalW, jrD, lbW;
logic  		multordivE, hlwriteE, hlwriteM, hlwriteW;
logic  [1:0]  mfhlW;
logic  [3:0]  alucontrolE;
logic 		equalD;
logic [31:0] pcF;
logic  [31:0] instrF;
logic [31:0] aluoutM, writedataM;
logic  [31:0] readdataM;
logic [5:0]  opD, functD;
logic 		flushE;

	logic [201:0] testvector[0:25];
	logic [109:0] expected_output;
	logic [31:0] index, errors;

datapath dut (.*);

initial begin
    
    clk=0;
end
always #5 clk = ~clk;

	initial begin
		$readmemb("D:/PSU/2nd Term/Introduction to system verilog/MIPS_pipelined/MIPS_Pipelined/testfiles/datapath_test.txt",testvector);
		index = 0; errors = 0;
        $monitor(" index = %0d, testvector = %b", index, testvector[index]);
        
	end

always_ff@(posedge clk) begin
		{reset,memtoregE, memtoregM, memtoregW,pcsrcD, branchD, bneD,alusrcE, regdstE,regwriteE, regwriteM, regwriteW,jumpD, jalD, jalW, jrD, lbW,multordivE, hlwriteE, hlwriteM, hlwriteW, mfhlW, alucontrolE,instrF, readdataM,expected_output} = testvector[index];
end

	always@(negedge clk) begin
      
        if(expected_output!={equalD, pcF,aluoutM, writedataM, opD, functD,flushE})
            begin
                //$display("Error reset = %b,memtoregE = %b, memtoregM = %b, memtoregW = %b,pcsrcD = %b, branchD = %b, bneD = %b,alusrcE = %b, regdstE = %b,regwriteE = %b, regwriteM = %b, regwriteW = %b,jumpD = %b, jalD = %b, jalW = %b, jrD = %b, lbW = %b,multordivE = %b, hlwriteE = %b, hlwriteM = %b, hlwriteW = %b, mfhlW = %b, alucontrolE = %b,instrF = %b, readdataM = %b", reset,memtoregE, memtoregM, memtoregW,pcsrcD, branchD, bneD,alusrcE, regdstE,regwriteE, regwriteM, regwriteW,jumpD, jalD, jalW, jrD, lbW,multordivE, hlwriteE, hlwriteM, hlwriteW, mfhlW, alucontrolE,instrF, readdataM);
                $display("fail outputs = %b, expected = %b",{equalD, pcF,aluoutM, writedataM, opD, functD,flushE}, expected_output);
                errors = errors+1;
            end
            index++;
        if(testvector[index]==='x)
            begin
                $display("%0d tests completed and %0d errors found", index, errors);
                $finish;
            end
	end
endmodule 

