module controllertb ();
	logic		clk, reset;
	logic [5:0] opD, functD;
	logic		flushE, equalD;
	logic 		memtoregE, memtoregM;
	logic 	 	memtoregW, memwriteM;
	logic 		pcsrcD, branchD, bneD, alusrcE;
	logic [1:0] regdstE;
	logic 		regwriteE, regwriteM, regwriteW, jumpD;
	logic 		jalD, jalW, jrD, lbW, sbM;
	logic 		multordivE, hlwriteE, hlwriteM, hlwriteW;
	logic [1:0] mfhlW;
	logic [3:0] alucontrolE;

	logic [4:0] 	ex_q1[$];
	logic [10:0] 	ex_q2[$];
	logic [4:0] 	ex_q3[$];
	logic [6:0] 	ex_q4[$];
	logic 			pcsrcD_exq[$];
	logic [5:0]		in_op[$];
	logic [5:0]		in_func[$];
	logic [4:0]		out_q1[$];
	logic [10:0]	out_q2[$];
	logic [4:0]		out_q3[$];
	logic [6:0]		out_q4[$];
	logic 			pcsrcD_outq[$];

logic [5:0] opD_in [11] = '{6'b000000, 6'b100011, 6'b101011, 6'b000100, 6'b000101, 6'b001000, 6'b000010, 6'b100000, 6'b000011, 6'b001010, 6'b101000};
logic [5:0] funct_in [12] = '{6'b100000, 6'b100010, 6'b100100, 6'b100101, 6'b101010, 6'b000000, 6'b000010, 6'b001000, 6'b011000, 6'b011010, 6'b010010, 6'b010000};

int clk_flag;
int out_flag;

controller dut (.clk(clk), .reset(reset), .opD(opD), .functD(functD), .flushE(flushE), .equalD(equalD), .memtoregE(memtoregE), .memtoregM(memtoregM), .memtoregW(memtoregW), .memwriteM(memwriteM), .pcsrcD(pcsrcD), .branchD(branchD), .bneD(bneD), .alusrcE(alusrcE), .regdstE(regdstE), .regwriteE(regwriteE), .regwriteM(regwriteM), .regwriteW(regwriteW), .jumpD(jumpD), .jalD(jalD), .jalW(jalW), .jrD(jrD), .lbW(lbW), .sbM(sbM), .multordivE(multordivE), .hlwriteE(hlwriteE), .hlwriteM(hlwriteM), .hlwriteW(hlwriteW), .mfhlW(mfhlW), .alucontrolE(alucontrolE));


initial
begin
	clk = 0;
	reset = 1;
	flushE = 1;
	clk_flag = 0;
	out_flag = 0;
	forever 
		#5 clk = ~clk;
end


function void exp_outs (logic [5:0] op_in, func_in, flush_in, equal_in);

in_op.push_back(op_in);
in_func.push_back(func_in);

