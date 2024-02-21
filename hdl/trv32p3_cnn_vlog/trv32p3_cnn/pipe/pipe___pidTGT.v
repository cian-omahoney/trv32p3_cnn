
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:34:20 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module pipe___pidTGT : pipe___pidTGT
module pipe___pidTGT
  ( input                clock,
    input  signed [31:0] __pidTGT_w_in, // w32
    output signed [31:0] __pidTGT_r_out // w32
  );


  reg signed [31:0] pipe_val___pidTGT_r_out;

  assign __pidTGT_r_out = pipe_val___pidTGT_r_out;


  always @ (posedge clock)
  begin : p_pipe___pidTGT
    // (_pipe_pidTGT_ID)
    // [ctrl.n:114][ctrl.n:155][ctrl.n:194]
    pipe_val___pidTGT_r_out <= __pidTGT_w_in;

  end
endmodule
