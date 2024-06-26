
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Apr 10 20:00:35 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_pcaA : mux_pcaA
module mux_pcaA
  ( input                    ohe_selector_ID,
    input             [31:0] PC_ID_r_in, // addr
    input      signed [31:0] x_r3_in, // w32
    output reg signed [31:0] pcaA_out // w32
  );


  always @ (*)

  begin : p_mux_pcaA

    // pcaA_out = 32'sh0;

    // (pcaA_copy0_PC_ID_r_ID)
    // [ctrl.n:109][ctrl.n:160]
    pcaA_out = $signed(PC_ID_r_in);

    if (ohe_selector_ID) // (pcaA_copy0_x_r3_ID)
    begin
      // [ctrl.n:189](regX.n:91)
      pcaA_out = x_r3_in;
    end

  end

endmodule
