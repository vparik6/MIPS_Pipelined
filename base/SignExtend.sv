/*
SignExtend.sv
input: InstrD[15:0]
output: SignImmD
*/

module SignExtend(input  logic [15:0] InstrD,
                  output logic [31:0] SignImmD);
              
	assign SignImmD = {{16{InstrD[15]}}, InstrD};
endmodule