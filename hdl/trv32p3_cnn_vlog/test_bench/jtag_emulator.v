
// File generated by Go version U-2022.12#33f3808fcb#221128, Tue Mar 19 17:13:41 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

module jtag_emulator
  #(parameter ocd_clock_freq = 100,
    parameter ocd_remember_data_select = 0
  )
  ( input      jtag_tdo_in,
    output reg jtag_tck_out,
    output reg jtag_tdi_out,
    output reg jtag_tms_out,
    output reg jtag_trst_out
  );


  initial
  begin
    jtag_trst_out = 1'b0;
    #5 jtag_trst_out = 1'b1;
    $jtag_eval(jtag_tdo_in, jtag_trst_out, jtag_tck_out, jtag_tms_out, jtag_tdi_out, ocd_clock_freq, ocd_remember_data_select);
  end
endmodule
