
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:22 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-hwswdbg -cgo_options-hwswdbg.cfg -Itrv32p3_cnn_vlog-hwswdbg/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module reg_PC : reg_PC
module reg_PC
  // synopsys translate_off
  #(parameter hwsw_log_name = "trv32p3_cnn_hwsw.log",
    parameter reg_log = 1'b1
  )
  // synopsys translate_on
  ( input             reset,
    input             clock,
    input             PC_pcw_cntrl_nxtpc_pdg_en_in, // std_logic
    input      [31:0] pcw_in, // addr
    output reg [31:0] pcr_out // addr
  );


  reg [31:0] reg_val;

  reg [31:0] reg_val_next;

  reg  reg_write_enab;


  // synopsys translate_off
  integer cycles;
  integer max_cycles = 0;
  always @ (posedge clock or posedge reset)
  begin : p_cycles_count
    if (reset)
    begin
      cycles <= 0;
    end
    else
    begin
      cycles <= cycles + 1;
    end
  end
  // synopsys translate_on

  // synopsys translate_off
  integer log_file;
  reg     reset_active;
  initial reset_active = 1'b0;
  reg [255*8:1] rcd_file_name = "register.log";
  integer rcdname_file;
  integer rcdname_scan_file;

  // Allow change of the rcd_file_name at runtime:
  initial begin
    if (reg_log)
    begin
      // check for plusarg:
      if (!$value$plusargs("rcdname=%s",rcd_file_name)) begin
        // no plusarg specified, check for rcdname.cfg file.
        // Note: Some simulators may print a harmless warning when 
        //       the file is not found. This can be safely ignored.
        rcdname_file = $fopen("rcdname.cfg", "r");
        if (rcdname_file != 0) begin
          if (!$feof(rcdname_file)) begin
            rcdname_scan_file = $fscanf(rcdname_file, "%s", rcd_file_name);
          end
        end
      end
    end
  end

  always @ (posedge clock or posedge reset)
  // NOTE: The PC value from BEFORE the rising clock edge is logged.
  begin : p_reg_PC_log
    if (reg_log)
    begin
      if (reset)
      begin
        if (~ reset_active)
        begin
          $fclose(log_file);
          log_file = $fopen(rcd_file_name);
          $fdisplay(log_file, "reset_type: async, act_high");
          $fdisplay(log_file, "reset at %0d", $time);
          reset_active = 1'b1;
        end
      end
      else
      begin
        reset_active = 1'b0;
        $fdisplay(log_file, "%0d (%0d)", cycles+1, reg_val);
      end
    end
  end
  // synopsys translate_on

