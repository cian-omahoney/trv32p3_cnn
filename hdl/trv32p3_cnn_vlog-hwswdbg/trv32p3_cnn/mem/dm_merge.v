
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:22 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-hwswdbg -cgo_options-hwswdbg.cfg -Itrv32p3_cnn_vlog-hwswdbg/tmp_pdg -updg -updg_controller trv32p3_cnn



// module dm_merge : dm_merge

// File generated by pdg version U-2022.12#33f3808fcb#221128
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// pdg -I../lib -D__go__ -Verilog -cgo_options-hwswdbg.cfg -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 +wtrv32p3_cnn_vlog-hwswdbg/tmp_pdg trv32p3_cnn


`timescale 1ns/1ps

module dm_merge
  ( input                    reset,
    input                    clock,
    input             [31:0] wdm_rd_in,
    input             [31:0] dm_addr_in,
    input                    dmw_ld_in,
    input                    dmh_ld_in,
    input                    dmb_ld_in,
    input                    dmw_st_in,
    input                    dmh_st_in,
    input                    dmb_st_in,
    input      signed [31:0] dmw_wr_in,
    input      signed [15:0] dmh_wr_in,
    input       signed [7:0] dmb_wr_in,
    output reg signed [31:0] dmw_rd_out,
    output reg signed [15:0] dmh_rd_out,
    output reg  signed [7:0] dmb_rd_out,
    output reg        [31:0] wdm_addr_out,
    output reg               wdm_ld_out,
    output reg         [3:0] wdm_st_out,
    output reg        [31:0] wdm_wr_out
  );

  reg         [1:0] col_ff;
  reg         [1:0] pdg_update_col_ff;
  reg               pdg_we_col_ff;
  reg         [2:0] st_ff;
  reg         [2:0] pdg_update_st_ff;
  reg               pdg_we_st_ff;

  // process_result
  always @ (*)
  begin : p_process_result
    reg         [7:0] b0;
    reg         [1:0] b1;
    reg         [7:0] b1_0;
    reg         [7:0] tmp;
    reg         [7:0] tmp_0;

    dmb_rd_out = 8'sh0;
    dmh_rd_out = 16'sh0;
    dmw_rd_out = 32'sh0;

    b0 = wdm_rd_in[{col_ff, 3'h0}+:8];
    b1 = col_ff;
    b1_0 = wdm_rd_in[{{b1[1] , 1'b1}, 3'h0}+:8];
    tmp = wdm_rd_in[24+:8];
    tmp_0 = wdm_rd_in[16+:8];
    dmw_rd_out = $signed({tmp , tmp_0 , b1_0 , b0});
    dmh_rd_out = $signed({b1_0 , b0});
    dmb_rd_out = $signed(b0);
  end //p_process_result

  // process_request
  always @ (*)
  begin : p_process_request
    reg        [31:0] row;
    reg         [1:0] col;
    reg         [3:0] t1;
    reg         [2:0] tmp;
    reg         [2:0] tmp_0;
    reg         [2:0] tmp_1;

    wdm_addr_out = 32'h0;
    wdm_ld_out = 1'b0;
    wdm_st_out = 4'h0;
    wdm_wr_out = 32'h0;

    tmp_0 = 3'h0;
    tmp_1 = 3'h0;

    pdg_we_col_ff = 1'b0;
    pdg_update_col_ff = 2'h0;
    pdg_we_st_ff = 1'b0;
    pdg_update_st_ff = 3'h0;

    row = {{2{1'b0}}, dm_addr_in[31 : 2]};
    col = dm_addr_in[1 : 0];
    wdm_addr_out = row;
    wdm_ld_out = dmw_ld_in | dmh_ld_in | dmb_ld_in;
    pdg_we_col_ff = 1'b1;
    pdg_update_col_ff = col;
    t1 = 4'h0;
    if (dmw_st_in)
    begin
      t1 = 4'hF;
    end
    else
    begin
      if (dmh_st_in)
      begin
        t1 = 4'h3 << {col[1] , 1'b0};
      end
      else
      begin
        if (dmb_st_in)
        begin
          t1 = 4'h1 << col;
        end
      end
    end
    wdm_st_out = t1;
    tmp = st_ff;
    if (tmp[2])
    begin
      wdm_wr_out = $unsigned(dmw_wr_in);
    end
    else
    begin
      tmp_0 = st_ff;
      if (tmp_0[1])
      begin
        wdm_wr_out = $unsigned($signed({dmh_wr_in , dmh_wr_in}));
      end
      else
      begin
        tmp_1 = st_ff;
        if (tmp_1[0])
        begin
          wdm_wr_out = $unsigned($signed({dmb_wr_in , dmb_wr_in , dmb_wr_in , dmb_wr_in}));
        end
      end
    end
    pdg_we_st_ff = 1'b1;
    pdg_update_st_ff = {dmw_st_in , dmh_st_in , dmb_st_in};
  end //p_process_request



  always @ (posedge clock or posedge reset)
  begin : p_update_status
    if (reset)
    begin
      col_ff <= 2'h0;
      st_ff <= 3'h0;
    end
    else
    begin
      if (pdg_we_col_ff)
        col_ff <= pdg_update_col_ff;
      if (pdg_we_st_ff)
        st_ff <= pdg_update_st_ff;
    end
  end // p_update_status

endmodule // dm_merge
