
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:21 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-isacov -cgo_options-isacov.cfg -Itrv32p3_cnn_vlog-isacov/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_aguB : mux_aguB
module mux_aguB
  ( input              [1:0] bin_selector_ID,
    input      signed [11:0] __CTt12s_cstP20_ID_in, // t12s
    input      signed [11:0] __CTt12s_cstP25_11_5P7_4_0_ID_in, // t12s
    output reg signed [31:0] aguB_out // w32
  );


  always @ (*)

  begin : p_mux_aguB

    aguB_out = 32'sh0;

    case (bin_selector_ID)
      2'b01 : // (aguB_copy0___CTt12s_cstP20_ID)
      begin
        // [ldst.n:55]
        aguB_out = $signed({{20{__CTt12s_cstP20_ID_in[11]}}, __CTt12s_cstP20_ID_in});
      end
      2'b10 : // (aguB_copy0___CTt12s_cstP25_11_5P7_4_0_ID)
      begin
        // [ldst.n:92]
        aguB_out = $signed({{20{__CTt12s_cstP25_11_5P7_4_0_ID_in[11]}}, __CTt12s_cstP25_11_5P7_4_0_ID_in});
      end
      default :
        ; // null
    endcase

  end

endmodule
