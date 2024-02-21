
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:40 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-isacov -cgo_options-isacov.cfg -Itrv32p3_cnn_vlog-isacov/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module pipe___ocd_st_PMbEX : pipe___ocd_st_PMbEX
module pipe___ocd_st_PMbEX
  ( input  clock,
    input  __ocd_st_PMbID_w_in, // bool
    output __ocd_st_PMbEX_r_out // bool
  );


  reg pipe_val___ocd_st_PMbEX_r_out;

  assign __ocd_st_PMbEX_r_out = pipe_val___ocd_st_PMbEX_r_out;


  always @ (posedge clock)
  begin : p_pipe___ocd_st_PMbEX
    // (_pipe__ocd_st_PMbID_EX)
    pipe_val___ocd_st_PMbEX_r_out <= __ocd_st_PMbID_w_in;

  end
endmodule
