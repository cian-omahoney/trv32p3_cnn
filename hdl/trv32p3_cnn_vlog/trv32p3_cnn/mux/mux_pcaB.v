
// File generated by Go version U-2022.12#33f3808fcb#221128, Fri Mar 22 18:46:36 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_pcaB : mux_pcaB
module mux_pcaB
  ( input              [1:0] bin_selector_ID,
    input      signed [11:0] __CTt12s_cstP20_ID_in, // t12s
    input      signed [12:0] __CTt13s_s2_cstP31_12P7_11P25_10_5P8_4_1_ID_in, // t13s_s2
    input      signed [20:0] of21_in, // t21s_s2
    output reg signed [31:0] pcaB_out // w32
  );


  always @ (*)

  begin : p_mux_pcaB

    // pcaB_out = 32'sh0;

    // (pcaB_copy0_of21_ID)
    // [ctrl.n:161]
    pcaB_out = $signed({{11{of21_in[20]}}, of21_in});

    case (bin_selector_ID)
      2'b01 : // (pcaB_copy0___CTt12s_cstP20_ID)
      begin
        // [ctrl.n:190]
        pcaB_out = $signed({{20{__CTt12s_cstP20_ID_in[11]}}, __CTt12s_cstP20_ID_in});
      end
      2'b10 : // (pcaB_copy0___CTt13s_s2_cstP31_12P7_11P25_10_5P8_4_1_ID)
      begin
        // [ctrl.n:110]
        pcaB_out = $signed({{19{__CTt13s_s2_cstP31_12P7_11P25_10_5P8_4_1_ID_in[12]}}, __CTt13s_s2_cstP31_12P7_11P25_10_5P8_4_1_ID_in});
      end
      default :
        ; // null
    endcase

  end

endmodule
