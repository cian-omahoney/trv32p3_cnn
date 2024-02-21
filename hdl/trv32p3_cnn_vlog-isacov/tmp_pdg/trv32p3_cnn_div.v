
// File generated by pdg version U-2022.12#33f3808fcb#221128
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// pdg -I../lib -D__go__ -Verilog -cgo_options-isacov.cfg -D__tct_patch__=0 +wtrv32p3_cnn_vlog-isacov/tmp_pdg trv32p3_cnn


`timescale 1ns/1ps

module div
  ( input                    reset,
    input                    clock,
    input              [4:0] div_wad_in,
    input      signed [31:0] divA_in,
    input      signed [31:0] divB_in,
    input                    en_divR_divs_divA_divB_div_EX,
    input                    en_divR_divu_divA_divB_div_EX,
    input                    en_divR_rems_divA_divB_div_EX,
    input                    en_divR_remu_divA_divB_div_EX,
    output reg         [4:0] X_x_w1_div_main_pdg_w_a_out,
    output reg               X_x_w1_div_main_pdg_en_out,
    output reg signed [31:0] x_w1_out,
    output reg               div_bsy_out,
    output reg         [4:0] div_adr_out,
    output reg               div_wnc_out
  );

  reg        [31:0] B;
  reg        [31:0] pdg_update_B;
  reg               pdg_we_B;
  reg        [63:0] PA;
  reg        [63:0] pdg_update_PA;
  reg               pdg_we_PA;
  reg         [4:0] Q_addr_reg;
  reg         [4:0] pdg_update_Q_addr_reg;
  reg               pdg_we_Q_addr_reg;
  reg         [5:0] cnt;
  reg         [5:0] pdg_update_cnt;
  reg               pdg_we_cnt;
  reg               is_div;
  reg               pdg_update_is_div;
  reg               pdg_we_is_div;
  reg               is_neg;
  reg               pdg_update_is_neg;
  reg               pdg_we_is_neg;

  // main
  always @ (*)
  begin : p_main
    reg               is_divs;
    reg               is_divu;
    reg               is_rems;
    reg               is_remu;
    reg               div_start;
    reg signed [31:0] divA_loc;
    reg signed [31:0] divB_loc;
    reg        [63:0] div_step_result;
    reg        [63:0] new_pa;
    reg        [32:0] diff;
    reg        [63:0] pa;
    reg        [31:0] t;
    reg signed [31:0] res;
    reg signed [31:0] res_0;

    X_x_w1_div_main_pdg_en_out = 1'b0;
    X_x_w1_div_main_pdg_w_a_out = 5'h0;
    x_w1_out = 32'sh0;

    divA_loc = 32'sh0;
    divB_loc = 32'sh0;
    div_step_result = 64'h0;
    new_pa = 64'h0;
    diff = 33'h0;
    pa = 64'h0;
    t = 32'h0;
    res = 32'sh0;
    res_0 = 32'sh0;

    pdg_we_B = 1'b0;
    pdg_update_B = 32'h0;
    pdg_we_PA = 1'b0;
    pdg_update_PA = 64'h0;
    pdg_we_Q_addr_reg = 1'b0;
    pdg_update_Q_addr_reg = 5'h0;
    pdg_we_cnt = 1'b0;
    pdg_update_cnt = 6'h0;
    pdg_we_is_div = 1'b0;
    pdg_update_is_div = 1'b0;
    pdg_we_is_neg = 1'b0;
    pdg_update_is_neg = 1'b0;

    is_divs = en_divR_divs_divA_divB_div_EX;
    is_divu = en_divR_divu_divA_divB_div_EX;
    is_rems = en_divR_rems_divA_divB_div_EX;
    is_remu = en_divR_remu_divA_divB_div_EX;
    div_start = cnt == 6'h0 && (is_divs || is_divu || is_rems || is_remu) && div_wad_in != 5'h0;
    if (div_start)
    begin
      if (is_divs || is_rems)
      begin
        if (divA_in[31])
        begin
          divA_loc = -divA_in;
        end
        else
        begin
          divA_loc = divA_in;
        end
        if (divB_in[31])
        begin
          divB_loc = -divB_in;
        end
        else
        begin
          divB_loc = divB_in;
        end
        pdg_we_is_neg = 1'b1;
        pdg_update_is_neg = divA_in[31] ^ divB_in[31] & is_divs;
      end
      else
      begin
        divA_loc = divA_in;
        divB_loc = divB_in;
        pdg_we_is_neg = 1'b1;
        pdg_update_is_neg = 1'b0;
      end
      pdg_we_PA = 1'b1;
      pdg_update_PA = {{32{1'b0}}, $unsigned(divA_loc)};
      pdg_we_B = 1'b1;
      pdg_update_B = $unsigned(divB_loc);
      pdg_we_Q_addr_reg = 1'b1;
      pdg_update_Q_addr_reg = div_wad_in;
      pdg_we_is_div = 1'b1;
      pdg_update_is_div = is_divs || is_divu;
      pdg_we_cnt = 1'b1;
      pdg_update_cnt = 6'h21;
    end
    else
    begin
      if (cnt > 6'h1)
      begin
        new_pa = PA << 1'b1;
        diff = {1'b0, new_pa[63 : 32]} - {1'b0, B};
        if (diff[32] == 1'b0)
        begin
          new_pa[63 : 32] = diff[31:0];
          new_pa[0] = 1'b1;
        end
        div_step_result = new_pa;
        pdg_we_PA = 1'b1;
        pdg_update_PA = div_step_result;
        pdg_we_cnt = 1'b1;
        pdg_update_cnt = cnt - 6'h1;
      end
      else
      begin
        if (cnt == 6'h1)
        begin
          pa = PA;
          if (is_div)
          begin
            t = pa[31 : 0];
          end
          else
          begin
            t = pa[63 : 32];
          end
          res = $signed(t);
          if (is_neg)
          begin
            res_0 = res;
            res = -res_0;
          end
          if (B == 32'h0 && is_div)
          begin
            res = -32'sh1;
          end
          X_x_w1_div_main_pdg_w_a_out = Q_addr_reg;
          X_x_w1_div_main_pdg_en_out = 1'b1;
          x_w1_out = res;
          pdg_we_cnt = 1'b1;
          pdg_update_cnt = cnt - 6'h1;
        end
      end
    end
  end //p_main

  // state_to_core
  always @ (*)
  begin : p_state_to_core

    div_adr_out = 5'h0;
    div_bsy_out = 1'b0;
    div_wnc_out = 1'b0;

    div_bsy_out = cnt != 6'h0;
    div_adr_out = Q_addr_reg;
    div_wnc_out = cnt == 6'h2;
  end //p_state_to_core



  always @ (posedge clock or posedge reset)
  begin : p_update_status
    if (reset)
    begin
      B <= 32'h0;
      PA <= 64'h0;
      Q_addr_reg <= 5'h0;
      cnt <= 6'h0;
      is_div <= 1'b0;
      is_neg <= 1'b0;
    end
    else
    begin
      if (pdg_we_B)
        B <= pdg_update_B;
      if (pdg_we_PA)
        PA <= pdg_update_PA;
      if (pdg_we_Q_addr_reg)
        Q_addr_reg <= pdg_update_Q_addr_reg;
      if (pdg_we_cnt)
        cnt <= pdg_update_cnt;
      if (pdg_we_is_div)
        is_div <= pdg_update_is_div;
      if (pdg_we_is_neg)
        is_neg <= pdg_update_is_neg;
    end
  end // p_update_status

endmodule // div
