
// File generated by Go version U-2022.12#33f3808fcb#221128, Tue Mar 19 18:42:44 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_mpyM : mux_mpyM
module mux_mpyM
  ( input      [1:0] bin_selector_EX,
    output reg [1:0] mpyM_out // t2u
  );


  always @ (*)

  begin : p_mux_mpyM

    // mpyM_out = 2'h0;

    // (mpyM_copy0___CTt2u_cstV0_EX)
    // [mpy.n:69]
    mpyM_out = 2'h0;

    case (bin_selector_EX)
      2'b01 : // (mpyM_copy0___CTt2u_cstV2_EX)
      begin
        // [mpy.n:68]
        mpyM_out = 2'h2;
      end
      2'b10 : // (mpyM_copy0___CTt2u_cstV3_EX)
      begin
        // [mpy.n:66][mpy.n:67]
        mpyM_out = 2'h3;
      end
      default :
        ; // null
    endcase

  end

endmodule
