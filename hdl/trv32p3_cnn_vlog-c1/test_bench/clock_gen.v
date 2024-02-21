
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:43 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-c1 -cgo_options-c1.cfg -Itrv32p3_cnn_vlog-c1/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

module clock_gen
  #(parameter clock_period = 2.000,
    parameter reset_start = 0,
    parameter reset_width = 250
  )
  ( output reg reset_out,
    output reg clock_out
  );


  parameter halve_clock_period = clock_period * 0.5;

  initial
  begin
    clock_out = 1;
    reset_out = 0;
    #reset_start reset_out = 1;
    #reset_width reset_out = 0;
  end
  always
  #halve_clock_period clock_out = ~clock_out;

endmodule
