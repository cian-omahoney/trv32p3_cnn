
// File generated by Go version U-2022.12#33f3808fcb#221128, Thu Feb 29 15:23:21 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



// module dm_wbb : dm_wbb

// File generated by pdg version U-2022.12#33f3808fcb#221128
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// pdg -I../lib -D__go__ -Verilog -cgo_options.cfg -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 +wtrv32p3_cnn_vlog/tmp_pdg trv32p3_cnn


`timescale 1ns/1ps

module dm_wbb
  ( input             reset,
    input             clock,
    input      [31:0] edm_rd_in,
    input             wdm_ld_in,
    input      [31:0] wdm_addr_in,
    input      [31:0] wdm_wr_in,
    input       [3:0] wdm_st_in,
    output reg [31:0] wdm_rd_out,
    output reg        edm_ld_out,
    output reg [31:0] edm_addr_out,
    output reg  [3:0] edm_st_out,
    output reg [31:0] edm_wr_out
  );

  reg        [31:0] edm_addr_ff;
  reg        [31:0] pdg_update_edm_addr_ff;
  reg               pdg_we_edm_addr_ff;
  reg               edm_addr_match_ff;
  reg               pdg_update_edm_addr_match_ff;
  reg               pdg_we_edm_addr_match_ff;
  reg        [31:0] edm_data_ff;
  reg        [31:0] pdg_update_edm_data_ff;
  reg               pdg_we_edm_data_ff;
  reg               edm_st_ff;
  reg               pdg_update_edm_st_ff;
  reg               pdg_we_edm_st_ff;
  reg         [3:0] edm_strb_ff;
  reg         [3:0] pdg_update_edm_strb_ff;
  reg               pdg_we_edm_strb_ff;
  reg               edm_wbb_ff;
  reg               pdg_update_edm_wbb_ff;
  reg               pdg_we_edm_wbb_ff;

  // process_result
  always @ (*)
  begin : p_process_result
    reg               byp;
    reg         [3:0] sel;
    reg         [7:0] t;
    reg         [7:0] t_0;
    reg        [31:0] t_1;
    reg         [7:0] t_2;
    reg         [7:0] t_3;
    reg         [7:0] t_4;
    reg        [31:0] t_5;
    reg         [7:0] t_6;
    reg         [7:0] t_7;
    reg         [7:0] t_8;
    reg        [31:0] t_9;
    reg         [7:0] t_10;
    reg         [7:0] t_11;
    reg         [7:0] t_12;
    reg        [31:0] t_13;
    reg         [7:0] t_14;

    wdm_rd_out = 32'h0;

    t_0 = 8'h0;
    t_1 = 32'h0;
    t_2 = 8'h0;
    t_4 = 8'h0;
    t_5 = 32'h0;
    t_6 = 8'h0;
    t_8 = 8'h0;
    t_9 = 32'h0;
    t_10 = 8'h0;
    t_12 = 8'h0;
    t_13 = 32'h0;
    t_14 = 8'h0;

    byp = edm_wbb_ff && edm_addr_match_ff;
    sel = edm_strb_ff & {byp , byp , byp , byp};
    if (sel[3] == 1'b0)
    begin
      t_0 = edm_rd_in[24+:8];
      t = t_0;
    end
    else
    begin
      t_1 = edm_data_ff;
      t_2 = t_1[24+:8];
      t = t_2;
    end
    if (sel[2] == 1'b0)
    begin
      t_4 = edm_rd_in[16+:8];
      t_3 = t_4;
    end
    else
    begin
      t_5 = edm_data_ff;
      t_6 = t_5[16+:8];
      t_3 = t_6;
    end
    if (sel[1] == 1'b0)
    begin
      t_8 = edm_rd_in[8+:8];
      t_7 = t_8;
    end
    else
    begin
      t_9 = edm_data_ff;
      t_10 = t_9[8+:8];
      t_7 = t_10;
    end
    if (sel[0] == 1'b0)
    begin
      t_12 = edm_rd_in[0+:8];
      t_11 = t_12;
    end
    else
    begin
      t_13 = edm_data_ff;
      t_14 = t_13[0+:8];
      t_11 = t_14;
    end
    wdm_rd_out = {t , t_3 , t_7 , t_11};
  end //p_process_result

  // process_request
  always @ (*)
  begin : p_process_request
    reg               L0;
    reg         [3:0] L0_0;
    reg         [2:0] pdg_it;

    edm_addr_out = 32'h0;
    edm_ld_out = 1'b0;
    edm_st_out = 4'h0;
    edm_wr_out = 32'h0;

    pdg_we_edm_addr_ff = 1'b0;
    pdg_update_edm_addr_ff = 32'h0;
    pdg_we_edm_addr_match_ff = 1'b0;
    pdg_update_edm_addr_match_ff = 1'b0;
    pdg_we_edm_data_ff = 1'b0;
    pdg_update_edm_data_ff = 32'h0;
    pdg_we_edm_st_ff = 1'b0;
    pdg_update_edm_st_ff = 1'b0;
    pdg_we_edm_strb_ff = 1'b0;
    pdg_update_edm_strb_ff = 4'h0;
    pdg_we_edm_wbb_ff = 1'b0;
    pdg_update_edm_wbb_ff = 1'b0;

    edm_ld_out = wdm_ld_in;
    if (wdm_ld_in)
    begin
      edm_addr_out = wdm_addr_in;
      pdg_we_edm_addr_match_ff = 1'b1;
      pdg_update_edm_addr_match_ff = wdm_addr_in == edm_addr_ff;
    end
    L0 = 1'b0;
    for (pdg_it = 0; pdg_it < 4; pdg_it = pdg_it + 1)
    begin
      L0_0[pdg_it] = L0;
    end
    edm_st_out = L0_0;
    if (wdm_ld_in)
    begin
      if (edm_st_ff)
      begin
        pdg_we_edm_data_ff = 1'b1;
        pdg_update_edm_data_ff = wdm_wr_in;
        pdg_we_edm_wbb_ff = 1'b1;
        pdg_update_edm_wbb_ff = 1'b1;
      end
    end
    else
    begin
      if (edm_wbb_ff)
      begin
        edm_st_out = edm_strb_ff;
        edm_addr_out = edm_addr_ff;
        edm_wr_out = edm_data_ff;
        pdg_we_edm_wbb_ff = 1'b1;
        pdg_update_edm_wbb_ff = 1'b0;
      end
      else
      begin
        if (edm_st_ff)
        begin
          edm_st_out = edm_strb_ff;
          edm_addr_out = edm_addr_ff;
          edm_wr_out = wdm_wr_in;
        end
      end
      if (wdm_st_in != 4'h0)
      begin
        pdg_we_edm_addr_ff = 1'b1;
        pdg_update_edm_addr_ff = wdm_addr_in;
        pdg_we_edm_strb_ff = 1'b1;
        pdg_update_edm_strb_ff = wdm_st_in;
      end
    end
    pdg_we_edm_st_ff = 1'b1;
    pdg_update_edm_st_ff = wdm_st_in != 4'h0;
  end //p_process_request



  always @ (posedge clock or posedge reset)
  begin : p_update_status
    if (reset)
    begin
      edm_addr_ff <= 32'h0;
      edm_addr_match_ff <= 1'b0;
      edm_data_ff <= 32'h0;
      edm_st_ff <= 1'b0;
      edm_strb_ff <= 4'h0;
      edm_wbb_ff <= 1'b0;
    end
    else
    begin
      if (pdg_we_edm_addr_ff)
        edm_addr_ff <= pdg_update_edm_addr_ff;
      if (pdg_we_edm_addr_match_ff)
        edm_addr_match_ff <= pdg_update_edm_addr_match_ff;
      if (pdg_we_edm_data_ff)
        edm_data_ff <= pdg_update_edm_data_ff;
      if (pdg_we_edm_st_ff)
        edm_st_ff <= pdg_update_edm_st_ff;
      if (pdg_we_edm_strb_ff)
        edm_strb_ff <= pdg_update_edm_strb_ff;
      if (pdg_we_edm_wbb_ff)
        edm_wbb_ff <= pdg_update_edm_wbb_ff;
    end
  end // p_update_status

endmodule // dm_wbb
