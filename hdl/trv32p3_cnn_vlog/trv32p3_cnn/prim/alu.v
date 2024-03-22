
// File generated by Go version U-2022.12#33f3808fcb#221128, Fri Mar 22 18:33:46 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module alu : alu
module alu
  ( input              [3:0] bin_selector_EX,
    input      signed [31:0] aluA_in, // w32
    input      signed [31:0] aluB_in, // w32
    output reg signed [31:0] aluR_out // w32
  );


`include "primitives.v"

  always @ (*)

  begin : p_alu

    aluR_out = 32'sh0;

    case (bin_selector_EX)
      4'b0001 : // (aluR_add_aluA_aluB_alu_EX)
      begin
        // [alu.n:74][alu.n:136][alu.n:213]
        w32_add_w32_w32(aluR_out, aluA_in, aluB_in);
      end
      4'b0010 : // (aluR_band_aluA_aluB_alu_EX)
      begin
        // [alu.n:80][alu.n:140]
        w32_band_w32_w32(aluR_out, aluA_in, aluB_in);
      end
      4'b0011 : // (aluR_bor_aluA_aluB_alu_EX)
      begin
        // [alu.n:79][alu.n:141]
        w32_bor_w32_w32(aluR_out, aluA_in, aluB_in);
      end
      4'b0100 : // (aluR_bxor_aluA_aluB_alu_EX)
      begin
        // [alu.n:78][alu.n:139]
        w32_bxor_w32_w32(aluR_out, aluA_in, aluB_in);
      end
      4'b0101 : // (aluR_sll_aluA_aluB_alu_EX)
      begin
        // [alu.n:81][alu.n:172]
        w32_sll_w32_w32(aluR_out, aluA_in, aluB_in);
      end
      4'b0110 : // (aluR_slt_aluA_aluB_alu_EX)
      begin
        // [alu.n:76][alu.n:137]
        w32_slt_w32_w32(aluR_out, aluA_in, aluB_in);
      end
      4'b0111 : // (aluR_sltu_aluA_aluB_alu_EX)
      begin
        // [alu.n:77][alu.n:138]
        w32_sltu_w32_w32(aluR_out, aluA_in, aluB_in);
      end
      4'b1000 : // (aluR_sra_aluA_aluB_alu_EX)
      begin
        // [alu.n:83][alu.n:174]
        w32_sra_w32_w32(aluR_out, aluA_in, aluB_in);
      end
      4'b1001 : // (aluR_srl_aluA_aluB_alu_EX)
      begin
        // [alu.n:82][alu.n:173]
        w32_srl_w32_w32(aluR_out, aluA_in, aluB_in);
      end
      4'b1010 : // (aluR_sub_aluA_aluB_alu_EX)
      begin
        // [alu.n:75]
        w32_sub_w32_w32(aluR_out, aluA_in, aluB_in);
      end
      default :
        ; // null
    endcase

  end

endmodule
