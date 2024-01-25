
// File generated by Go version U-2022.12#33f3808fcb#221128, Thu Jan 25 16:08:15 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module cmp : cmp
module cmp
  ( input              [2:0] bin_selector_EX,
    input      signed [31:0] cmpA_in, // w32
    input      signed [31:0] cmpB_in, // w32
    output reg               cmpF_out // bool
  );


`include "primitives.v"

  always @ (*)

  begin : p_cmp

    cmpF_out = 1'h0;

    case (bin_selector_EX)
      3'b001 : // (cmpF_eq_cmpA_cmpB_cmp_EX)
      begin
        // [ctrl.n:99]
        bool_eq_w32_w32(cmpF_out, cmpA_in, cmpB_in);
      end
      3'b010 : // (cmpF_ge_cmpA_cmpB_cmp_EX)
      begin
        // [ctrl.n:103]
        bool_ge_w32_w32(cmpF_out, cmpA_in, cmpB_in);
      end
      3'b011 : // (cmpF_geu_cmpA_cmpB_cmp_EX)
      begin
        // [ctrl.n:104]
        bool_geu_w32_w32(cmpF_out, cmpA_in, cmpB_in);
      end
      3'b100 : // (cmpF_lt_cmpA_cmpB_cmp_EX)
      begin
        // [ctrl.n:101]
        bool_lt_w32_w32(cmpF_out, cmpA_in, cmpB_in);
      end
      3'b101 : // (cmpF_ltu_cmpA_cmpB_cmp_EX)
      begin
        // [ctrl.n:102]
        bool_ltu_w32_w32(cmpF_out, cmpA_in, cmpB_in);
      end
      3'b110 : // (cmpF_ne_cmpA_cmpB_cmp_EX)
      begin
        // [ctrl.n:100]
        bool_ne_w32_w32(cmpF_out, cmpA_in, cmpB_in);
      end
      default :
        ; // null
    endcase

  end

endmodule
