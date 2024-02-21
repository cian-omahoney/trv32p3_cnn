
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:43 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-c1 -cgo_options-c1.cfg -Itrv32p3_cnn_vlog-c1/tmp_pdg -updg -updg_controller trv32p3_cnn



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

  reg signed [31:0] reg_val_next[0:31];

  reg  [31:0] reg_write_enab;


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

  always @ (*)
  begin : p_write_combin_reg_X

    integer j;

    reg_write_enab = 32'h0;
    for ( j = 0; j <= 31; j = j + 1)
      // next value assigned here to avoid latches and simplify muxes
      reg_val_next[j] = x_w1_in;

    // field 0

    // field 1
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 1
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 1)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 1))
    begin
      reg_val_next[1] = x_w1_in;
      reg_write_enab[1] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 1)
    begin
      reg_val_next[1] = x_w2_in;
      reg_write_enab[1] = 1'b1;
    end

    // field 2
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 2
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 2)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 2))
    begin
      reg_val_next[2] = x_w1_in;
      reg_write_enab[2] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 2)
    begin
      reg_val_next[2] = x_w2_in;
      reg_write_enab[2] = 1'b1;
    end

    // field 3
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 3
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 3)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 3))
    begin
      reg_val_next[3] = x_w1_in;
      reg_write_enab[3] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 3)
    begin
      reg_val_next[3] = x_w2_in;
      reg_write_enab[3] = 1'b1;
    end

    // field 4
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 4
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 4)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 4))
    begin
      reg_val_next[4] = x_w1_in;
      reg_write_enab[4] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 4)
    begin
      reg_val_next[4] = x_w2_in;
      reg_write_enab[4] = 1'b1;
    end

    // field 5
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 5
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 5)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 5))
    begin
      reg_val_next[5] = x_w1_in;
      reg_write_enab[5] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 5)
    begin
      reg_val_next[5] = x_w2_in;
      reg_write_enab[5] = 1'b1;
    end

    // field 6
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 6
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 6)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 6))
    begin
      reg_val_next[6] = x_w1_in;
      reg_write_enab[6] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 6)
    begin
      reg_val_next[6] = x_w2_in;
      reg_write_enab[6] = 1'b1;
    end

    // field 7
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 7
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 7)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 7))
    begin
      reg_val_next[7] = x_w1_in;
      reg_write_enab[7] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 7)
    begin
      reg_val_next[7] = x_w2_in;
      reg_write_enab[7] = 1'b1;
    end

    // field 8
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 8
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 8)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 8))
    begin
      reg_val_next[8] = x_w1_in;
      reg_write_enab[8] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 8)
    begin
      reg_val_next[8] = x_w2_in;
      reg_write_enab[8] = 1'b1;
    end

    // field 9
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 9
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 9)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 9))
    begin
      reg_val_next[9] = x_w1_in;
      reg_write_enab[9] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 9)
    begin
      reg_val_next[9] = x_w2_in;
      reg_write_enab[9] = 1'b1;
    end

    // field 10
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 10
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 10)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 10))
    begin
      reg_val_next[10] = x_w1_in;
      reg_write_enab[10] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 10)
    begin
      reg_val_next[10] = x_w2_in;
      reg_write_enab[10] = 1'b1;
    end

    // field 11
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 11
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 11)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 11))
    begin
      reg_val_next[11] = x_w1_in;
      reg_write_enab[11] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 11)
    begin
      reg_val_next[11] = x_w2_in;
      reg_write_enab[11] = 1'b1;
    end

    // field 12
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 12
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 12)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 12))
    begin
      reg_val_next[12] = x_w1_in;
      reg_write_enab[12] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 12)
    begin
      reg_val_next[12] = x_w2_in;
      reg_write_enab[12] = 1'b1;
    end

    // field 13
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 13
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 13)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 13))
    begin
      reg_val_next[13] = x_w1_in;
      reg_write_enab[13] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 13)
    begin
      reg_val_next[13] = x_w2_in;
      reg_write_enab[13] = 1'b1;
    end

    // field 14
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 14
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 14)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 14))
    begin
      reg_val_next[14] = x_w1_in;
      reg_write_enab[14] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 14)
    begin
      reg_val_next[14] = x_w2_in;
      reg_write_enab[14] = 1'b1;
    end

    // field 15
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 15
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 15)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 15))
    begin
      reg_val_next[15] = x_w1_in;
      reg_write_enab[15] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 15)
    begin
      reg_val_next[15] = x_w2_in;
      reg_write_enab[15] = 1'b1;
    end

    // field 16
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 16
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 16)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 16))
    begin
      reg_val_next[16] = x_w1_in;
      reg_write_enab[16] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 16)
    begin
      reg_val_next[16] = x_w2_in;
      reg_write_enab[16] = 1'b1;
    end

    // field 17
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 17
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 17)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 17))
    begin
      reg_val_next[17] = x_w1_in;
      reg_write_enab[17] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 17)
    begin
      reg_val_next[17] = x_w2_in;
      reg_write_enab[17] = 1'b1;
    end

    // field 18
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 18
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 18)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 18))
    begin
      reg_val_next[18] = x_w1_in;
      reg_write_enab[18] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 18)
    begin
      reg_val_next[18] = x_w2_in;
      reg_write_enab[18] = 1'b1;
    end

    // field 19
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 19
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 19)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 19))
    begin
      reg_val_next[19] = x_w1_in;
      reg_write_enab[19] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 19)
    begin
      reg_val_next[19] = x_w2_in;
      reg_write_enab[19] = 1'b1;
    end

    // field 20
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 20
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 20)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 20))
    begin
      reg_val_next[20] = x_w1_in;
      reg_write_enab[20] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 20)
    begin
      reg_val_next[20] = x_w2_in;
      reg_write_enab[20] = 1'b1;
    end

    // field 21
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 21
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 21)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 21))
    begin
      reg_val_next[21] = x_w1_in;
      reg_write_enab[21] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 21)
    begin
      reg_val_next[21] = x_w2_in;
      reg_write_enab[21] = 1'b1;
    end

    // field 22
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 22
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 22)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 22))
    begin
      reg_val_next[22] = x_w1_in;
      reg_write_enab[22] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 22)
    begin
      reg_val_next[22] = x_w2_in;
      reg_write_enab[22] = 1'b1;
    end

    // field 23
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 23
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 23)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 23))
    begin
      reg_val_next[23] = x_w1_in;
      reg_write_enab[23] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 23)
    begin
      reg_val_next[23] = x_w2_in;
      reg_write_enab[23] = 1'b1;
    end

    // field 24
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 24
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 24)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 24))
    begin
      reg_val_next[24] = x_w1_in;
      reg_write_enab[24] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 24)
    begin
      reg_val_next[24] = x_w2_in;
      reg_write_enab[24] = 1'b1;
    end

    // field 25
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 25
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 25)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 25))
    begin
      reg_val_next[25] = x_w1_in;
      reg_write_enab[25] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 25)
    begin
      reg_val_next[25] = x_w2_in;
      reg_write_enab[25] = 1'b1;
    end

    // field 26
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 26
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 26)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 26))
    begin
      reg_val_next[26] = x_w1_in;
      reg_write_enab[26] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 26)
    begin
      reg_val_next[26] = x_w2_in;
      reg_write_enab[26] = 1'b1;
    end

    // field 27
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 27
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 27)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 27))
    begin
      reg_val_next[27] = x_w1_in;
      reg_write_enab[27] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 27)
    begin
      reg_val_next[27] = x_w2_in;
      reg_write_enab[27] = 1'b1;
    end

    // field 28
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 28
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 28)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 28))
    begin
      reg_val_next[28] = x_w1_in;
      reg_write_enab[28] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 28)
    begin
      reg_val_next[28] = x_w2_in;
      reg_write_enab[28] = 1'b1;
    end

    // field 29
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 29
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 29)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 29))
    begin
      reg_val_next[29] = x_w1_in;
      reg_write_enab[29] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 29)
    begin
      reg_val_next[29] = x_w2_in;
      reg_write_enab[29] = 1'b1;
    end

    // field 30
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 30
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 30)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 30))
    begin
      reg_val_next[30] = x_w1_in;
      reg_write_enab[30] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 30)
    begin
      reg_val_next[30] = x_w2_in;
      reg_write_enab[30] = 1'b1;
    end

    // field 31
    if ( bin_selector_EX == 2'b10 && __X_x_w1_wad_in == 31
      || (X_x_w1_div_main_pdg_en_in && __X_x_w1_wad_in == 31)
         && !(bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 31))
    begin
      reg_val_next[31] = x_w1_in;
      reg_write_enab[31] = 1'b1;
    end
    else if ( bin_selector_EX == 2'b11 && __X_x_w2_waddr_in == 31)
    begin
      reg_val_next[31] = x_w2_in;
      reg_write_enab[31] = 1'b1;
    end

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
      for ( j = 0; j <= 31; j = j + 1)
      begin
        if (reg_write_enab[j])
        begin
          reg_val[j] <= reg_val_next[j];
          // synopsys translate_off
          if (reg_write_enab[j] === 1'b1)
          begin
            reg_write_log[j] <= 1'b1;
          end
          // synopsys translate_on
        end
      end
    end
  end

endmodule
