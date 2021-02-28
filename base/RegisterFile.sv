/*
RegisterFile.sv
input: clk,reset,InstrD[25:21],InstrD[20:16],WriteRegW,ResultW,RegWriteW
output: rd1_ID,rd2_ID

negedge clk
*/

module RegisterFile(clk,reset,A1,A2,A3,WD3,WE3,RD1,RD2);
	input clk, reset;
	input logic [4:0]  A1, A2, A3; 
    input logic [31:0] WD3; 
	input WE3;
    output logic [31:0] RD1, RD2);

  logic [31:0] register[31:0];

  always_ff @(negedge clk) begin
	if(reset)
		// clear register values
    else if 
		(WE3) register[A3] <= WD3;	
  endmodule
  
  always_ff @(negedge clk) begin
	if(reset) begin
		RD1 <= 0;
		RD2 <= 0;
	end
	else begin
		RD1 <= register[A1];
		RD2 <= register[A2];	
	end
  
  end
  
endmodule