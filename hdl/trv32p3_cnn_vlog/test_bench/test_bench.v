
// File generated by Go version U-2022.12#33f3808fcb#221128, Thu Feb 29 17:34:04 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

module test_bench;
  wire clock;
  wire reset;
  wire [31:0] pm_rd;
  wire [31:0] pm_addr;
  wire [31:0] pm_wr;
  wire pm_st;
  wire pm_ld;
  wire jtag_tck;
  wire jtag_tms;
  wire jtag_tdi;
  wire jtag_tdo;
  wire jtag_trst;
  wire dbg_ext_break;
  wire dbg_set_break;
  wire edm_ld;
  wire [31:0] edm_addr;
  wire [31:0] edm_rd;
  wire [3:0] edm_st;
  wire [31:0] edm_wr;

  parameter clock_period = 2.000;
  parameter reset_start = 0;
  parameter reset_width = 250;
  parameter ocd_clock_freq = 100;
  parameter ocd_remember_data_select = 0;
  parameter reg_log = 1'b1;
  parameter PMb_addr_size = 9;
  parameter PMb_data_size = 8;
  parameter PMb_file = "data.PMb";
  parameter PMb_id = 0;
  parameter PMb_size = 512;
  parameter eDM_id = 9;
  parameter eDM_size = 512;
  parameter eDM_addr_size = 9;
  parameter eDM_data_size = 32;
  parameter eDM_file = "data.eDM";
  parameter nid = 1;

  clock_gen
  #(.clock_period(clock_period),
    .reset_start(reset_start),
    .reset_width(reset_width))
  inst_clock_gen(
      .reset_out(reset),
      .clock_out(clock));

  tb_mem_PMb
  #(.PMb_addr_size(PMb_addr_size),
    .PMb_data_size(PMb_data_size),
    .PMb_file(PMb_file),
    .PMb_id(PMb_id),
    .PMb_size(PMb_size),
    .reg_log(reg_log))
  inst_tb_mem_PMb(
      .reset(reset),
      .clock(clock),
      .pm_addr_in(pm_addr),
      .pm_ld_in(pm_ld),
      .pm_st_in(pm_st),
      .pm_wr_in(pm_wr),
      .pm_rd_out(pm_rd));

  tb_mem_eDM
  #(.reg_log(reg_log),
    .eDM_id(eDM_id),
    .eDM_size(eDM_size),
    .eDM_addr_size(eDM_addr_size),
    .eDM_data_size(eDM_data_size),
    .eDM_file(eDM_file))
  inst_tb_mem_eDM(
      .reset(reset),
      .clock(clock),
      .edm_ld_in(edm_ld),
      .edm_addr_in(edm_addr),
      .edm_rd_out(edm_rd),
      .edm_st_in(edm_st),
      .edm_wr_in(edm_wr));

  trv32p3_cnn
  #(.reg_log(reg_log),
    .nid(nid))
  inst_trv32p3_cnn(
      .clock(clock),
      .reset_ext(reset),
      .pm_rd_in(pm_rd),
      .pm_addr_out(pm_addr),
      .pm_wr_out(pm_wr),
      .pm_st_out(pm_st),
      .pm_ld_out(pm_ld),
      .jtag_tck_in(jtag_tck),
      .jtag_tms_in(jtag_tms),
      .jtag_tdi_in(jtag_tdi),
      .jtag_tdo_out(jtag_tdo),
      .jtag_trst(jtag_trst),
      .dbg_ext_break_in(dbg_ext_break),
      .dbg_set_break_out(dbg_set_break),
      .edm_ld_out(edm_ld),
      .edm_addr_out(edm_addr),
      .edm_rd_in(edm_rd),
      .edm_st_out(edm_st),
      .edm_wr_out(edm_wr));

  jtag_emulator
  #(.ocd_clock_freq(ocd_clock_freq),
    .ocd_remember_data_select(ocd_remember_data_select))
  inst_jtag_emulator(
      .jtag_tdo_in(jtag_tdo),
      .jtag_tck_out(jtag_tck),
      .jtag_tdi_out(jtag_tdi),
      .jtag_tms_out(jtag_tms),
      .jtag_trst_out(jtag_trst));

  assign dbg_ext_break = 0;
endmodule
