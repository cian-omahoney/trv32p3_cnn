
// File generated by Go version U-2022.12#33f3808fcb#221128, Fri Mar  8 16:47:01 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module reg_PC_EX : reg_PC_EX
module reg_PC_EX
  // synopsys translate_off
  #(parameter reg_log = 1'b1)
  // synopsys translate_on
  ( input             clock,
    input             ohe_selector_ID,
    input      [31:0] PC_EX_w_in, // addr
    input             hzd_stall_in,
    input             kill_ID_in,
    output reg [31:0] PC_EX_r_out // addr
  );


  reg [31:0] reg_val;

  // synopsys translate_off

  reg reg_write_log;

  always @ (negedge clock)
  begin : p_reg_PC_EX_log


    if (reg_log)
    begin
      if (reg_write_log === 1'b1)
      begin
        $fdisplay(trv32p3_cnn.inst_reg_PC.log_file, "PC_EX = %h", reg_val);
      end
    end
  end
  // synopsys translate_on

  always @ (*)
  begin : p_read_reg_PC_EX

    // PC_EX_r_out = 32'h0;

    // (PC_EX_r_rd_PC_EX_EX)
    // [alu.n:210]
    PC_EX_r_out = reg_val;

  end

  always @ (posedge clock)
  begin : p_write_reg_PC_EX

    // synopsys translate_off
    reg_write_log <= 1'b0;
    // synopsys translate_on

    if (!hzd_stall_in && !kill_ID_in)
    begin

      if (ohe_selector_ID) // (PC_EX_wr_PC_EX_w_ID)
      begin
        // [alu.n:209]
        // synopsys translate_off
        reg_write_log <= 1'b1;
        // synopsys translate_on
        reg_val <= PC_EX_w_in;
      end

    end

  end

endmodule
