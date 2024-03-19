
// File generated by Go version U-2022.12#33f3808fcb#221128, Tue Mar 19 15:58:50 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mpy : mpy
module mpy
  ( input                    ohe_selector_EX,
    input      signed [31:0] mpyA_in, // w32
    input      signed [31:0] mpyB_in, // w32
    input              [1:0] mpyM_in, // t2u
    output reg signed [31:0] mpyH_out, // w32
    output reg signed [31:0] mpyL_out // w32
  );


`include "primitives.v"

  always @ (*)

  begin : p_mpy

    mpyH_out = 32'sh0;
    mpyL_out = 32'sh0;

    if (ohe_selector_EX) // (vd_mul_hw_mpyA_mpyB_mpyM_mpyL_mpyH_mpy_EX)
    begin
      // [mpy.n:66][mpy.n:67][mpy.n:68][mpy.n:69]
      void_mul_hw_w32_w32_t2u_w32_w32(mpyA_in, mpyB_in, mpyM_in, mpyL_out, mpyH_out);
    end

  end

endmodule
