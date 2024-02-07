
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb  7 12:35:08 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mem_PMb : mem_PMb
module mem_PMb
  ( input             __ocd_ld_PMbEX_r_in, // bool
    input             __ocd_st_PMbEX_r_in, // bool
    input             pm_ld_pdg_en_in, // std_logic
    input      [31:0] pm_addr_dp_in, // addr
    input      [31:0] pm_rd_in, // iword
    input      [31:0] pm_wr_dp_in, // iword
    output reg [31:0] pm_addr_out, // addr
    output reg        pm_ld_out, // std_logic
    output reg [31:0] pm_rd_dp_out, // iword
    output reg        pm_st_out, // std_logic
    output reg [31:0] pm_wr_out // iword
  );


  always @ (*)

  begin : p_mem_PMb

    pm_addr_out = 32'h0;
    pm_ld_out = 1'h0;
    // pm_rd_dp_out = 32'h0;
    pm_st_out = 1'h0;
    pm_wr_out = 32'h0;

    // (cp_extin_pm_rd_ld_PM_pm_addr___ocd_ld_PMbEX_r_EX_alw, cp_extad_PM_st_pm_wr_pm_addr___ocd_st_PMbEX_r_EX_alw, cp_extad_pm_rd_ld_PM_pm_addr___ocd_ld_PMbEX_r_EX_alw, cp_extout_PM_st_pm_wr_pm_addr___ocd_st_PMbEX_r_EX_alw, cp_extin_pm_rd_rd_PM_pm_addr_pm_ld_pdg_en, mem_enab_PM_st_pm_wr_pm_addr___ocd_st_PMbEX_r_EX_alw, mem_enab_pm_rd_ld_PM_pm_addr___ocd_ld_PMbEX_r_EX_alw, mem_enab_pm_rd_rd_PM_pm_addr_pm_ld_pdg_en, cp_extad_pm_rd_rd_PM_pm_addr_pm_ld_pdg_en)
    // [ocd.n:89]
    pm_rd_dp_out = pm_rd_in;
    if (__ocd_st_PMbEX_r_in)
    begin
      // [ocd.n:95]
      pm_addr_out = pm_addr_dp_in;
    end
    if (__ocd_ld_PMbEX_r_in)
    begin
      // [ocd.n:89]
      pm_addr_out = pm_addr_dp_in;
    end
    if (__ocd_st_PMbEX_r_in)
    begin
      // [ocd.n:95]
      pm_wr_out = pm_wr_dp_in;
    end
    if (__ocd_st_PMbEX_r_in)
    begin
      // [ocd.n:95]
      pm_st_out = 1'b1;
    end
    if (__ocd_ld_PMbEX_r_in)
    begin
      // [ocd.n:89]
      pm_ld_out = 1'b1;
    end
    if (pm_ld_pdg_en_in)
    begin
      pm_ld_out = 1'b1;
      pm_addr_out = pm_addr_dp_in;
    end

  end

endmodule
