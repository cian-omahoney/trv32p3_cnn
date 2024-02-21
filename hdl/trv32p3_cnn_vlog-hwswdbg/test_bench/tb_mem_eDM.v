
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:42 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-hwswdbg -cgo_options-hwswdbg.cfg -Itrv32p3_cnn_vlog-hwswdbg/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

module tb_mem_eDM
  #(parameter reg_log = 1'b1,
    parameter eDM_id = 9,
    parameter eDM_size = 8388608,
    parameter eDM_addr_size = 23,
    parameter eDM_data_size = 32,
    parameter eDM_file = "data.eDM"
  )
  ( input         reset,
    input         clock,
    input         edm_ld_in, // uint1_t
    input  [31:0] edm_addr_in, // addr
    output [31:0] edm_rd_out, // v4u8
    input   [3:0] edm_st_in, // uint4_t_as_vect
    input  [31:0] edm_wr_in // v4u8
  );


  reg [31:0] eDM[0:eDM_size - 1];

  event value_changed;

  wire   edm_ld;
  wire   [31:0] edm_addr;
  reg    [31:0] edm_rd;
  reg    [31:0] edm_rd_DLY1;
  wire   [3:0] edm_st;
  reg    [3:0] edm_st_nval;
  reg    [31:0] edm_addr_DLY1;
  wire   [31:0] edm_wr;

  function [29:0] addr_eDM (input [29:0] address);
    begin
      addr_eDM = address;
      if (address < 0 || address >= eDM_size)
      begin
        addr_eDM = 0;
      end
    end
  endfunction

  // input/output port assignment
  assign edm_ld = edm_ld_in;
  assign edm_addr = edm_addr_in;
  assign edm_rd_out = edm_rd;
  assign edm_st = edm_st_in;
  assign edm_wr = edm_wr_in;

  always @ (posedge clock)
  begin
    edm_rd <= edm_rd_DLY1;
    edm_addr_DLY1 <= edm_addr;
  end

  always @ (value_changed or
            edm_ld or
            edm_addr)
  begin : mem_read_eDM

    integer i;
    edm_rd_DLY1 = 0;

    for (i = 0; i < 4; i = i + 1)
    begin
      if (edm_ld) // edm_ld: edm_rd `1` = eDM[edm_addr];
      begin
        edm_rd_DLY1[i*8+7-:8] = eDM[addr_eDM(edm_addr)][i*8+7-:8];
      end
    end
  end

  // Allow change of the memory_init file at runtime:
  reg [255*8:1] appname = eDM_file;
  reg [255*8:1] tmp_appname;
  integer appname_file;
  integer appname_scan_file;

  initial begin
    // check for plusarg:
    if ($value$plusargs("appname=%s",tmp_appname)) begin
      appname = {tmp_appname, ".eDM"};
    end
    else begin
      // no plusarg found, check for appname.cfg file.
      // Note: Some simulators may print a harmless warning when 
      //       the file is not found. This can be safely ignored.
      appname_file = $fopen("appname.cfg", "r");
      if (appname_file != 0) begin
        if (!$feof(appname_file)) begin
          appname_scan_file = $fscanf(appname_file, "%s", tmp_appname);
          appname = {tmp_appname, ".eDM"};
          $fclose(appname_file);
        end
      end
    end
  end

  always @ (posedge reset or posedge clock)
  begin : mem_write_eDM

    integer i;
    integer fd;

    if (reset)
    begin
      for ( i = 0; i <= eDM_size - 1; i = i + 1)
        eDM[i] = 0;
      fd = $fopen(appname, "r");
      if (fd != 0) begin
        $readmemh(appname, eDM);
        $fclose(fd);
        -> value_changed;
      end else begin
        $display("INFO: While loading memory 'eDM': Content file not found, skipping.");
      end
    end
    else
    begin
      edm_st_nval = 0;

      for (i = 0; i < 4; i = i + 1)
      begin
        if (edm_st[i]) // edm_st: eDM[edm_addr] = edm_wr;
        begin
          eDM[addr_eDM(edm_addr)][i*8+7-:8] = edm_wr[i*8+7-:8];

          edm_st_nval[i] = 1;
          -> value_changed;
        end
      end
    end
  end

  always @ (negedge clock)

  begin : mem_log_eDM

    integer i;
    if (reg_log)
    begin
      for (i = 3; i >= 0; i = i - 1)
      begin
        if (edm_st_nval[i])
        begin
          $fdisplay(test_bench.inst_trv32p3_cnn.inst_reg_PC.log_file,
                    "eDM_%0d[%0d] = %h", i, addr_eDM(edm_addr_DLY1), eDM[addr_eDM(edm_addr_DLY1)][i*8+7-:8]);

        end

      end
    end
  end

endmodule
