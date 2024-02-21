
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:40 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-isacov -cgo_options-isacov.cfg -Itrv32p3_cnn_vlog-isacov/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux___pidTGT_w : mux___pidTGT_w
module mux___pidTGT_w
  ( input                    ohe_selector_ID,
    input      signed [31:0] lnk_id_in, // w32
    input      signed [31:0] pcaR_in, // w32
    output reg signed [31:0] __pidTGT_w_out // w32
  );


  always @ (*)

  begin : p_mux___pidTGT_w

    // __pidTGT_w_out = 32'sh0;

    // (pidTGT_copy0_lnk_id_ID)
    // [ctrl.n:155][ctrl.n:194]
    __pidTGT_w_out = lnk_id_in;

    if (ohe_selector_ID) // (pidTGT_copy0_pcaR_ID)
    begin
      // [ctrl.n:114]
      __pidTGT_w_out = pcaR_in;
    end

  end

endmodule