`ifdef HWSW_LOG
  //-----------------------------------------------
  // HWSW log 
  //-----------------------------------------------
  // synopsys translate_off
  function [5:0] hwsw_get_instr_bits (input [2:0] dwords);
    integer i;
    begin
      hwsw_get_instr_bits = 'd1;
      // count ones in output of decode_words
      for (i=0; i<3; i=i+1) begin
        hwsw_get_instr_bits = hwsw_get_instr_bits + dwords[i];
      end
      // multiply with wordsize:
      hwsw_get_instr_bits = hwsw_get_instr_bits * 8;
    end
  endfunction

  integer hwsw_log_file;
  wire hwsw_log_enab;
  wire [31:0] hwsw_reg_val;
  wire [5:0] hwsw_instr_bits;
  wire [2:0] hwsw_dwords;
  reg  hwsw_reset_active;
  reg  hwsw_reset_active_del1;
  reg  hwsw_reset_active_del2;
  wire  hwsw_reset_log;
  initial hwsw_reset_active = 1'b0;
  initial hwsw_reset_active_del1 = 1'b0;
  initial hwsw_reset_active_del2 = 1'b0;

  always @ (posedge clock)
  begin: p_hwsw_reset_log
    hwsw_reset_active_del1 <= hwsw_reset_active;
    hwsw_reset_active_del2 <= hwsw_reset_active_del1;
  end
  assign hwsw_reset_log = hwsw_reset_active_del1 & ~hwsw_reset_active_del2;

  always @ (posedge clock)
  // NOTE: The PC value from BEFORE the rising clock edge is logged.
  begin : p_hwsw_reg_PC_log
    if (reset)
    begin
      if (~hwsw_reset_active)
      begin
        $fclose(hwsw_log_file);
        hwsw_log_file = $fopen(hwsw_log_name);
        hwsw_reset_active = 1'b1;
      end
    end
    else
    begin
      hwsw_reset_active = 1'b0;
      if (hwsw_log_enab)
      begin
        $fdisplay(hwsw_log_file, "%0t PC %h %d", $time, hwsw_reg_val, hwsw_instr_bits);
      end
    end
  end

  reg [31:0] reg_val_ID;
  reg [31:0] reg_val_EX;
  integer cycles_ID;
  integer cycles_EX;
  wire [31:0] cycles_FOCUS_STAGE;
  reg [5:0] hwsw_instr_bits_ID;
  reg [5:0] hwsw_instr_bits_EX;
  assign hwsw_dwords = trv32p3_cnn.inst_decoder.decode_words(trv32p3_cnn.inst_decoder.trn_IR_ID);

  always @ (posedge clock or posedge reset)
  begin : p_hwsw_reg_PC_DLY
    if (reset)
    begin
      reg_val_ID <= 32'd0;
      reg_val_EX <= 32'd0;
      cycles_ID <= 0;
      cycles_EX <= 0;
      hwsw_instr_bits_ID <= 0;
      hwsw_instr_bits_EX <= 0;
    end
    else
    begin
      if (!trv32p3_cnn.hzd_stall && !trv32p3_cnn.kill_ID)
      begin
        reg_val_ID <= reg_val;
      end
      reg_val_EX <= reg_val_ID;
      hwsw_instr_bits_ID <= hwsw_get_instr_bits(hwsw_dwords);
      hwsw_instr_bits_EX <= hwsw_instr_bits_ID;
      cycles_ID <= cycles;
      cycles_EX <= cycles_ID;
    end
  end

  assign hwsw_reg_val = reg_val_EX;
  assign hwsw_instr_bits = hwsw_instr_bits_EX;
  assign hwsw_log_enab = trv32p3_cnn.inst_decoder.reg_EX_valid;
  assign cycles_FOCUS_STAGE = cycles_EX;

  always @ (posedge clock)
  begin : p_max_cycles
    if ((max_cycles != 0) && (cycles_EX >= max_cycles)) begin
      $display("** INFO: Simulation stopped after %0d cycles.", cycles);
      $stop;
    end
  end
  // synopsys translate_on
  //-----------------------------------------------
`else
  // synopsys translate_off
  always @ (negedge clock)
  begin : p_max_cycles
    if ((max_cycles != 0) && (cycles >= max_cycles)) begin
      $display("** INFO: Simulation stopped after %0d cycles.", cycles);
      $stop;
    end
  end
  // synopsys translate_on
`endif

  always @ (*)
  begin : p_read_reg_PC

    // pcr_out = 32'h0;

    // (pcr_rd_PC)
    pcr_out = reg_val;

  end

  always @ (*)
  begin : p_write_combin_reg_PC

    reg_write_enab = 1'h0;
    reg_val_next = 32'h0;


    // (PC_wr_pcw_PC_pcw_cntrl_nxtpc_pdg_en)
    if (PC_pcw_cntrl_nxtpc_pdg_en_in)
    begin
      reg_write_enab = 1'b1;
      reg_val_next = pcw_in;
    end

  end

  always @ (posedge clock or posedge reset)
  begin : p_write_reg_PC

    if (reset)
    begin
      reg_val <= 32'h0;
    end
    else
    begin
      if (reg_write_enab)
        reg_val <= reg_val_next;
    end
  end

endmodule
