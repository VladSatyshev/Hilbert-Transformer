`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:34:26 09/17/2022 
// Design Name: 
// Module Name:    DDS_and_Hilbert 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:51 09/17/2022 
// Design Name: 
// Module Name:    Hilbert_and_DDS 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`define FREQ_RES 24 //bit
`define OUT_WIDTH 10 //bit
`define MEM_DEPTH 9 //2^MEMORY_DEPTH, bit

module DDS_and_Hilbert(CLK, RST, ENB, SET_FREQ, OUT);

	input wire CLK, RST, ENB;
	input wire[`FREQ_RES-1:0] SET_FREQ;
	output wire[16:0] OUT;
	wire[9:0] dds_out;


	DDS_GEN dds(.CLK(CLK), .RST(RST), .SET_FREQ(SET_FREQ), .OUT_FREQ(dds_out));
	FIR_Hilbert_transpose_54_folded_fixed_point HilbertFIR(.in(dds_out), .clk(CLK), .reset(RST), .enb(ENB), .out(OUT));

endmodule


// ---------------------------------------------

module DDS_GEN(input CLK, input RST, input [`FREQ_RES-1:0] SET_FREQ, output reg signed [`OUT_WIDTH-1:0] OUT_FREQ);

reg [`OUT_WIDTH-2:0] SINE_LUT [2**`MEM_DEPTH-1:0];
reg [`FREQ_RES-1:0 ] PHASE_ACC = 0;
reg [`MEM_DEPTH-1:0] MEM_ADDR = 0;
reg DEL_MSB = 0;

//memory lut init
initial $readmemh ("sine_lut_pi2_512.txt", SINE_LUT);

//dds generate
always @ (posedge CLK or negedge RST)

if (~RST)
begin
	PHASE_ACC <= 0;
	MEM_ADDR <= 0;
	DEL_MSB <= 0;
	OUT_FREQ <= 0;
end
else
begin
	PHASE_ACC <= PHASE_ACC + SET_FREQ; //phase incr
	MEM_ADDR <= PHASE_ACC [`FREQ_RES-2] ? ~PHASE_ACC [`FREQ_RES-3:`FREQ_RES-3-`MEM_DEPTH+1] : PHASE_ACC [`FREQ_RES-3:`FREQ_RES-3-`MEM_DEPTH+1];//pi/2 symmetry
	DEL_MSB <= PHASE_ACC [`FREQ_RES-1];//delayed MSB from phase incr to sync with output
	 
	//final out with pi symmetry, "~DEL_MSB" will add Ampl/2 at t=0 since this DDS has unsigned output
	//SINE LUT was generated unsigned and starts from Ampl/2,not from zero
	OUT_FREQ <= DEL_MSB ? ~{DEL_MSB, SINE_LUT [MEM_ADDR]} : {~DEL_MSB, SINE_LUT [MEM_ADDR]};
end

endmodule


module FIR_Hilbert_transpose_54_folded_fixed_point
          (clk,
           reset,
           enb,
           in,
           out);


  input   clk;
  input   reset;
  input   enb;
  input   signed [9:0] in;  // sfix10_En6
  output  signed [16:0] out;  // sfix17_En12


  wire signed [13:0] Constant1_out1;  // sfix14_En13
  wire signed [23:0] Product1_mul_temp;  // sfix24_En19
  wire signed [8:0] Product1_out1;  // sfix9_En9
  wire signed [9:0] Gain20_cast;  // sfix10_En9
  wire signed [9:0] Gain20_cast_1;  // sfix10_En9
  wire signed [17:0] Gain20_cast_2;  // sfix18_En17
  wire signed [8:0] Gain20_out1;  // sfix9_En9
  wire signed [13:0] Constant2_out1;  // sfix14_En13
  wire signed [23:0] Product2_mul_temp;  // sfix24_En19
  wire signed [10:0] Product2_out1;  // sfix11_En11
  wire signed [11:0] Gain21_cast;  // sfix12_En11
  wire signed [11:0] Gain21_cast_1;  // sfix12_En11
  wire signed [21:0] Gain21_cast_2;  // sfix22_En21
  wire signed [10:0] Gain21_out1;  // sfix11_En11
  wire signed [13:0] Constant3_out1;  // sfix14_En13
  wire signed [23:0] Product3_mul_temp;  // sfix24_En19
  wire signed [11:0] Product3_out1;  // sfix12_En12
  wire signed [12:0] Gain22_cast;  // sfix13_En12
  wire signed [12:0] Gain22_cast_1;  // sfix13_En12
  wire signed [23:0] Gain22_cast_2;  // sfix24_En23
  wire signed [11:0] Gain22_out1;  // sfix12_En12
  wire signed [13:0] Constant4_out1;  // sfix14_En13
  wire signed [23:0] Product4_mul_temp;  // sfix24_En19
  wire signed [11:0] Product4_out1;  // sfix12_En12
  wire signed [12:0] Gain23_cast;  // sfix13_En12
  wire signed [12:0] Gain23_cast_1;  // sfix13_En12
  wire signed [23:0] Gain23_cast_2;  // sfix24_En23
  wire signed [11:0] Gain23_out1;  // sfix12_En12
  wire signed [13:0] Constant5_out1;  // sfix14_En13
  wire signed [23:0] Product5_mul_temp;  // sfix24_En19
  wire signed [11:0] Product5_out1;  // sfix12_En12
  wire signed [12:0] Gain24_cast;  // sfix13_En12
  wire signed [12:0] Gain24_cast_1;  // sfix13_En12
  wire signed [23:0] Gain24_cast_2;  // sfix24_En23
  wire signed [11:0] Gain24_out1;  // sfix12_En12
  wire signed [13:0] Constant6_out1;  // sfix14_En13
  wire signed [23:0] Product6_mul_temp;  // sfix24_En19
  wire signed [11:0] Product6_out1;  // sfix12_En12
  wire signed [12:0] Gain25_cast;  // sfix13_En12
  wire signed [12:0] Gain25_cast_1;  // sfix13_En12
  wire signed [23:0] Gain25_cast_2;  // sfix24_En23
  wire signed [11:0] Gain25_out1;  // sfix12_En12
  wire signed [13:0] Constant7_out1;  // sfix14_En13
  wire signed [23:0] Product7_mul_temp;  // sfix24_En19
  wire signed [11:0] Product7_out1;  // sfix12_En12
  wire signed [12:0] Gain26_cast;  // sfix13_En12
  wire signed [12:0] Gain26_cast_1;  // sfix13_En12
  wire signed [23:0] Gain26_cast_2;  // sfix24_En23
  wire signed [11:0] Gain26_out1;  // sfix12_En12
  wire signed [13:0] Constant8_out1;  // sfix14_En13
  wire signed [23:0] Product8_mul_temp;  // sfix24_En19
  wire signed [11:0] Product8_out1;  // sfix12_En12
  wire signed [12:0] Gain1_cast;  // sfix13_En12
  wire signed [12:0] Gain1_cast_1;  // sfix13_En12
  wire signed [23:0] Gain1_cast_2;  // sfix24_En23
  wire signed [11:0] Gain1_out1;  // sfix12_En12
  wire signed [13:0] Constant9_out1;  // sfix14_En13
  wire signed [23:0] Product9_mul_temp;  // sfix24_En19
  wire signed [11:0] Product9_out1;  // sfix12_En12
  wire signed [12:0] Gain2_cast;  // sfix13_En12
  wire signed [12:0] Gain2_cast_1;  // sfix13_En12
  wire signed [23:0] Gain2_cast_2;  // sfix24_En23
  wire signed [11:0] Gain2_out1;  // sfix12_En12
  wire signed [13:0] Constant10_out1;  // sfix14_En13
  wire signed [23:0] Product10_mul_temp;  // sfix24_En19
  wire signed [11:0] Product10_out1;  // sfix12_En12
  wire signed [12:0] Gain16_cast;  // sfix13_En12
  wire signed [12:0] Gain16_cast_1;  // sfix13_En12
  wire signed [23:0] Gain16_cast_2;  // sfix24_En23
  wire signed [11:0] Gain16_out1;  // sfix12_En12
  wire signed [13:0] Constant11_out1;  // sfix14_En13
  wire signed [23:0] Product11_mul_temp;  // sfix24_En19
  wire signed [11:0] Product11_out1;  // sfix12_En11
  wire signed [12:0] Gain17_cast;  // sfix13_En11
  wire signed [12:0] Gain17_cast_1;  // sfix13_En11
  wire signed [23:0] Gain17_cast_2;  // sfix24_En22
  wire signed [11:0] Gain17_out1;  // sfix12_En11
  wire signed [13:0] Constant12_out1;  // sfix14_En13
  wire signed [23:0] Product12_mul_temp;  // sfix24_En19
  wire signed [11:0] Product12_out1;  // sfix12_En11
  wire signed [12:0] Gain18_cast;  // sfix13_En11
  wire signed [12:0] Gain18_cast_1;  // sfix13_En11
  wire signed [23:0] Gain18_cast_2;  // sfix24_En22
  wire signed [11:0] Gain18_out1;  // sfix12_En11
  wire signed [13:0] Constant13_out1;  // sfix14_En13
  wire signed [23:0] Product13_mul_temp;  // sfix24_En19
  wire signed [11:0] Product13_out1;  // sfix12_En10
  wire signed [12:0] Gain19_cast;  // sfix13_En10
  wire signed [12:0] Gain19_cast_1;  // sfix13_En10
  wire signed [23:0] Gain19_cast_2;  // sfix24_En21
  wire signed [11:0] Gain19_out1;  // sfix12_En10
  wire signed [13:0] Constant14_out1;  // sfix14_En13
  wire signed [23:0] Product55_mul_temp;  // sfix24_En19
  wire signed [11:0] Product55_out1;  // sfix12_En8
  wire signed [12:0] Gain27_cast;  // sfix13_En8
  wire signed [12:0] Gain27_cast_1;  // sfix13_En8
  wire signed [23:0] Gain27_cast_2;  // sfix24_En19
  wire signed [11:0] Gain27_out1;  // sfix12_En8
  reg signed [8:0] Delay26_out1;  // sfix9_En9
  reg signed [8:0] Delay27_out1;  // sfix9_En9
  wire signed [11:0] Sum1_add_cast;  // sfix12_En11
  wire signed [11:0] Sum1_add_cast_1;  // sfix12_En11
  wire signed [11:0] Sum1_add_temp;  // sfix12_En11
  wire signed [10:0] Sum1_out1;  // sfix11_En11
  reg signed [10:0] Delay48_out1;  // sfix11_En11
  reg signed [10:0] Delay49_out1;  // sfix11_En11
  wire signed [12:0] Sum7_add_cast;  // sfix13_En12
  wire signed [12:0] Sum7_add_cast_1;  // sfix13_En12
  wire signed [12:0] Sum7_add_temp;  // sfix13_En12
  wire signed [11:0] Sum7_out1;  // sfix12_En12
  reg signed [11:0] Delay47_out1;  // sfix12_En12
  reg signed [11:0] Delay1_out1;  // sfix12_En12
  wire signed [12:0] Sum2_add_cast;  // sfix13_En12
  wire signed [12:0] Sum2_add_cast_1;  // sfix13_En12
  wire signed [12:0] Sum2_add_temp;  // sfix13_En12
  wire signed [10:0] Sum2_out1;  // sfix11_En11
  reg signed [10:0] Delay52_out1;  // sfix11_En11
  reg signed [10:0] Delay53_out1;  // sfix11_En11
  wire signed [12:0] Sum11_add_cast;  // sfix13_En12
  wire signed [12:0] Sum11_add_cast_1;  // sfix13_En12
  wire signed [12:0] Sum11_add_temp;  // sfix13_En12
  wire signed [10:0] Sum11_out1;  // sfix11_En11
  reg signed [10:0] Delay17_out1;  // sfix11_En11
  reg signed [10:0] Delay2_out1;  // sfix11_En11
  wire signed [12:0] Sum8_add_cast;  // sfix13_En12
  wire signed [12:0] Sum8_add_cast_1;  // sfix13_En12
  wire signed [12:0] Sum8_add_temp;  // sfix13_En12
  wire signed [10:0] Sum8_out1;  // sfix11_En11
  reg signed [10:0] Delay56_out1;  // sfix11_En11
  reg signed [10:0] Delay57_out1;  // sfix11_En11
  wire signed [12:0] Sum38_add_cast;  // sfix13_En12
  wire signed [12:0] Sum38_add_cast_1;  // sfix13_En12
  wire signed [12:0] Sum38_out1;  // sfix13_En12
  reg signed [12:0] Delay25_out1;  // sfix13_En12
  reg signed [12:0] Delay18_out1;  // sfix13_En12
  wire signed [12:0] Sum12_add_cast;  // sfix13_En12
  wire signed [12:0] Sum12_out1;  // sfix13_En12
  reg signed [12:0] Delay122_out1;  // sfix13_En12
  reg signed [12:0] Delay123_out1;  // sfix13_En12
  wire signed [13:0] Sum44_add_cast;  // sfix14_En12
  wire signed [13:0] Sum44_add_cast_1;  // sfix14_En12
  wire signed [13:0] Sum44_out1;  // sfix14_En12
  reg signed [13:0] Delay22_out1;  // sfix14_En12
  reg signed [13:0] Delay19_out1;  // sfix14_En12
  wire signed [14:0] Sum39_add_cast;  // sfix15_En12
  wire signed [14:0] Sum39_add_cast_1;  // sfix15_En12
  wire signed [14:0] Sum39_add_temp;  // sfix15_En12
  wire signed [12:0] Sum39_out1;  // sfix13_En11
  reg signed [12:0] Delay126_out1;  // sfix13_En11
  reg signed [12:0] Delay127_out1;  // sfix13_En11
  wire signed [13:0] Sum48_add_cast;  // sfix14_En11
  wire signed [13:0] Sum48_add_cast_1;  // sfix14_En11
  wire signed [13:0] Sum48_add_temp;  // sfix14_En11
  wire signed [11:0] Sum48_out1;  // sfix12_En10
  reg signed [11:0] Delay45_out1;  // sfix12_En10
  reg signed [11:0] Delay28_out1;  // sfix12_En10
  wire signed [13:0] Sum45_add_cast;  // sfix14_En11
  wire signed [13:0] Sum45_add_cast_1;  // sfix14_En11
  wire signed [13:0] Sum45_out1;  // sfix14_En11
  reg signed [13:0] Delay130_out1;  // sfix14_En11
  reg signed [13:0] Delay131_out1;  // sfix14_En11
  wire signed [14:0] Sum50_add_cast;  // sfix15_En11
  wire signed [14:0] Sum50_add_cast_1;  // sfix15_En11
  wire signed [14:0] Sum50_add_temp;  // sfix15_En11
  wire signed [13:0] Sum50_out1;  // sfix14_En11
  reg signed [13:0] Delay40_out1;  // sfix14_En11
  reg signed [13:0] Delay41_out1;  // sfix14_En11
  wire signed [15:0] Sum78_add_cast;  // sfix16_En11
  wire signed [15:0] Sum78_add_cast_1;  // sfix16_En11
  wire signed [15:0] Sum78_out1;  // sfix16_En11
  reg signed [15:0] Delay136_out1;  // sfix16_En11
  reg signed [15:0] Delay137_out1;  // sfix16_En11
  wire signed [16:0] Sum79_add_cast;  // sfix17_En11
  wire signed [16:0] Sum79_add_cast_1;  // sfix17_En11
  wire signed [16:0] Sum79_add_temp;  // sfix17_En11
  wire signed [15:0] Sum79_out1;  // sfix16_En11
  reg signed [15:0] Delay134_out1;  // sfix16_En11
  reg signed [15:0] Delay135_out1;  // sfix16_En11
  wire signed [16:0] Sum49_add_cast;  // sfix17_En11
  wire signed [16:0] Sum49_add_cast_1;  // sfix17_En11
  wire signed [16:0] Sum49_add_temp;  // sfix17_En11
  wire signed [15:0] Sum49_out1;  // sfix16_En11
  reg signed [15:0] Delay132_out1;  // sfix16_En11
  reg signed [15:0] Delay133_out1;  // sfix16_En11
  wire signed [15:0] Sum46_add_cast;  // sfix16_En11
  wire signed [15:0] Sum46_out1;  // sfix16_En11
  reg signed [15:0] Delay43_out1;  // sfix16_En11
  reg signed [15:0] Delay44_out1;  // sfix16_En11
  wire signed [15:0] Sum47_add_cast;  // sfix16_En11
  wire signed [15:0] Sum47_out1;  // sfix16_En11
  reg signed [15:0] Delay128_out1;  // sfix16_En11
  reg signed [15:0] Delay129_out1;  // sfix16_En11
  wire signed [16:0] Sum41_add_cast;  // sfix17_En12
  wire signed [17:0] Sum41_add_cast_1;  // sfix18_En12
  wire signed [17:0] Sum41_add_cast_2;  // sfix18_En12
  wire signed [17:0] Sum41_add_temp;  // sfix18_En12
  wire signed [16:0] Sum41_out1;  // sfix17_En12
  reg signed [16:0] Delay20_out1;  // sfix17_En12
  reg signed [16:0] Delay21_out1;  // sfix17_En12
  wire signed [16:0] Sum43_add_cast;  // sfix17_En12
  wire signed [16:0] Sum43_out1;  // sfix17_En12
  reg signed [16:0] Delay124_out1;  // sfix17_En12
  reg signed [16:0] Delay125_out1;  // sfix17_En12
  wire signed [16:0] Sum13_add_cast;  // sfix17_En12
  wire signed [16:0] Sum13_out1;  // sfix17_En12
  reg signed [16:0] Delay23_out1;  // sfix17_En12
  reg signed [16:0] Delay24_out1;  // sfix17_En12
  wire signed [16:0] Sum14_add_cast;  // sfix17_En12
  wire signed [16:0] Sum14_out1;  // sfix17_En12
  reg signed [16:0] Delay58_out1;  // sfix17_En12
  reg signed [16:0] Delay59_out1;  // sfix17_En12
  wire signed [16:0] Sum9_add_cast;  // sfix17_En12
  wire signed [16:0] Sum9_out1;  // sfix17_En12
  reg signed [16:0] Delay12_out1;  // sfix17_En12
  reg signed [16:0] Delay16_out1;  // sfix17_En12
  wire signed [17:0] Sum10_add_cast;  // sfix18_En12
  wire signed [17:0] Sum10_add_cast_1;  // sfix18_En12
  wire signed [17:0] Sum10_add_temp;  // sfix18_En12
  wire signed [15:0] Sum10_out1;  // sfix16_En11
  reg signed [15:0] Delay54_out1;  // sfix16_En11
  reg signed [15:0] Delay55_out1;  // sfix16_En11
  wire signed [16:0] Sum3_add_cast;  // sfix17_En12
  wire signed [17:0] Sum3_add_cast_1;  // sfix18_En12
  wire signed [17:0] Sum3_add_cast_2;  // sfix18_En12
  wire signed [17:0] Sum3_add_temp;  // sfix18_En12
  wire signed [16:0] Sum3_out1;  // sfix17_En12
  reg signed [16:0] Delay42_out1;  // sfix17_En12
  reg signed [16:0] Delay46_out1;  // sfix17_En12
  wire signed [16:0] Sum6_add_cast;  // sfix17_En12
  wire signed [16:0] Sum6_out1;  // sfix17_En12
  reg signed [16:0] Delay50_out1;  // sfix17_En12
  reg signed [16:0] Delay51_out1;  // sfix17_En12
  wire signed [17:0] Sum4_add_cast;  // sfix18_En12
  wire signed [17:0] Sum4_add_cast_1;  // sfix18_En12
  wire signed [17:0] Sum4_add_temp;  // sfix18_En12
  wire signed [16:0] Sum4_out1;  // sfix17_En12
  reg signed [16:0] Delay3_out1;  // sfix17_En12
  reg signed [16:0] Delay4_out1;  // sfix17_En12
  wire signed [17:0] Sum5_add_cast;  // sfix18_En12
  wire signed [17:0] Sum5_add_cast_1;  // sfix18_En12
  wire signed [17:0] Sum5_add_temp;  // sfix18_En12
  wire signed [16:0] Sum5_out1;  // sfix17_En12

  // P1
  // 
  // P2
  // 
  // P3
  // 
  // P4
  // 
  // P5
  // 
  // P6
  // 
  // P7
  // 
  // P8
  // 
  // P9
  // 
  // P10
  // 
  // P11
  // 
  // P12
  // 
  // P13
  // 
  // P14
  // 
  // G1
  // 
  // G2
  // 
  // G3
  // 
  // G4
  // 
  // G5
  // 
  // G6
  // 
  // G7
  // 
  // G8
  // 
  // G9
  // 
  // G10
  // 
  // G11
  // 
  // G12
  // 
  // G13
  // 
  // G14
  // 
  // S1
  // 
  // S2
  // 
  // S3
  // 
  // S4
  // 
  // S5
  // 
  // S6
  // 
  // S7
  // 
  // S8
  // 
  // S9
  // 
  // S10
  // 
  // S11
  // 
  // S12
  // 
  // S13
  // 
  // S14
  // 
  // S15
  // 
  // S16
  // 
  // S17
  // 
  // S18
  // 
  // S19
  // 
  // S20
  // 
  // S21
  // 
  // S22
  // 
  // S23
  // 
  // S24
  // 
  // S25
  // 
  // S26
  // 
  // S27


  assign Constant1_out1 = 14'sb00000000100011;



  assign Product1_mul_temp = Constant1_out1 * in;
  assign Product1_out1 = Product1_mul_temp[18:10] + $signed({1'b0, Product1_mul_temp[9] & (Product1_mul_temp[10] | (|Product1_mul_temp[8:0]))});



  assign Gain20_cast = {Product1_out1[8], Product1_out1};
  assign Gain20_cast_1 =  - (Gain20_cast);
  assign Gain20_cast_2 = {Gain20_cast_1, 8'b00000000};
  assign Gain20_out1 = Gain20_cast_2[16:8] + $signed({1'b0, Gain20_cast_2[7] & (Gain20_cast_2[8] | (|Gain20_cast_2[6:0]))});



  assign Constant2_out1 = 14'sb00000000100101;



  assign Product2_mul_temp = Constant2_out1 * in;
  assign Product2_out1 = Product2_mul_temp[18:8] + $signed({1'b0, Product2_mul_temp[7] & (Product2_mul_temp[8] | (|Product2_mul_temp[6:0]))});



  assign Gain21_cast = {Product2_out1[10], Product2_out1};
  assign Gain21_cast_1 =  - (Gain21_cast);
  assign Gain21_cast_2 = {Gain21_cast_1, 10'b0000000000};
  assign Gain21_out1 = Gain21_cast_2[20:10] + $signed({1'b0, Gain21_cast_2[9] & (Gain21_cast_2[10] | (|Gain21_cast_2[8:0]))});



  assign Constant3_out1 = 14'sb00000000110111;



  assign Product3_mul_temp = Constant3_out1 * in;
  assign Product3_out1 = Product3_mul_temp[18:7] + $signed({1'b0, Product3_mul_temp[6] & (Product3_mul_temp[7] | (|Product3_mul_temp[5:0]))});



  assign Gain22_cast = {Product3_out1[11], Product3_out1};
  assign Gain22_cast_1 =  - (Gain22_cast);
  assign Gain22_cast_2 = {Gain22_cast_1, 11'b00000000000};
  assign Gain22_out1 = Gain22_cast_2[22:11] + $signed({1'b0, Gain22_cast_2[10] & (Gain22_cast_2[11] | (|Gain22_cast_2[9:0]))});



  assign Constant4_out1 = 14'sb00000001001111;



  assign Product4_mul_temp = Constant4_out1 * in;
  assign Product4_out1 = Product4_mul_temp[18:7] + $signed({1'b0, Product4_mul_temp[6] & (Product4_mul_temp[7] | (|Product4_mul_temp[5:0]))});



  assign Gain23_cast = {Product4_out1[11], Product4_out1};
  assign Gain23_cast_1 =  - (Gain23_cast);
  assign Gain23_cast_2 = {Gain23_cast_1, 11'b00000000000};
  assign Gain23_out1 = Gain23_cast_2[22:11] + $signed({1'b0, Gain23_cast_2[10] & (Gain23_cast_2[11] | (|Gain23_cast_2[9:0]))});



  assign Constant5_out1 = 14'sb00000001101111;



  assign Product5_mul_temp = Constant5_out1 * in;
  assign Product5_out1 = Product5_mul_temp[18:7] + $signed({1'b0, Product5_mul_temp[6] & (Product5_mul_temp[7] | (|Product5_mul_temp[5:0]))});



  assign Gain24_cast = {Product5_out1[11], Product5_out1};
  assign Gain24_cast_1 =  - (Gain24_cast);
  assign Gain24_cast_2 = {Gain24_cast_1, 11'b00000000000};
  assign Gain24_out1 = Gain24_cast_2[22:11] + $signed({1'b0, Gain24_cast_2[10] & (Gain24_cast_2[11] | (|Gain24_cast_2[9:0]))});



  assign Constant6_out1 = 14'sb00000010010111;



  assign Product6_mul_temp = Constant6_out1 * in;
  assign Product6_out1 = Product6_mul_temp[18:7] + $signed({1'b0, Product6_mul_temp[6] & (Product6_mul_temp[7] | (|Product6_mul_temp[5:0]))});



  assign Gain25_cast = {Product6_out1[11], Product6_out1};
  assign Gain25_cast_1 =  - (Gain25_cast);
  assign Gain25_cast_2 = {Gain25_cast_1, 11'b00000000000};
  assign Gain25_out1 = Gain25_cast_2[22:11] + $signed({1'b0, Gain25_cast_2[10] & (Gain25_cast_2[11] | (|Gain25_cast_2[9:0]))});



  assign Constant7_out1 = 14'sb00000011001010;



  assign Product7_mul_temp = Constant7_out1 * in;
  assign Product7_out1 = Product7_mul_temp[18:7] + $signed({1'b0, Product7_mul_temp[6] & (Product7_mul_temp[7] | (|Product7_mul_temp[5:0]))});



  assign Gain26_cast = {Product7_out1[11], Product7_out1};
  assign Gain26_cast_1 =  - (Gain26_cast);
  assign Gain26_cast_2 = {Gain26_cast_1, 11'b00000000000};
  assign Gain26_out1 = Gain26_cast_2[22:11] + $signed({1'b0, Gain26_cast_2[10] & (Gain26_cast_2[11] | (|Gain26_cast_2[9:0]))});



  assign Constant8_out1 = 14'sb00000100001100;



  assign Product8_mul_temp = Constant8_out1 * in;
  assign Product8_out1 = Product8_mul_temp[18:7] + $signed({1'b0, Product8_mul_temp[6] & (Product8_mul_temp[7] | (|Product8_mul_temp[5:0]))});



  assign Gain1_cast = {Product8_out1[11], Product8_out1};
  assign Gain1_cast_1 =  - (Gain1_cast);
  assign Gain1_cast_2 = {Gain1_cast_1, 11'b00000000000};
  assign Gain1_out1 = Gain1_cast_2[22:11] + $signed({1'b0, Gain1_cast_2[10] & (Gain1_cast_2[11] | (|Gain1_cast_2[9:0]))});



  assign Constant9_out1 = 14'sb00000101100101;



  assign Product9_mul_temp = Constant9_out1 * in;
  assign Product9_out1 = Product9_mul_temp[18:7] + $signed({1'b0, Product9_mul_temp[6] & (Product9_mul_temp[7] | (|Product9_mul_temp[5:0]))});



  assign Gain2_cast = {Product9_out1[11], Product9_out1};
  assign Gain2_cast_1 =  - (Gain2_cast);
  assign Gain2_cast_2 = {Gain2_cast_1, 11'b00000000000};
  assign Gain2_out1 = Gain2_cast_2[22:11] + $signed({1'b0, Gain2_cast_2[10] & (Gain2_cast_2[11] | (|Gain2_cast_2[9:0]))});



  assign Constant10_out1 = 14'sb00000111100000;



  assign Product10_mul_temp = Constant10_out1 * in;
  assign Product10_out1 = Product10_mul_temp[18:7] + $signed({1'b0, Product10_mul_temp[6] & (Product10_mul_temp[7] | (|Product10_mul_temp[5:0]))});



  assign Gain16_cast = {Product10_out1[11], Product10_out1};
  assign Gain16_cast_1 =  - (Gain16_cast);
  assign Gain16_cast_2 = {Gain16_cast_1, 11'b00000000000};
  assign Gain16_out1 = Gain16_cast_2[22:11] + $signed({1'b0, Gain16_cast_2[10] & (Gain16_cast_2[11] | (|Gain16_cast_2[9:0]))});



  assign Constant11_out1 = 14'sb00001010011001;



  assign Product11_mul_temp = Constant11_out1 * in;
  assign Product11_out1 = Product11_mul_temp[19:8] + $signed({1'b0, Product11_mul_temp[7] & (Product11_mul_temp[8] | (|Product11_mul_temp[6:0]))});



  assign Gain17_cast = {Product11_out1[11], Product11_out1};
  assign Gain17_cast_1 =  - (Gain17_cast);
  assign Gain17_cast_2 = {Gain17_cast_1, 11'b00000000000};
  assign Gain17_out1 = Gain17_cast_2[22:11] + $signed({1'b0, Gain17_cast_2[10] & (Gain17_cast_2[11] | (|Gain17_cast_2[9:0]))});



  assign Constant12_out1 = 14'sb00001111011001;



  assign Product12_mul_temp = Constant12_out1 * in;
  assign Product12_out1 = Product12_mul_temp[19:8] + $signed({1'b0, Product12_mul_temp[7] & (Product12_mul_temp[8] | (|Product12_mul_temp[6:0]))});



  assign Gain18_cast = {Product12_out1[11], Product12_out1};
  assign Gain18_cast_1 =  - (Gain18_cast);
  assign Gain18_cast_2 = {Gain18_cast_1, 11'b00000000000};
  assign Gain18_out1 = Gain18_cast_2[22:11] + $signed({1'b0, Gain18_cast_2[10] & (Gain18_cast_2[11] | (|Gain18_cast_2[9:0]))});



  assign Constant13_out1 = 14'sb00011010100111;



  assign Product13_mul_temp = Constant13_out1 * in;
  assign Product13_out1 = Product13_mul_temp[20:9] + $signed({1'b0, Product13_mul_temp[8] & (Product13_mul_temp[9] | (|Product13_mul_temp[7:0]))});



  assign Gain19_cast = {Product13_out1[11], Product13_out1};
  assign Gain19_cast_1 =  - (Gain19_cast);
  assign Gain19_cast_2 = {Gain19_cast_1, 11'b00000000000};
  assign Gain19_out1 = Gain19_cast_2[22:11] + $signed({1'b0, Gain19_cast_2[10] & (Gain19_cast_2[11] | (|Gain19_cast_2[9:0]))});



  assign Constant14_out1 = 14'sb01010001010011;



  assign Product55_mul_temp = Constant14_out1 * in;
  assign Product55_out1 = Product55_mul_temp[22:11] + $signed({1'b0, Product55_mul_temp[10] & (Product55_mul_temp[11] | (|Product55_mul_temp[9:0]))});



  assign Gain27_cast = {Product55_out1[11], Product55_out1};
  assign Gain27_cast_1 =  - (Gain27_cast);
  assign Gain27_cast_2 = {Gain27_cast_1, 11'b00000000000};
  assign Gain27_out1 = Gain27_cast_2[22:11] + $signed({1'b0, Gain27_cast_2[10] & (Gain27_cast_2[11] | (|Gain27_cast_2[9:0]))});



  always @(posedge clk or posedge reset)
    begin : Delay26_process
      if (reset == 1'b1) begin
        Delay26_out1 <= 9'sb000000000;
      end
      else begin
        if (enb) begin
          Delay26_out1 <= Product1_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay27_process
      if (reset == 1'b1) begin
        Delay27_out1 <= 9'sb000000000;
      end
      else begin
        if (enb) begin
          Delay27_out1 <= Delay26_out1;
        end
      end
    end



  assign Sum1_add_cast = {Product2_out1[10], Product2_out1};
  assign Sum1_add_cast_1 = {Delay27_out1[8], {Delay27_out1, 2'b00}};
  assign Sum1_add_temp = Sum1_add_cast + Sum1_add_cast_1;
  assign Sum1_out1 = Sum1_add_temp[10:0];



  always @(posedge clk or posedge reset)
    begin : Delay48_process
      if (reset == 1'b1) begin
        Delay48_out1 <= 11'sb00000000000;
      end
      else begin
        if (enb) begin
          Delay48_out1 <= Sum1_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay49_process
      if (reset == 1'b1) begin
        Delay49_out1 <= 11'sb00000000000;
      end
      else begin
        if (enb) begin
          Delay49_out1 <= Delay48_out1;
        end
      end
    end



  assign Sum7_add_cast = {Product3_out1[11], Product3_out1};
  assign Sum7_add_cast_1 = {Delay49_out1[10], {Delay49_out1, 1'b0}};
  assign Sum7_add_temp = Sum7_add_cast + Sum7_add_cast_1;
  assign Sum7_out1 = Sum7_add_temp[11:0];



  always @(posedge clk or posedge reset)
    begin : Delay47_process
      if (reset == 1'b1) begin
        Delay47_out1 <= 12'sb000000000000;
      end
      else begin
        if (enb) begin
          Delay47_out1 <= Sum7_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay1_process
      if (reset == 1'b1) begin
        Delay1_out1 <= 12'sb000000000000;
      end
      else begin
        if (enb) begin
          Delay1_out1 <= Delay47_out1;
        end
      end
    end



  assign Sum2_add_cast = {Product4_out1[11], Product4_out1};
  assign Sum2_add_cast_1 = {Delay1_out1[11], Delay1_out1};
  assign Sum2_add_temp = Sum2_add_cast + Sum2_add_cast_1;
  assign Sum2_out1 = Sum2_add_temp[11:1] + $signed({1'b0, Sum2_add_temp[1] & Sum2_add_temp[0]});



  always @(posedge clk or posedge reset)
    begin : Delay52_process
      if (reset == 1'b1) begin
        Delay52_out1 <= 11'sb00000000000;
      end
      else begin
        if (enb) begin
          Delay52_out1 <= Sum2_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay53_process
      if (reset == 1'b1) begin
        Delay53_out1 <= 11'sb00000000000;
      end
      else begin
        if (enb) begin
          Delay53_out1 <= Delay52_out1;
        end
      end
    end



  assign Sum11_add_cast = {Product5_out1[11], Product5_out1};
  assign Sum11_add_cast_1 = {Delay53_out1[10], {Delay53_out1, 1'b0}};
  assign Sum11_add_temp = Sum11_add_cast + Sum11_add_cast_1;
  assign Sum11_out1 = Sum11_add_temp[11:1] + $signed({1'b0, Sum11_add_temp[1] & Sum11_add_temp[0]});



  always @(posedge clk or posedge reset)
    begin : Delay17_process
      if (reset == 1'b1) begin
        Delay17_out1 <= 11'sb00000000000;
      end
      else begin
        if (enb) begin
          Delay17_out1 <= Sum11_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay2_process
      if (reset == 1'b1) begin
        Delay2_out1 <= 11'sb00000000000;
      end
      else begin
        if (enb) begin
          Delay2_out1 <= Delay17_out1;
        end
      end
    end



  assign Sum8_add_cast = {Product6_out1[11], Product6_out1};
  assign Sum8_add_cast_1 = {Delay2_out1[10], {Delay2_out1, 1'b0}};
  assign Sum8_add_temp = Sum8_add_cast + Sum8_add_cast_1;
  assign Sum8_out1 = Sum8_add_temp[11:1] + $signed({1'b0, Sum8_add_temp[1] & Sum8_add_temp[0]});



  always @(posedge clk or posedge reset)
    begin : Delay56_process
      if (reset == 1'b1) begin
        Delay56_out1 <= 11'sb00000000000;
      end
      else begin
        if (enb) begin
          Delay56_out1 <= Sum8_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay57_process
      if (reset == 1'b1) begin
        Delay57_out1 <= 11'sb00000000000;
      end
      else begin
        if (enb) begin
          Delay57_out1 <= Delay56_out1;
        end
      end
    end



  assign Sum38_add_cast = {Product7_out1[11], Product7_out1};
  assign Sum38_add_cast_1 = {Delay57_out1[10], {Delay57_out1, 1'b0}};
  assign Sum38_out1 = Sum38_add_cast + Sum38_add_cast_1;



  always @(posedge clk or posedge reset)
    begin : Delay25_process
      if (reset == 1'b1) begin
        Delay25_out1 <= 13'sb0000000000000;
      end
      else begin
        if (enb) begin
          Delay25_out1 <= Sum38_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay18_process
      if (reset == 1'b1) begin
        Delay18_out1 <= 13'sb0000000000000;
      end
      else begin
        if (enb) begin
          Delay18_out1 <= Delay25_out1;
        end
      end
    end



  assign Sum12_add_cast = {Product8_out1[11], Product8_out1};
  assign Sum12_out1 = Sum12_add_cast + Delay18_out1;



  always @(posedge clk or posedge reset)
    begin : Delay122_process
      if (reset == 1'b1) begin
        Delay122_out1 <= 13'sb0000000000000;
      end
      else begin
        if (enb) begin
          Delay122_out1 <= Sum12_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay123_process
      if (reset == 1'b1) begin
        Delay123_out1 <= 13'sb0000000000000;
      end
      else begin
        if (enb) begin
          Delay123_out1 <= Delay122_out1;
        end
      end
    end



  assign Sum44_add_cast = {{2{Product9_out1[11]}}, Product9_out1};
  assign Sum44_add_cast_1 = {Delay123_out1[12], Delay123_out1};
  assign Sum44_out1 = Sum44_add_cast + Sum44_add_cast_1;



  always @(posedge clk or posedge reset)
    begin : Delay22_process
      if (reset == 1'b1) begin
        Delay22_out1 <= 14'sb00000000000000;
      end
      else begin
        if (enb) begin
          Delay22_out1 <= Sum44_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay19_process
      if (reset == 1'b1) begin
        Delay19_out1 <= 14'sb00000000000000;
      end
      else begin
        if (enb) begin
          Delay19_out1 <= Delay22_out1;
        end
      end
    end



  assign Sum39_add_cast = {{3{Product10_out1[11]}}, Product10_out1};
  assign Sum39_add_cast_1 = {Delay19_out1[13], Delay19_out1};
  assign Sum39_add_temp = Sum39_add_cast + Sum39_add_cast_1;
  assign Sum39_out1 = Sum39_add_temp[13:1] + $signed({1'b0, Sum39_add_temp[1] & Sum39_add_temp[0]});



  always @(posedge clk or posedge reset)
    begin : Delay126_process
      if (reset == 1'b1) begin
        Delay126_out1 <= 13'sb0000000000000;
      end
      else begin
        if (enb) begin
          Delay126_out1 <= Sum39_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay127_process
      if (reset == 1'b1) begin
        Delay127_out1 <= 13'sb0000000000000;
      end
      else begin
        if (enb) begin
          Delay127_out1 <= Delay126_out1;
        end
      end
    end



  assign Sum48_add_cast = {{2{Product11_out1[11]}}, Product11_out1};
  assign Sum48_add_cast_1 = {Delay127_out1[12], Delay127_out1};
  assign Sum48_add_temp = Sum48_add_cast + Sum48_add_cast_1;
  assign Sum48_out1 = Sum48_add_temp[12:1] + $signed({1'b0, Sum48_add_temp[1] & Sum48_add_temp[0]});



  always @(posedge clk or posedge reset)
    begin : Delay45_process
      if (reset == 1'b1) begin
        Delay45_out1 <= 12'sb000000000000;
      end
      else begin
        if (enb) begin
          Delay45_out1 <= Sum48_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay28_process
      if (reset == 1'b1) begin
        Delay28_out1 <= 12'sb000000000000;
      end
      else begin
        if (enb) begin
          Delay28_out1 <= Delay45_out1;
        end
      end
    end



  assign Sum45_add_cast = {{2{Product12_out1[11]}}, Product12_out1};
  assign Sum45_add_cast_1 = {Delay28_out1[11], {Delay28_out1, 1'b0}};
  assign Sum45_out1 = Sum45_add_cast + Sum45_add_cast_1;



  always @(posedge clk or posedge reset)
    begin : Delay130_process
      if (reset == 1'b1) begin
        Delay130_out1 <= 14'sb00000000000000;
      end
      else begin
        if (enb) begin
          Delay130_out1 <= Sum45_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay131_process
      if (reset == 1'b1) begin
        Delay131_out1 <= 14'sb00000000000000;
      end
      else begin
        if (enb) begin
          Delay131_out1 <= Delay130_out1;
        end
      end
    end



  assign Sum50_add_cast = {{2{Product13_out1[11]}}, {Product13_out1, 1'b0}};
  assign Sum50_add_cast_1 = {Delay131_out1[13], Delay131_out1};
  assign Sum50_add_temp = Sum50_add_cast + Sum50_add_cast_1;
  assign Sum50_out1 = Sum50_add_temp[13:0];



  always @(posedge clk or posedge reset)
    begin : Delay40_process
      if (reset == 1'b1) begin
        Delay40_out1 <= 14'sb00000000000000;
      end
      else begin
        if (enb) begin
          Delay40_out1 <= Sum50_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay41_process
      if (reset == 1'b1) begin
        Delay41_out1 <= 14'sb00000000000000;
      end
      else begin
        if (enb) begin
          Delay41_out1 <= Delay40_out1;
        end
      end
    end



  assign Sum78_add_cast = {Product55_out1[11], {Product55_out1, 3'b000}};
  assign Sum78_add_cast_1 = {{2{Delay41_out1[13]}}, Delay41_out1};
  assign Sum78_out1 = Sum78_add_cast + Sum78_add_cast_1;



  always @(posedge clk or posedge reset)
    begin : Delay136_process
      if (reset == 1'b1) begin
        Delay136_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay136_out1 <= Sum78_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay137_process
      if (reset == 1'b1) begin
        Delay137_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay137_out1 <= Delay136_out1;
        end
      end
    end



  assign Sum79_add_cast = {{2{Gain27_out1[11]}}, {Gain27_out1, 3'b000}};
  assign Sum79_add_cast_1 = {Delay137_out1[15], Delay137_out1};
  assign Sum79_add_temp = Sum79_add_cast + Sum79_add_cast_1;
  assign Sum79_out1 = Sum79_add_temp[15:0];



  always @(posedge clk or posedge reset)
    begin : Delay134_process
      if (reset == 1'b1) begin
        Delay134_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay134_out1 <= Sum79_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay135_process
      if (reset == 1'b1) begin
        Delay135_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay135_out1 <= Delay134_out1;
        end
      end
    end



  assign Sum49_add_cast = {{4{Gain19_out1[11]}}, {Gain19_out1, 1'b0}};
  assign Sum49_add_cast_1 = {Delay135_out1[15], Delay135_out1};
  assign Sum49_add_temp = Sum49_add_cast + Sum49_add_cast_1;
  assign Sum49_out1 = Sum49_add_temp[15:0];



  always @(posedge clk or posedge reset)
    begin : Delay132_process
      if (reset == 1'b1) begin
        Delay132_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay132_out1 <= Sum49_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay133_process
      if (reset == 1'b1) begin
        Delay133_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay133_out1 <= Delay132_out1;
        end
      end
    end



  assign Sum46_add_cast = {{4{Gain18_out1[11]}}, Gain18_out1};
  assign Sum46_out1 = Sum46_add_cast + Delay133_out1;



  always @(posedge clk or posedge reset)
    begin : Delay43_process
      if (reset == 1'b1) begin
        Delay43_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay43_out1 <= Sum46_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay44_process
      if (reset == 1'b1) begin
        Delay44_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay44_out1 <= Delay43_out1;
        end
      end
    end



  assign Sum47_add_cast = {{4{Gain17_out1[11]}}, Gain17_out1};
  assign Sum47_out1 = Sum47_add_cast + Delay44_out1;



  always @(posedge clk or posedge reset)
    begin : Delay128_process
      if (reset == 1'b1) begin
        Delay128_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay128_out1 <= Sum47_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay129_process
      if (reset == 1'b1) begin
        Delay129_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay129_out1 <= Delay128_out1;
        end
      end
    end



  assign Sum41_add_cast = {{5{Gain16_out1[11]}}, Gain16_out1};
  assign Sum41_add_cast_1 = {Sum41_add_cast[16], Sum41_add_cast};
  assign Sum41_add_cast_2 = {Delay129_out1[15], {Delay129_out1, 1'b0}};
  assign Sum41_add_temp = Sum41_add_cast_1 + Sum41_add_cast_2;
  assign Sum41_out1 = Sum41_add_temp[16:0];



  always @(posedge clk or posedge reset)
    begin : Delay20_process
      if (reset == 1'b1) begin
        Delay20_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay20_out1 <= Sum41_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay21_process
      if (reset == 1'b1) begin
        Delay21_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay21_out1 <= Delay20_out1;
        end
      end
    end



  assign Sum43_add_cast = {{5{Gain2_out1[11]}}, Gain2_out1};
  assign Sum43_out1 = Sum43_add_cast + Delay21_out1;



  always @(posedge clk or posedge reset)
    begin : Delay124_process
      if (reset == 1'b1) begin
        Delay124_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay124_out1 <= Sum43_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay125_process
      if (reset == 1'b1) begin
        Delay125_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay125_out1 <= Delay124_out1;
        end
      end
    end



  assign Sum13_add_cast = {{5{Gain1_out1[11]}}, Gain1_out1};
  assign Sum13_out1 = Sum13_add_cast + Delay125_out1;



  always @(posedge clk or posedge reset)
    begin : Delay23_process
      if (reset == 1'b1) begin
        Delay23_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay23_out1 <= Sum13_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay24_process
      if (reset == 1'b1) begin
        Delay24_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay24_out1 <= Delay23_out1;
        end
      end
    end



  assign Sum14_add_cast = {{5{Gain26_out1[11]}}, Gain26_out1};
  assign Sum14_out1 = Sum14_add_cast + Delay24_out1;



  always @(posedge clk or posedge reset)
    begin : Delay58_process
      if (reset == 1'b1) begin
        Delay58_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay58_out1 <= Sum14_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay59_process
      if (reset == 1'b1) begin
        Delay59_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay59_out1 <= Delay58_out1;
        end
      end
    end



  assign Sum9_add_cast = {{5{Gain25_out1[11]}}, Gain25_out1};
  assign Sum9_out1 = Sum9_add_cast + Delay59_out1;



  always @(posedge clk or posedge reset)
    begin : Delay12_process
      if (reset == 1'b1) begin
        Delay12_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay12_out1 <= Sum9_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay16_process
      if (reset == 1'b1) begin
        Delay16_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay16_out1 <= Delay12_out1;
        end
      end
    end



  assign Sum10_add_cast = {{6{Gain24_out1[11]}}, Gain24_out1};
  assign Sum10_add_cast_1 = {Delay16_out1[16], Delay16_out1};
  assign Sum10_add_temp = Sum10_add_cast + Sum10_add_cast_1;
  assign Sum10_out1 = Sum10_add_temp[16:1] + $signed({1'b0, Sum10_add_temp[1] & Sum10_add_temp[0]});



  always @(posedge clk or posedge reset)
    begin : Delay54_process
      if (reset == 1'b1) begin
        Delay54_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay54_out1 <= Sum10_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay55_process
      if (reset == 1'b1) begin
        Delay55_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay55_out1 <= Delay54_out1;
        end
      end
    end



  assign Sum3_add_cast = {{5{Gain23_out1[11]}}, Gain23_out1};
  assign Sum3_add_cast_1 = {Sum3_add_cast[16], Sum3_add_cast};
  assign Sum3_add_cast_2 = {Delay55_out1[15], {Delay55_out1, 1'b0}};
  assign Sum3_add_temp = Sum3_add_cast_1 + Sum3_add_cast_2;
  assign Sum3_out1 = Sum3_add_temp[16:0];



  always @(posedge clk or posedge reset)
    begin : Delay42_process
      if (reset == 1'b1) begin
        Delay42_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay42_out1 <= Sum3_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay46_process
      if (reset == 1'b1) begin
        Delay46_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay46_out1 <= Delay42_out1;
        end
      end
    end



  assign Sum6_add_cast = {{5{Gain22_out1[11]}}, Gain22_out1};
  assign Sum6_out1 = Sum6_add_cast + Delay46_out1;



  always @(posedge clk or posedge reset)
    begin : Delay50_process
      if (reset == 1'b1) begin
        Delay50_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay50_out1 <= Sum6_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay51_process
      if (reset == 1'b1) begin
        Delay51_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay51_out1 <= Delay50_out1;
        end
      end
    end



  assign Sum4_add_cast = {{6{Gain21_out1[10]}}, {Gain21_out1, 1'b0}};
  assign Sum4_add_cast_1 = {Delay51_out1[16], Delay51_out1};
  assign Sum4_add_temp = Sum4_add_cast + Sum4_add_cast_1;
  assign Sum4_out1 = Sum4_add_temp[16:0];



  always @(posedge clk or posedge reset)
    begin : Delay3_process
      if (reset == 1'b1) begin
        Delay3_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay3_out1 <= Sum4_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay4_process
      if (reset == 1'b1) begin
        Delay4_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay4_out1 <= Delay3_out1;
        end
      end
    end



  assign Sum5_add_cast = {{6{Gain20_out1[8]}}, {Gain20_out1, 3'b000}};
  assign Sum5_add_cast_1 = {Delay4_out1[16], Delay4_out1};
  assign Sum5_add_temp = Sum5_add_cast + Sum5_add_cast_1;
  assign Sum5_out1 = Sum5_add_temp[16:0];



  assign out = Sum5_out1;

endmodule  // FIR_Hilbert_transpose_54_folded_fixed_point





