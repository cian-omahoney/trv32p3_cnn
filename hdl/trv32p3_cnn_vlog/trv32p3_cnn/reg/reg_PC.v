
// File generated by Go version U-2022.12#33f3808fcb#221128, Tue Mar 19 17:13:41 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module reg_PC : reg_PC
module reg_PC
  // synopsys translate_off
  #(parameter reg_log = 1'b1)
  // synopsys translate_on
  ( input             reset,
    input             clock,
    input             PC_pcw_cntrl_nxtpc_pdg_en_in, // std_logic
    input      [31:0] pcw_in, // addr
    output reg [31:0] pcr_out // addr
  );


  reg [31:0] reg_val;

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

  always @ (negedge clock)
  begin : p_max_cycles
    if ((max_cycles != 0) && (cycles >= max_cycles)) begin
      $display("** INFO: Simulation stopped after %0d cycles.", cycles);
      $stop;
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

  always @ (*)
  begin : p_read_reg_PC

    // pcr_out = 32'h0;

    // (pcr_rd_PC)
    pcr_out = reg_val;

  end

  always @ (posedge clock or posedge reset)
  begin : p_write_reg_PC

    if (reset)
    begin
      reg_val <= 32'h0;
    end
    else
    begin

      // (PC_wr_pcw_PC_pcw_cntrl_nxtpc_pdg_en)
      if (PC_pcw_cntrl_nxtpc_pdg_en_in)
      begin
        reg_val <= pcw_in;
      end

    end
  end

endmodule
