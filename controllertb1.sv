module controllertb ();
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

logic [4:0] 	ex_q1[$];
logic [10:0] 	ex_q2[$];
logic [4:0] 	ex_q3[$];
logic [6:0] 	ex_q4[$];
logic 			pcsrcD_exq[$];
logic [5:0]		in_op[$];
logic [5:0]		in_func[$];
logic 			flush_q[$];
logic 			equal_q[$];
logic [4:0]		out_q1[$];
logic [10:0]	out_q2[$];
logic [4:0]		out_q3[$];
logic [6:0]		out_q4[$];
logic 			pcsrcD_outq[$];

int flag;

logic [5:0] opD_in [11] = '{6'b000000, 6'b100011, 6'b101011, 6'b000100, 6'b000101, 6'b001000, 6'b000010, 6'b100000, 6'b000011, 6'b001010, 6'b101000};
logic [5:0] funct_in [12] = '{6'b100000, 6'b100010, 6'b100100, 6'b100101, 6'b101010, 6'b000000, 6'b000010, 6'b001000, 6'b011000, 6'b011010, 6'b010010, 6'b010000};
  
controller dut (.clk(clk), .reset(reset), .opD(opD), .functD(functD), .flushE(flushE), .equalD(equalD), .memtoregE(memtoregE), .memtoregM(memtoregM), .memtoregW(memtoregW), .memwriteM(memwriteM), .pcsrcD(pcsrcD), .branchD(branchD), .bneD(bneD), .alusrcE(alusrcE), .regdstE(regdstE), .regwriteE(regwriteE), .regwriteM(regwriteM), .regwriteW(regwriteW), .jumpD(jumpD), .jalD(jalD), .jalW(jalW), .jrD(jrD), .lbW(lbW), .sbM(sbM), .multordivE(multordivE), .hlwriteE(hlwriteE), .hlwriteM(hlwriteM), .hlwriteW(hlwriteW), .mfhlW(mfhlW), .alucontrolE(alucontrolE));

function void exp_outs (logic [5:0] op_in, func_in, flush_in, equal_in);

in_op.push_back(op_in);
in_func.push_back(func_in);
flush_q.push_back(flush_in);
equal_q.push_back(equal_in);

