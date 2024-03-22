
// File generated by Go version U-2022.12#33f3808fcb#221128, Fri Mar 22 18:55:19 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_x_w1 : mux_x_w1
module mux_x_w1
  ( input              [2:0] bin_selector_EX,
    input                    X_x_w1_div_main_pdg_en_in, // uint1_t
    input      signed [19:0] __CTt20s_rp12_cstP12_EX_in, // t20s_rp12
    input      signed [31:0] __pidTGT_r_in, // w32
    input      signed [31:0] aluR_in, // w32
    input      signed [31:0] cnn_R_in, // w32
    input      signed [31:0] lxR_in, // w32
    input      signed [31:0] mpyH_in, // w32
    input      signed [31:0] mpyL_in, // w32
    input      signed [31:0] x_w11_in, // w32
    output reg signed [31:0] x_w1_out // w32
  );


  always @ (*)

  begin : p_mux_x_w1

    x_w1_out = 32'sh0;

    // (x_w1_copy_x_w11_X_x_w1_div_main_pdg_en)
    if (X_x_w1_div_main_pdg_en_in)
    begin
      x_w1_out = x_w11_in;
    end

    case (bin_selector_EX)
      3'b001 : // (luiU_copy0___CTt20s_rp12_cstP12_EX)
      begin
        // [alu.n:191]
        x_w1_out = $signed({__CTt20s_rp12_cstP12_EX_in, 12'b000000000000});
      end
      3'b010 : // (mpyR_copy0_mpyH_EX)
      begin
        // [mpy.n:76]
        x_w1_out = mpyH_in;
      end
      3'b011 : // (mpyR_copy0_mpyL_EX)
      begin
        // [mpy.n:73]
        x_w1_out = mpyL_in;
      end
      3'b100 : // (x_w1_copy0_aluR_EX)
      begin
        // [alu.n:86][alu.n:144][alu.n:177][alu.n:215](regX.n:98)
        x_w1_out = aluR_in;
      end
      3'b101 : // (x_w1_copy0_cnn_w1_EX)
      begin
        // [cnn.n:60](regX.n:98)
        x_w1_out = cnn_R_in;
      end
      3'b110 : // (x_w1_copy0_lxR_EX)
      begin
        // [ldst.n:75](regX.n:98)
        x_w1_out = lxR_in;
      end
      3'b111 : // (x_w1_copy0_pidTGT_EX)
      begin
        // [ctrl.n:157][ctrl.n:196](regX.n:98)
        x_w1_out = __pidTGT_r_in;
      end
      default :
        ; // null
    endcase

  end

endmodule
