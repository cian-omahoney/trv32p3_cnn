
// File generated by Go version U-2022.12#33f3808fcb#221128, Tue Mar 19 15:58:50 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module agu : agu
module agu
  ( input                    ohe_selector_ID,
    input      signed [31:0] aguA_in, // w32
    input      signed [31:0] aguB_in, // w32
    output reg signed [31:0] aguR_out // w32
  );


`include "primitives.v"

  always @ (*)

  begin : p_agu

    aguR_out = 32'sh0;

    if (ohe_selector_ID) // (aguR_add_aguA_aguB_agu_ID)
    begin
      // [ldst.n:57][ldst.n:94]
      w32_add_w32_w32(aguR_out, aguA_in, aguB_in);
    end

  end

endmodule
