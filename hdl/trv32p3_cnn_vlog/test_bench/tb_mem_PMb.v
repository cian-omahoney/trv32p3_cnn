
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 18:04:14 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module tb_mem_PMb :  tb_mem_PMb
module tb_mem_PMb
  #(parameter PMb_addr_size = 16,
    parameter PMb_data_size = 8,
    parameter PMb_file = "data.PMb",
    parameter PMb_id = 0,
    parameter PMb_size = 65536,
    parameter reg_log = 1'b1
  )
  ( input         reset,
    input         clock,
    input  [31:0] pm_addr_in, // addr
    input         pm_ld_in, // std_logic
    input         pm_st_in, // std_logic
    input  [31:0] pm_wr_in, // iword
    output [31:0] pm_rd_out // iword
  );


  reg [7:0] PMb[0:PMb_size - 1];

  event value_changed;

  wire   [31:0] pm_addr;
  wire   pm_ld;
  reg    [31:0] pm_rd;
  wire   pm_st;
  wire   [31:0] pm_wr;

  reg [31:0] pm_addr_DLY1;
  reg pm_ld_DLY1;
  reg pm_st_nval;

  function [31:0] addr_PMb (input [31:0] address);
    begin
      addr_PMb = address;
      if (address < 0 || address >= PMb_size)
      begin
        addr_PMb = 0;
      end
    end
  endfunction

  // input/output port assignment
  assign pm_addr = pm_addr_in;
  assign pm_ld = pm_ld_in;
  assign pm_st = pm_st_in;
  assign pm_wr = pm_wr_in;
  assign pm_rd_out = pm_rd;

  always @ (posedge clock)
  begin
    pm_addr_DLY1 <= pm_addr;
    pm_ld_DLY1 <= pm_ld;
  end

  always @ (value_changed or
            pm_ld_DLY1 or
            pm_addr_DLY1)
  begin : mem_read_PMb

    integer i;

    pm_rd = 0;

    if (pm_ld_DLY1) // pm_rd_ld_PM_pm_addr___ocd_ld_PMbEX_r_EX_alw
    begin
      pm_rd = {PMb[addr_PMb(pm_addr_DLY1 + 3)], PMb[addr_PMb(pm_addr_DLY1 + 2)], PMb[addr_PMb(pm_addr_DLY1 + 1)], PMb[addr_PMb(pm_addr_DLY1)]};
    end
    // pm_rd_rd_PM_pm_addr_pm_ld_pdg_en also uses control signal pm_ld_DLY1
  end

  // Allow change of the memory_init file at runtime:
  reg [255*8:1] appname = PMb_file;
  reg [255*8:1] tmp_appname;
  integer appname_file;
  integer appname_scan_file;

  initial begin
    // check for plusarg:
    if ($value$plusargs("appname=%s",tmp_appname)) begin
      appname = {tmp_appname, ".PMb"};
    end
    else begin
      // no plusarg found, check for appname.cfg file.
      // Note: Some simulators may print a harmless warning when 
      //       the file is not found. This can be safely ignored.
      appname_file = $fopen("appname.cfg", "r");
      if (appname_file != 0) begin
        if (!$feof(appname_file)) begin
          appname_scan_file = $fscanf(appname_file, "%s", tmp_appname);
          appname = {tmp_appname, ".PMb"};
          $fclose(appname_file);
        end
      end
    end
  end

  always @ (posedge reset or posedge clock)
  begin : mem_write_PMb

    integer i;

    integer fd;

    if (reset)
    begin
      for ( i = 0; i <= PMb_size - 1; i = i + 1)
        PMb[i] = 0;
      fd = $fopen(appname, "r");
      if (fd != 0) begin
        $readmemh(appname, PMb);
        $fclose(fd);
        -> value_changed;
      end else begin
        $display("INFO: While loading memory 'PMb': Content file not found, skipping.");
      end
    end
    else
    begin
      pm_st_nval = 0;

      if (pm_st) // PM_st_pm_wr_pm_addr___ocd_st_PMbEX_r_EX_alw
      begin
        PMb[addr_PMb(pm_addr + 3)] = pm_wr[31:24];

        PMb[addr_PMb(pm_addr + 2)] = pm_wr[23:16];

        PMb[addr_PMb(pm_addr + 1)] = pm_wr[15:8];

        PMb[addr_PMb(pm_addr)] = pm_wr[7:0];

        pm_st_nval = 1;
        -> value_changed;
      end
    end
  end

  always @ (negedge clock)

  begin : mem_log_PMb


    if (reg_log)
    begin
      if (pm_st_nval)
      begin
        $fdisplay(test_bench.inst_trv32p3_cnn.inst_reg_PC.log_file,
                  "PMb[%0d] = %h", addr_PMb(pm_addr_DLY1), PMb[addr_PMb(pm_addr_DLY1)]);

        $fdisplay(test_bench.inst_trv32p3_cnn.inst_reg_PC.log_file,
                  "PMb[%0d] = %h", addr_PMb(pm_addr_DLY1 + 1), PMb[addr_PMb(pm_addr_DLY1 + 1)]);

        $fdisplay(test_bench.inst_trv32p3_cnn.inst_reg_PC.log_file,
                  "PMb[%0d] = %h", addr_PMb(pm_addr_DLY1 + 2), PMb[addr_PMb(pm_addr_DLY1 + 2)]);

        $fdisplay(test_bench.inst_trv32p3_cnn.inst_reg_PC.log_file,
                  "PMb[%0d] = %h", addr_PMb(pm_addr_DLY1 + 3), PMb[addr_PMb(pm_addr_DLY1 + 3)]);

      end

    end
  end

endmodule