if (op_in === 6'b000000)
	begin
		pcsrcD_exq.push_back(0);
		if (func_in === 6'b001000)
			begin
				ex_q1.push_back(5'b00001);
				ex_q2.push_back(11'b00000001000);
				ex_q3.push_back(5'b00000);
				ex_q4.push_back(7'b0000000);
			end
		else if (func_in === 6'b011000)
			begin
				ex_q1.push_back(5'b00000);
				ex_q2.push_back(11'b00000001011);
				ex_q3.push_back(5'b00010);
				ex_q4.push_back(7'b0000100);
			end
		else if (func_in === 6'b011010)
			begin
				ex_q1.push_back(5'b00000);
				ex_q2.push_back(11'b00000001001);
				ex_q3.push_back(5'b00010);
				ex_q4.push_back(7'b0000100);
			end
		else if (func_in === 6'b010010)
			begin
				ex_q1.push_back(5'b00000);
				ex_q2.push_back(11'b00011001000);
				ex_q3.push_back(5'b00100);
				ex_q4.push_back(7'b010001);
			end
		else if (func_in === 6'b010000)
			begin
				ex_q1.push_back(5'b00000);
				ex_q2.push_back(11'b00011001000);
				ex_q3.push_back(5'b00100);
				ex_q4.push_back(7'b0100010);
			end
		else
			begin
				ex_q1.push_back(5'b00000);
				ex_q3.push_back(5'b00100);
				ex_q4.push_back(7'b010000);
				if (func_in === 6'b100000)
					ex_q2.push_back(11'b00011001000);
				else if (func_in === 6'b100010)
					ex_q2.push_back(11'b00011101000);
				else if (func_in === 6'b100100)
					ex_q2.push_back(11'b00011000000);
				else if (func_in === 6'b100101)
					ex_q2.push_back(11'b00011000100);
				else if (func_in === 6'b101010)
					ex_q2.push_back(11'b00011101100);
				else if (func_in === 6'b000000)
					ex_q2.push_back(11'b00011010000);
				else if (func_in === 6'b000010)
					ex_q2.push_back(11'b00011010100);
				else
					begin
						ex_q2.push_back('x);
					end
			end
	end
else if (op_in === 6'b100011)
	begin
		pcsrcD_exq.push_back(0);
		ex_q1.push_back(5'b10100);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1100000);
	end
else if (op_in === 6'b101011)
	begin
		pcsrcD_exq.push_back(0);
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000100)
	begin
		pcsrcD_exq.push_back((1 & equal_in) | (0 & ~equal_in));
		ex_q1.push_back(5'b01000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b000101)
	begin
		pcsrcD_exq.push_back((1 & equal_in) | (0 & ~equal_in));
		ex_q1.push_back(5'b00000);
		ex_q2.push_back(11'b00000101000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b001000)
	begin
		pcsrcD_exq.push_back(0);
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b01001001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b000010)
	begin
		pcsrcD_exq.push_back(0);
		ex_q1.push_back(5'b00010);
		ex_q2.push_back(11'b00000001000);
		ex_q3.push_back(5'b00000);
		ex_q4.push_back(7'b0000000);
	end
else if (op_in === 6'b100000)
	begin
		pcsrcD_exq.push_back(0);
		ex_q1.push_back(5'b10100);
		ex_q2.push_back(11'b11001001000);
		ex_q3.push_back(5'b10100);
		ex_q4.push_back(7'b1101000);
	end
else if (op_in === 6'b000011)
	begin
		pcsrcD_exq.push_back(0);
		ex_q1.push_back(5'b00010);
		ex_q2.push_back(11'b00101001000);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0110000);
	end
else if (op_in === 6'b001010)
	begin
		pcsrcD_exq.push_back(0);
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b01001101100);
		ex_q3.push_back(5'b00100);
		ex_q4.push_back(7'b0100000);
	end
else if (op_in === 6'b101000)
	begin
		pcsrcD_exq.push_back(0);
		ex_q1.push_back(5'b10000);
		ex_q2.push_back(11'b01000001000);
		ex_q3.push_back(5'b01001);
		ex_q4.push_back(7'b0000000);
	end
else
	begin
		pcsrcD_exq.push_back(0);
		ex_q1.push_back('x);
		ex_q2.push_back('x);
		ex_q3.push_back('x);
		ex_q4.push_back('x);
	end

if (flush_in === 1'b0)
	ex_q2.push_back('0);
if (reset === 1'b0)
	begin
		ex_q2.push_back('0);
		ex_q3.push_back('0);
		ex_q4.push_back('0);
	end

endfunction


initial
begin
	#40
	reset = 0;
	flushE = 0;
	out_flag = 1;
	for(int i = 0; i < 11; i++)
	begin
		for(int j = 0; j < 12; j++)
		begin
			opD = opD_in[i];
			functD = funct_in[j];
			equalD = $random();
			exp_outs(opD, functD, 1'b0, equalD);
			@(posedge clk);
		end
	end
	out_flag = 2;
end



always @(posedge clk)
begin
	if (out_flag === 1)
		begin
			if (clk_flag === 0)
				begin
					#1
					out_q1.push_back({branchD, bneD, jumpD, jalD, jrD});
					clk_flag++;
				end
			else if (clk_flag === 1)
				begin
					#1
					out_q1.push_back({branchD, bneD, jumpD, jalD, jrD});
					out_q2.push_back({memtoregE, alusrcE, regdstE, regwriteE, alucontrolE, multordivE, hlwriteE});
					clk_flag++;
				end
			else if (clk_flag === 2)
				begin
					#1
					out_q1.push_back({branchD, bneD, jumpD, jalD, jrD});
					out_q2.push_back({memtoregE, alusrcE, regdstE, regwriteE, alucontrolE, multordivE, hlwriteE});
					out_q3.push_back({memtoregM, memwriteM, regwriteM, hlwriteM, sbM});
					clk_flag++;
				end
			else if (clk_flag === 3)
				begin
					#1
					out_q1.push_back({branchD, bneD, jumpD, jalD, jrD});
					out_q2.push_back({memtoregE, alusrcE, regdstE, regwriteE, alucontrolE, multordivE, hlwriteE});
					out_q3.push_back({memtoregM, memwriteM, regwriteM, hlwriteM, sbM});
					out_q4.push_back({memtoregW, regwriteW, jalW, lbW, hlwriteW, mfhlW});
				end
			else
				$fatal("Error with flag value");
		end
	if (out_flag === 2)
		begin
			if (clk_flag === 3)
				begin
					out_q1.push_back({branchD, bneD, jumpD, jalD, jrD});
					out_q2.push_back({memtoregE, alusrcE, regdstE, regwriteE, alucontrolE, multordivE, hlwriteE});
					out_q3.push_back({memtoregM, memwriteM, regwriteM, hlwriteM, sbM});
					out_q4.push_back({memtoregW, regwriteW, jalW, lbW, hlwriteW, mfhlW});
					clk_flag++;
				end
			else if (clk_flag === 4)
				begin
					out_q2.push_back({memtoregE, alusrcE, regdstE, regwriteE, alucontrolE, multordivE, hlwriteE});
					out_q3.push_back({memtoregM, memwriteM, regwriteM, hlwriteM, sbM});
					out_q4.push_back({memtoregW, regwriteW, jalW, lbW, hlwriteW, mfhlW});
					clk_flag++;
				end
			else if (clk_flag === 5)
				begin
					out_q3.push_back({memtoregM, memwriteM, regwriteM, hlwriteM, sbM});
					out_q4.push_back({memtoregW, regwriteW, jalW, lbW, hlwriteW, mfhlW});
					clk_flag++;
				end
			else if (clk_flag === 6)
				begin
					out_q4.push_back({memtoregW, regwriteW, jalW, lbW, hlwriteW, mfhlW});
					out_flag++;
				end
			else
				$fatal("Error with flag value");
		end
		
	if (out_flag === 3)
		begin
			for(int i = 0; i < out_q1.size(); i++)
			begin
				if (ex_q1[i] !== out_q1[i] || ex_q2[i] !== out_q2[i] || ex_q3[i] !== out_q3[i] || ex_q4[i] !== out_q4[i])
					$display("Error occured\nopD = %b, functD = %b\nexpected_q1 = %b, actual_q1 = %b\nexpected_q2 = %b, actual_q2 = %b\nexpected_q3 = %b, actual_q3 = %b\nexpected_q4 = %b, actual_q4 = %b", opD_in[i], in_func[i], ex_q1[i], out_q1[i], ex_q2[i], out_q2[i], ex_q3[i], out_q3[i], ex_q4[i], out_q4[i]);
			end
			out_flag++;
			$display("-----------------------------          End of run\n-----------------------------");
		end
	
	if (out_flag === 4)
		$finish();
end

endmodule