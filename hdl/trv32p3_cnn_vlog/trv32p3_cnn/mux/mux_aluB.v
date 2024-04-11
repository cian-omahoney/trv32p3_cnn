
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Apr 10 20:00:35 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_aluB : mux_aluB
module mux_aluB
  ( input              [1:0] bin_selector_EX,
    input              [4:0] __CTt5u_cstP20_EX_in, // t5u
    input      signed [11:0] __CTt12s_cstP20_EX_in, // t12s
    input      signed [19:0] __CTt20s_rp12_cstP12_EX_in, // t20s_rp12
    input      signed [31:0] x_r2_in, // w32
    output reg signed [31:0] aluB_out // w32
  );


  always @ (*)

  begin : p_mux_aluB

    // aluB_out = 32'sh0;

    // (aluB_copy0_x_r2_EX)
    // [alu.n:70](regX.n:84)
    aluB_out = x_r2_in;

    case (bin_selector_EX)
      2'b01 : // (aluB_copy0___CTt12s_cstP20_EX)
      begin
        // [alu.n:132]
        aluB_out = $signed({{20{__CTt12s_cstP20_EX_in[11]}}, __CTt12s_cstP20_EX_in});
      end
      2'b10 : // (aluB_copy0___CTt20s_rp12_cstP12_EX)
      begin
        // [alu.n:211]
        aluB_out = $signed({__CTt20s_rp12_cstP12_EX_in, 12'b000000000000});
      end
      2'b11 : // (aluB_copy0___CTt5u_cstP20_EX)
      begin
        // [alu.n:168]
        aluB_out = $signed({{27{1'b0}}, __CTt5u_cstP20_EX_in});
      end
      default :
        ; // null
    endcase

  end

endmodule
