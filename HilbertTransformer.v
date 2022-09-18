// -------------------------------------------------------------
// 
// File Name: hdl_prj\hdlsrc\HilbertTransformer\HilbertTransformer.v
// Created: 2022-09-18 14:03:53
// 
// Generated by MATLAB 9.12 and HDL Coder 3.20
// 
// 
// -- -------------------------------------------------------------
// -- Rate and Clocking Details
// -- -------------------------------------------------------------
// Model base rate: 0.2
// Target subsystem base rate: 0.2
// 
// 
// Clock Enable  Sample Time
// -- -------------------------------------------------------------
// ce_out        0.2
// -- -------------------------------------------------------------
// 
// 
// Output Signal                 Clock Enable  Sample Time
// -- -------------------------------------------------------------
// out                           ce_out        0.2
// -- -------------------------------------------------------------
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: HilbertTransformer
// Source Path: HilbertTransformer
// Hierarchy Level: 0
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module HilbertTransformer
          (clk,
           reset,
           clk_enable,
           in,
           ce_out,
           out);


  input   clk;
  input   reset;
  input   clk_enable;
  input   signed [9:0] in;  // sfix10_En6
  output  ce_out;
  output  signed [16:0] out;  // sfix17_En12


  wire signed [16:0] FIR_Hilbert_transpose_54_folded_fixed_point_out1;  // sfix17_En12


  FIR_Hilbert_transpose_54_folded_fixed_point u_FIR_Hilbert_transpose_54_folded_fixed_point (.clk(clk),
                                                                                             .reset(reset),
                                                                                             .enb(clk_enable),
                                                                                             .in(in),  // sfix10_En6
                                                                                             .out(FIR_Hilbert_transpose_54_folded_fixed_point_out1)  // sfix17_En12
                                                                                             );

  assign out = FIR_Hilbert_transpose_54_folded_fixed_point_out1;

  assign ce_out = clk_enable;

endmodule  // HilbertTransformer

