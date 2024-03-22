
// File generated by Go version U-2022.12#33f3808fcb#221128, Fri Mar 22 17:53:29 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_pm_wr : mux_pm_wr
module mux_pm_wr
  ( input             __ocd_st_PMbEX_r_in, // bool
    input      [31:0] ocd_instr_r_in, // iword
    output reg [31:0] pm_wr_out // iword
  );


  always @ (*)

  begin : p_mux_pm_wr

    pm_wr_out = 32'h0;

    // (pm_wr_copy0_ocd_instr_r___ocd_st_PMbEX_r_EX_alw)
    if (__ocd_st_PMbEX_r_in)
    begin
      // [ocd.n:95]
      pm_wr_out = ocd_instr_r_in;
    end

  end

endmodule
