`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:36:32 09/17/2022
// Design Name:   DDS_and_Hilbert
// Module Name:   D:/Students/Satyshev/ISE/Hilbert_v2/DDS_and_Hilbert_TB.v
// Project Name:  Hilbert_v2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DDS_and_Hilbert
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:50:34 09/17/2022
// Design Name:   Hilbert_and_DDS
// Module Name:   D:/Students/Satyshev/ISE/test_Hilbert/Hilbert_and_DDS_TB.v
// Project Name:  test_Hilbert
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Hilbert_and_DDS
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
/////////////////////////////////////////////////////////////////////////////////

module DDS_and_Hilbert_TB;

	// Inputs
	reg CLK;
	reg RST;
	reg ENB;
	reg [23:0] SET_FREQ;

	// Outputs
	wire [16:0] OUT;

	// Instantiate the Unit Under Test (UUT)
	DDS_and_Hilbert uut (
		.CLK(CLK), 
		.RST(RST), 
		.ENB(ENB), 
		.SET_FREQ(SET_FREQ), 
		.OUT(OUT)
	);

	initial 
	begin
		CLK = 0; 
		RST = 0; 
		SET_FREQ = 0; 
		ENB = 0;
	end
	
	always
	begin
		#1 CLK = ~CLK;
	end
	
	initial
	begin
		#10 RST = 1;
		#10 ENB = 1;
		#50 SET_FREQ = 24'd40097;
	end
	
	always @(posedge CLK)
	begin
		$display("%d", OUT);
	end
      
endmodule



