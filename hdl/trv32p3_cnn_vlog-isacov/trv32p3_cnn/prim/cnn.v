
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:40 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-isacov -cgo_options-isacov.cfg -Itrv32p3_cnn_vlog-isacov/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module cnn : cnn
module cnn
  ( input                    ohe_selector_EX,
    input      signed [31:0] xuA_in, // w32
    input      signed [31:0] xuB_in, // w32
    input      signed [31:0] xuC_in, // w32
    output reg signed [31:0] cnn_R_out // w32
  );


`include "primitives.v"

  always @ (*)

  begin : p_cnn

    cnn_R_out = 32'sh0;

    if (ohe_selector_EX) // (cnn_R_mac_xuC_xuA_xuB_cnn_EX)
    begin
      // [cnn.n:32]
      w32_mac_w32_w32_w32(cnn_R_out, xuC_in, xuA_in, xuB_in);
    end

  end

endmodule
