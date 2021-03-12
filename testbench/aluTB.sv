module aluTB();

	logic [31:0]  A, B;
	logic [3:0]   F;
	logic [4:0]   shamt;
	logic [31:0] Y;
	logic zero;
	
	logic expected_zero, clk = 0;
	logic [31:0] expected_output;
	bit   [3:0] funct[12] = {1'h0, 1'h1, 1'h2, 1'hx, 1'h4, 1'h5, 1'hx, 1'hx, 1'hx, 1'hx, 1'hA, 1'hB};
	int  errors, success;
	
	alu DUT(.*);
	
	always #5 clk = ~clk;
		
	task checkSum(input [31:0] a, b, output [31:0] y);
		y = a + b;
	endtask
	
	task checkDiff(input [31:0] a, b, output [31:0] y);
		y = a - b;
	endtask
	
	task checkAND(input [31:0] a, b, output [31:0] y);
		y = a & b;
	endtask
	
	task checkOR(input [31:0] a, b, output [31:0] y);
		y = a | b;
	endtask
	
	task checkSLT(input [31:0] a, b, output [31:0] y);
		if (a[31] !== b[31]) begin
			if (a[31] > b[31]) 
				y = 1;
			else 
				y = 0;
		end 
		else begin 
			if (a < b)
				y = 1; 
			else 
				y = 0; 
		end
	endtask
	
	task checkSLL(input [31:0] a, b, input [4:0] shamt, output [31:0] y);
		y = (a + b) << shamt;
	endtask
	
	task checkSRL(input [31:0] a, b, input [4:0] shamt, output [31:0] y);
		y = (a + b) >> shamt;
	endtask
	
	task checkZERO(input [31:0] num, output zero);
		zero = (num == 32'b0);
	endtask
	
	initial begin
		errors = 0;
		success = 0;
		
		repeat(20) @(posedge clk)
		begin
			A = $random();
			B = $random();
			shamt = $urandom();
			F = funct[$urandom_range(0,11)];
		end
		
		$display("%d test completed and %0d errors found", success, errors);
		$finish;
	end
	always @(negedge clk) 
	begin
		if(F == 4'b0010)// ADD
		begin
		checkSum(A, B, expected_output);
		checkZERO(expected_output, expected_zero);
		
			if(expected_output != Y || expected_zero != zero)
            begin
                $display("Error: Func=%h, A=%h, B=%h", F, A, B);
                $display("Output Sum=%h, expected Sum = %h, expected zero = %b", Y, expected_output, expected_zero);
                errors = errors + 1;
            end
			else
				success++;
		end
		else if(F == 4'b1010)// SUB
		begin
		checkDiff(A, B, expected_output);
		checkZERO(expected_output, expected_zero);
		
			if(expected_output != Y || expected_zero != zero)
            begin
                $display("Error: Func=%h, A=%h, B=%h", F, A, B);
                $display("Output Sum=%h, expected Sum = %h, expected zero = %b", Y, expected_output, expected_zero);
                errors = errors + 1;
            end
			else
				success++;
		end
		else if(F == 4'b0000)// AND
		begin
		checkAND(A, B, expected_output);
		checkZERO(expected_output, expected_zero);
		
			if(expected_output != Y || expected_zero != zero)
            begin
                $display("Error: Func=%h, A=%h, B=%h", F, A, B);
                $display("Output Sum=%h, expected Sum = %h, expected zero = %b", Y, expected_output, expected_zero);
                errors = errors + 1;
            end
			else
				success++;
		end
		else if(F == 4'b0001) //OR
		begin
		checkOR(A, B, expected_output);
		checkZERO(expected_output, expected_zero);
		
			if(expected_output != Y || expected_zero != zero)
            begin
                $display("Error: Func=%h, A=%h, B=%h", F, A, B);
                $display("Output Sum=%h, expected Sum = %h, expected zero = %b", Y, expected_output, expected_zero);
                errors = errors + 1;
            end
			else
				success++;
		end
		else if(F == 4'b1011) // SLT
		begin
		checkSLT(A, B, expected_output);
		checkZERO(expected_output, expected_zero);
		
			if(expected_output != Y || expected_zero != zero)
            begin
                $display("Error: Func=%h, A=%h, B=%h", F, A, B);
                $display("Output Sum=%h, expected Sum = %h, expected zero = %b", Y, expected_output, expected_zero);
                errors = errors + 1;
            end
			else
				success++;
		end
		else if(F == 4'b0100) // SLL
		begin
		checkSLL(A, B, shamt, expected_output);
		checkZERO(expected_output, expected_zero);
		
			if(expected_output != Y || expected_zero != zero)
            begin
                $display("Error: Func=%h, A=%h, B=%h", F, A, B);
                $display("Output Sum=%h, expected Sum = %h, expected zero = %b", Y, expected_output, expected_zero);
                errors = errors + 1;
            end
			else
				success++;
		end
		else if(F == 4'b0101) // SRL
		begin
		checkSRL(A, B, shamt, expected_output);
		checkZERO(expected_output, expected_zero);
		
			if(expected_output != Y || expected_zero != zero)
            begin
                $display("Error: Func=%h, A=%h, B=%h", F, A, B);
                $display("Output Sum=%h, expected Sum = %h, expected zero = %b", Y, expected_output, expected_zero);
                errors = errors + 1;
            end
			else
				success++;
		end
		else
			$display("Invalid Func: %h", F);
	end
	
	
endmodule