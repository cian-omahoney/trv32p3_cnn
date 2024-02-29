
// File generated by Go version U-2022.12#33f3808fcb#221128, Thu Feb 29 15:23:21 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module reg_X : reg_X
module reg_X
  // synopsys translate_off
  #(parameter reg_log = 1'b1)
  // synopsys translate_on
  ( input                    reset,
    input                    clock,
    input              [1:0] bin_selector_EX,
    input                    X_x_w1_div_main_pdg_en_in, // uint1_t
    input              [4:0] __X_x_r1_raddr_in, // t5u
    input              [4:0] __X_x_r2_raddr_in, // t5u
    input              [4:0] __X_x_r3_raddr_in, // t5u
    input              [4:0] __X_x_w1_wad_in, // t5u
    input              [4:0] __X_x_w2_waddr_in, // t5u
    input      signed [31:0] x_w1_in, // w32
    input      signed [31:0] x_w2_in, // w32
    output reg signed [31:0] x_r1_out, // w32
    output reg signed [31:0] x_r2_out, // w32
    output reg signed [31:0] x_r3_out // w32
  );


  reg signed [31:0] reg_val[0:31];

  // synopsys translate_off

  reg [31:0] reg_write_log;

  always @ (negedge clock)
  begin : p_reg_X_log

    integer k;

    if (reg_log)
    begin
      for (k = 0; k <= 31; k = k + 1)
      begin
        if (reg_write_log[k] === 1'b1)
        begin
          $fdisplay(trv32p3_cnn.inst_reg_PC.log_file, "X[%0d] = %h", k, reg_val[k]);
        end
      end
    end
  end
  // synopsys translate_on

  always @ (*)
  begin : p_read_reg_X

    // x_r1_out = 32'sh0;
    // x_r2_out = 32'sh0;
    // x_r3_out = 32'sh0;

    // (x_r1_rd_X___X_x_r1_rad_EX)
    // [alu.n:69][alu.n:131][alu.n:167][mpy.n:61][div.n:58][ctrl.n:94][cnn.n:26](regX.n:75)(regX.n:121)
    x_r1_out = reg_val[__X_x_r1_raddr_in];

    // (x_r2_rd_X___X_x_r2_rad_EX)
    // [alu.n:70][mpy.n:62][div.n:59][ldst.n:99][ldst.n:100][ldst.n:101][ctrl.n:95][cnn.n:27](regX.n:82)(regX.n:114)
    x_r2_out = reg_val[__X_x_r2_raddr_in];

    // (x_r3_rd_X___X_x_r3_rad_EX)
    // [cnn.n:28][ldst.n:54][ldst.n:91][ctrl.n:189](regX.n:107)(regX.n:89)
    x_r3_out = reg_val[__X_x_r3_raddr_in];

  end

  always @ (posedge clock or posedge reset)
  begin : p_write_reg_X

    integer j;
    if (reset)
    begin
      // synopsys translate_off
      reg_write_log <= {32{1'b0}};
      // synopsys translate_on
      for ( j = 0; j <= 31; j = j + 1)
      begin
        reg_val[j] <= 32'sh0;
      end
    end
    else
    begin
      // synopsys translate_off
      reg_write_log <= {32{1'b0}};
      // synopsys translate_on

      // (X_wr_x_w1_X_x_w1_div_main_pdg_w_a_X_x_w1_div_main_pdg_en)
      if (X_x_w1_div_main_pdg_en_in)
      begin
        // synopsys translate_off
        reg_write_log[__X_x_w1_wad_in] <= 1'b1;
        // synopsys translate_on
        reg_val[__X_x_w1_wad_in] <= x_w1_in;
      end

      case (bin_selector_EX)
        2'b01 : // (X_wr_x_w1___X_x_w1_wad_EX)
        begin
          // [regX.n:99]
          // synopsys translate_off
          reg_write_log[__X_x_w1_wad_in] <= 1'b1;
          // synopsys translate_on
          reg_val[__X_x_w1_wad_in] <= x_w1_in;
        end
        2'b10 : // (X_wr_x_w2___X_x_w2_wad_EX)
        begin
          // [cnn.n:36](regX.n:107)
          // synopsys translate_off
          reg_write_log[__X_x_w2_waddr_in] <= 1'b1;
          // synopsys translate_on
          reg_val[__X_x_w2_waddr_in] <= x_w2_in;
        end
        default :
          ; // null
      endcase

    end
  end

endmodule
