
// File generated by Go version U-2022.12#33f3808fcb#221128, Fri Mar  8 16:47:01 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_x_w1_dead : mux_x_w1_dead
module mux_x_w1_dead
  ( input                    ohe_selector_EX,
    input      signed [31:0] cnn_R_in, // w32
    input      signed [31:0] x_w1_in, // w32
    output reg signed [31:0] x_w1_dead_out // w32
  );


  always @ (*)

  begin : p_mux_x_w1_dead

    // x_w1_dead_out = 32'sh0;

    // (x_w1_dead_copy0_cnn_w1_EX)
    // [cnn.n:35]
    x_w1_dead_out = cnn_R_in;

    if (ohe_selector_EX) // (x_w1_dead_copy0_x_w1_EX)
    begin
      // [regX.n:98]
      x_w1_dead_out = x_w1_in;
    end

  end

endmodule
