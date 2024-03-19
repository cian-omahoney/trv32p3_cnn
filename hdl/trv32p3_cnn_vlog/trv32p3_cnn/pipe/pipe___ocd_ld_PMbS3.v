
// File generated by Go version U-2022.12#33f3808fcb#221128, Tue Mar 19 17:13:41 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module pipe___ocd_ld_PMbS3 : pipe___ocd_ld_PMbS3
module pipe___ocd_ld_PMbS3
  ( input  clock,
    input  __ocd_ld_PMbEX_w_in, // bool
    output __ocd_ld_PMbS3_r_out // bool
  );


  reg pipe_val___ocd_ld_PMbS3_r_out;

  assign __ocd_ld_PMbS3_r_out = pipe_val___ocd_ld_PMbS3_r_out;


  always @ (posedge clock)
  begin : p_pipe___ocd_ld_PMbS3
    // (_pipe__ocd_ld_PMbEX_S3)
    pipe_val___ocd_ld_PMbS3_r_out <= __ocd_ld_PMbEX_w_in;

  end
endmodule