if (op_in === 6'b000000 && func_in === 6'b100000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00011001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000000 && func_in === 6'b100010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00011101000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000000 && func_in === 6'b100100)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00011000000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b000000 && func_in === 6'b100101)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00011000100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b000000 && func_in === 6'b101010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00011101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b000000 && func_in === 6'b000000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00011010000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b000000 && func_in === 6'b000010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00001);
		ex_q2.push_back(11'b00011010100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b000000 && func_in === 6'b001000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b000000 && func_in === 6'b011000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00000001011);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b000000 && func_in === 6'b011010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00000001001);
		ex_q3.push_back(5'b00010);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000000 && func_in === 6'b010010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00011001000);
		ex_q3.push_back(5'b00010);
		ex_q4.push_back(7'b0000100);
	end
else if (op_in === 6'b000000 && func_in === 6'b010000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00011001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0000100);
	end
else if (op_in === 6'b100011 && func_in === 6'b100000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100001);
	end
else if (op_in === 6'b100011 && func_in === 6'b100010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b0100010);
	end
else if (op_in === 6'b100011 && func_in === 6'b100100)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b100011 && func_in === 6'b100101)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b100011 && func_in === 6'b101010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b100011 && func_in === 6'b000000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b100011 && func_in === 6'b000010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b100011 && func_in === 6'b001000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b100011 && func_in === 6'b011000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b100011 && func_in === 6'b011010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b100011 && func_in === 6'b010010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b100011 && func_in === 6'b010000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b101011 && func_in === 6'b100000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b101011 && func_in === 6'b100010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b101011 && func_in === 6'b100100)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101011 && func_in === 6'b100101)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101011 && func_in === 6'b101010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101011 && func_in === 6'b000000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101011 && func_in === 6'b000010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101011 && func_in === 6'b001000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101011 && func_in === 6'b011000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101011 && func_in === 6'b011010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101011 && func_in === 6'b010010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101011 && func_in === 6'b010000)
	begin
		pcsrcD_exq.push_back((1'b1 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100 && func_in === 6'b100000)
	begin
		pcsrcD_exq.push_back((1'b1 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100 && func_in === 6'b100010)
	begin
		pcsrcD_exq.push_back((1'b1 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100 && func_in === 6'b100100)
	begin
		pcsrcD_exq.push_back((1'b1 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100 && func_in === 6'b100101)
	begin
		pcsrcD_exq.push_back((1'b1 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100 && func_in === 6'b101010)
	begin
		pcsrcD_exq.push_back((1'b1 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100 && func_in === 6'b000000)
	begin
		pcsrcD_exq.push_back((1'b1 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100 && func_in === 6'b000010)
	begin
		pcsrcD_exq.push_back((1'b1 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100 && func_in === 6'b001000)
	begin
		pcsrcD_exq.push_back((1'b1 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100 && func_in === 6'b011000)
	begin
		pcsrcD_exq.push_back((1'b1 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100 && func_in === 6'b011010)
	begin
		pcsrcD_exq.push_back((1'b1 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100 && func_in === 6'b010010)
	begin
		pcsrcD_exq.push_back((1'b1 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100 && func_in === 6'b010000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b1 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101 && func_in === 6'b100000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b1 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101 && func_in === 6'b100010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b1 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101 && func_in === 6'b100100)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b1 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101 && func_in === 6'b100101)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b1 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101 && func_in === 6'b101010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b1 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101 && func_in === 6'b000000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b1 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101 && func_in === 6'b000010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b1 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101 && func_in === 6'b001000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b1 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101 && func_in === 6'b011000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b1 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101 && func_in === 6'b011010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b1 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101 && func_in === 6'b010010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b1 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101 && func_in === 6'b010000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b001000 && func_in === 6'b100000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b001000 && func_in === 6'b100010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b001000 && func_in === 6'b100100)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001000 && func_in === 6'b100101)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001000 && func_in === 6'b101010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001000 && func_in === 6'b000000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001000 && func_in === 6'b000010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001000 && func_in === 6'b001000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001000 && func_in === 6'b011000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001000 && func_in === 6'b011010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001000 && func_in === 6'b010010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001000 && func_in === 6'b010000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00100);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b000010 && func_in === 6'b100000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00100);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b000010 && func_in === 6'b100010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00100);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b000010 && func_in === 6'b100100)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00100);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000010 && func_in === 6'b100101)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00100);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000010 && func_in === 6'b101010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00100);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000010 && func_in === 6'b000000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00100);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000010 && func_in === 6'b000010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00100);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000010 && func_in === 6'b001000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00100);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000010 && func_in === 6'b011000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00100);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000010 && func_in === 6'b011010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00100);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000010 && func_in === 6'b010010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00100);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000010 && func_in === 6'b010000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b100000 && func_in === 6'b100000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b100000 && func_in === 6'b100010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b100000 && func_in === 6'b100100)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b100000 && func_in === 6'b100101)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b100000 && func_in === 6'b101010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b100000 && func_in === 6'b000000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b100000 && func_in === 6'b000010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b100000 && func_in === 6'b001000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b100000 && func_in === 6'b011000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b100000 && func_in === 6'b011010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b100000 && func_in === 6'b010010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b100000 && func_in === 6'b010000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00110);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b000011 && func_in === 6'b100000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00110);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b000011 && func_in === 6'b100010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00110);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b000011 && func_in === 6'b100100)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00110);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b000011 && func_in === 6'b100101)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00110);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b000011 && func_in === 6'b101010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00110);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b000011 && func_in === 6'b000000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00110);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b000011 && func_in === 6'b000010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00110);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b000011 && func_in === 6'b001000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00110);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b000011 && func_in === 6'b011000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00110);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b000011 && func_in === 6'b011010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00110);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b000011 && func_in === 6'b010010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00110);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b000011 && func_in === 6'b010000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b001010 && func_in === 6'b100000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b001010 && func_in === 6'b100010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b001010 && func_in === 6'b100100)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001010 && func_in === 6'b100101)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001010 && func_in === 6'b101010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001010 && func_in === 6'b000000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001010 && func_in === 6'b000010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001010 && func_in === 6'b001000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001010 && func_in === 6'b011000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001010 && func_in === 6'b011010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001010 && func_in === 6'b010010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b001010 && func_in === 6'b010000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b101000 && func_in === 6'b100000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b101000 && func_in === 6'b100010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01001);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b101000 && func_in === 6'b100100)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01001);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101000 && func_in === 6'b100101)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01001);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101000 && func_in === 6'b101010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01001);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101000 && func_in === 6'b000000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01001);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101000 && func_in === 6'b000010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01001);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101000 && func_in === 6'b001000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01001);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101000 && func_in === 6'b011000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01001);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101000 && func_in === 6'b011010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01001);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101000 && func_in === 6'b010010)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00000000000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b101000 && func_in === 6'b010000)
	begin
		pcsrcD_exq.push_back((1'b0 & equal_in) | (1'b0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00000000000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else
	begin
		$display("Illegal inputs, opD = %b, functD = %b", op_in, func_in);
	end

endfunction

initial
begin
	clk = 0;
	reset = 1;
	flushE = 0;
	flag = 0;
	forever
		#5 clk = ~clk;
end

initial
begin
	repeat(10)
		@(posedge clk);
	reset = 0;
	flag = 1;
	for(int i = 0; i < 11; i++)
	begin
		for(int j = 0; j < 12; j++)
		begin
			opD = opD_in[i];
			functD = funct_in[j];
			equalD = $random();
			exp_outs(opD_in[i], functD, 1'b0, equalD);
			if(i*j === 110)
			begin
				flag = 2;
				reset = 1;
			end
			else
				@(posedge clk);
		end
	end
end

always @(posedge clk)
begin
	if(flag ===0)
	begin
		flag = flag;
	end
	else if(flag === 1)
	begin
		#1
		pcsrcD_outq.push_back(pcsrcD);
		out_q1.push_back({branchD, bneD, jumpD, jalD, jrD});
		out_q2.push_back({memtoregE, alusrcE, regdstE, regwriteE, alucontrolE, multordivE, hlwriteE});
		out_q3.push_back({memtoregM, memwriteM, regwriteM, hlwriteM, sbM});
		out_q4.push_back({memtoregW, regwriteW, jalW, lbW, hlwriteW, mfhlW});
	end
	else if(flag < 3)
	begin
		#1
		pcsrcD_outq.push_back(pcsrcD);
		out_q1.push_back({branchD, bneD, jumpD, jalD, jrD});
		out_q2.push_back({memtoregE, alusrcE, regdstE, regwriteE, alucontrolE, multordivE, hlwriteE});
		out_q3.push_back({memtoregM, memwriteM, regwriteM, hlwriteM, sbM});
		out_q4.push_back({memtoregW, regwriteW, jalW, lbW, hlwriteW, mfhlW});
		flag++;
	end
	else
	begin
		for(int i = 0; i < in_op.size(); i++)
		begin
			if(ex_q1[i] !== out_q1[i])
				$display("Not equal ex_q1[%d] = %d, out_q1[%d] = %d", i, ex_q1[i], i, out_q1[i]);
			if(ex_q2[i] !== out_q2[i])
				$display("Not equal ex_q2[%d] = %d, out_q2[%d] = %d", i, ex_q2[i], i, out_q2[i]);
			if(ex_q3[i] !== out_q3[i])
				$display("Not equal ex_q3[%d] = %d, out_q3[%d] = %d", i, ex_q3[i], i, out_q3[i]);
			if(ex_q4[i] !== out_q4[i])
				$display("Not equal ex_q4[%d] = %d, out_q4[%d] = %d", i, ex_q4[i], i, out_q4[i]);
		end
		$display("-----------------------------\n          End of run\n-----------------------------");
		$finish();
	end
end

endmodule