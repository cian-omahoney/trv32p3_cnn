
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:21 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-isacov -cgo_options-isacov.cfg -Itrv32p3_cnn_vlog-isacov/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mem_DMb : mem_DMb
module mem_DMb
  ( input              [2:0] bin_selector_EX,
    input              [2:0] bin_selector_ID,
    input                    __ocd_ld_DMbEX_r_in, // bool
    input                    __ocd_st_DMbEX_r_in, // bool
    input                    __ocd_st_DMbS3_r_in, // bool
    input             [31:0] dm_addr_dp_in, // addr
    input       signed [7:0] dmb_rd_in, // w08
    input       signed [7:0] dmb_wr_dp_in, // w08
    input      signed [15:0] dmh_rd_in, // w16
    input      signed [15:0] dmh_wr_dp_in, // w16
    input      signed [31:0] dmw_rd_in, // w32
    input      signed [31:0] dmw_wr_dp_in, // w32
    input                    hzd_stall_in,
    input                    kill_ID_in,
    output reg        [31:0] dm_addr_out, // addr
    output reg               dmb_ld_out, // std_logic
    output reg  signed [7:0] dmb_rd_dp_out, // w08
    output reg               dmb_st_out, // std_logic
    output reg  signed [7:0] dmb_wr_out, // w08
    output reg               dmh_ld_out, // std_logic
    output reg signed [15:0] dmh_rd_dp_out, // w16
    output reg               dmh_st_out, // std_logic
    output reg signed [15:0] dmh_wr_out, // w16
    output reg               dmw_ld_out, // std_logic
    output reg signed [31:0] dmw_rd_dp_out, // w32
    output reg               dmw_st_out, // std_logic
    output reg signed [31:0] dmw_wr_out // w32
  );


  // memory wait states: 0

  always @ (*)

  begin : p_mem_DMb

    dm_addr_out = 32'h0;
    dmb_ld_out = 1'h0;
    // dmb_rd_dp_out = 8'sh0;
    dmb_st_out = 1'h0;
    dmb_wr_out = 8'sh0;
    dmh_ld_out = 1'h0;
    dmh_rd_dp_out = 16'sh0;
    dmh_st_out = 1'h0;
    dmh_wr_out = 16'sh0;
    dmw_ld_out = 1'h0;
    dmw_rd_dp_out = 32'sh0;
    dmw_st_out = 1'h0;
    dmw_wr_out = 32'sh0;

    // (cp_extin_dmb_rd_ld_DMb_dm_addr___ocd_ld_DMbEX_r_EX_alw, cp_extout_DMb_st_dmb_wr_dm_addr___ocd_st_DMbEX_r_EX_alw, cp_extad_DMb_st_dmb_wr_dm_addr___ocd_st_DMbEX_r_EX_alw, cp_extad_dmb_rd_ld_DMb_dm_addr___ocd_ld_DMbEX_r_EX_alw, mem_enab_DMb_st_dmb_wr_dm_addr___ocd_st_DMbEX_r_EX_alw, mem_enab_dmb_rd_ld_DMb_dm_addr___ocd_ld_DMbEX_r_EX_alw)
    // [ocd.n:73]
    dmb_rd_dp_out = dmb_rd_in;
    if (__ocd_st_DMbS3_r_in)
    begin
      // [ocd.n:80]
      dmb_wr_out = dmb_wr_dp_in;
    end
    if (__ocd_st_DMbEX_r_in)
    begin
      // [ocd.n:80]
      dm_addr_out = dm_addr_dp_in;
    end
    if (__ocd_ld_DMbEX_r_in)
    begin
      // [ocd.n:73]
      dm_addr_out = dm_addr_dp_in;
    end
    if (__ocd_st_DMbEX_r_in)
    begin
      // [ocd.n:80]
      dmb_st_out = 1'b1;
    end
    if (__ocd_ld_DMbEX_r_in)
    begin
      // [ocd.n:73]
      dmb_ld_out = 1'b1;
    end

    case (bin_selector_EX)
      3'b001 : // (cp_extin_dmb_rd_ld_DMb_dm_addr_ID)
      begin
        // [ldst.n:62]
        dmb_rd_dp_out = dmb_rd_in;
      end
      3'b010 : // (cp_extout_DMb_st_dmb_wr_dm_addr_ID)
      begin
        // [ldst.n:99]
        dmb_wr_out = dmb_wr_dp_in;
      end
      3'b011 : // (cp_extin_dmh_rd_ld_DMh_dm_addr_ID)
      begin
        // [ldst.n:63]
        dmh_rd_dp_out = dmh_rd_in;
      end
      3'b100 : // (cp_extout_DMh_st_dmh_wr_dm_addr_ID)
      begin
        // [ldst.n:100]
        dmh_wr_out = dmh_wr_dp_in;
      end
      3'b101 : // (cp_extin_dmw_rd_ld_DMw_dm_addr_ID)
      begin
        // [ldst.n:64]
        dmw_rd_dp_out = dmw_rd_in;
      end
      3'b110 : // (cp_extout_DMw_st_dmw_wr_dm_addr_ID)
      begin
        // [ldst.n:101]
        dmw_wr_out = dmw_wr_dp_in;
      end
      default :
        ; // null
    endcase

    case (bin_selector_ID)
      3'b001 : // (mem_enab_DMb_st_dmb_wr_dm_addr_ID, cp_extad_DMb_st_dmb_wr_dm_addr_ID)
      begin
        // [ldst.n:99]
        if (!kill_ID_in && !hzd_stall_in)
          dmb_st_out = 1'b1;
        // [ldst.n:99]
        dm_addr_out = dm_addr_dp_in;
      end
      3'b010 : // (mem_enab_DMh_st_dmh_wr_dm_addr_ID, cp_extad_DMh_st_dmh_wr_dm_addr_ID)
      begin
        // [ldst.n:100]
        if (!kill_ID_in && !hzd_stall_in)
          dmh_st_out = 1'b1;
        // [ldst.n:100]
        dm_addr_out = dm_addr_dp_in;
      end
      3'b011 : // (mem_enab_DMw_st_dmw_wr_dm_addr_ID, cp_extad_DMw_st_dmw_wr_dm_addr_ID)
      begin
        // [ldst.n:101]
        if (!kill_ID_in && !hzd_stall_in)
          dmw_st_out = 1'b1;
        // [ldst.n:101]
        dm_addr_out = dm_addr_dp_in;
      end
      3'b100 : // (mem_enab_dmb_rd_ld_DMb_dm_addr_ID, cp_extad_dmb_rd_ld_DMb_dm_addr_ID)
      begin
        // [ldst.n:62]
        if (!kill_ID_in && !hzd_stall_in)
          dmb_ld_out = 1'b1;
        // [ldst.n:62]
        dm_addr_out = dm_addr_dp_in;
      end
      3'b101 : // (mem_enab_dmh_rd_ld_DMh_dm_addr_ID, cp_extad_dmh_rd_ld_DMh_dm_addr_ID)
      begin
        // [ldst.n:63]
        if (!kill_ID_in && !hzd_stall_in)
          dmh_ld_out = 1'b1;
        // [ldst.n:63]
        dm_addr_out = dm_addr_dp_in;
      end
      3'b110 : // (mem_enab_dmw_rd_ld_DMw_dm_addr_ID, cp_extad_dmw_rd_ld_DMw_dm_addr_ID)
      begin
        // [ldst.n:64]
        if (!kill_ID_in && !hzd_stall_in)
          dmw_ld_out = 1'b1;
        // [ldst.n:64]
        dm_addr_out = dm_addr_dp_in;
      end
      default :
        ; // null
    endcase

  end

endmodule
