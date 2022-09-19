`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2022 18:05:39
// Design Name: 
// Module Name: HilbertFIR_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HilbertFIR_TB;

	// Inputs
	reg clk;
	reg reset;
	reg enb;
	
	// Outputs
	wire signed [16:0] Hilbert_out;
	
	// TB variables
	reg signed [9:0] mem [0:499];
	reg signed [9:0] Hilbert_in;
	reg signed [9:0] Hilbert_in_delayed27;
	reg [9:0] mem_index;
	
	// Instantiate the Unit Under Test (UUT)
	HilbertFIR uut (.clk(clk), .reset(reset), .enb(enb), .in(Hilbert_in), .out(Hilbert_out));
	
    initial $readmemh("sig4.txt", mem);
    
	initial 
	begin
		clk = 0; 
		reset = 1; 
		enb = 0;
		mem_index = 0;
	end
	
	always
	begin
		#1 clk = ~clk;
	end
	
	initial
	begin
		#5 reset = 0;
		#5 enb = 1;
	end
	
	always @(posedge clk)
	begin
	    Hilbert_in <= mem[mem_index];
	    if (mem_index >= 27)
	    begin
	       Hilbert_in_delayed27 <= mem[mem_index-27];
	    end
	    mem_index <= mem_index + 1;
		$display("%d", Hilbert_out);
	end
	
endmodule
