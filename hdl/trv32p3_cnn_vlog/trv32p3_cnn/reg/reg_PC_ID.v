
// File generated by Go version U-2022.12#33f3808fcb#221128, Thu Feb 29 16:37:16 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module reg_PC_ID : reg_PC_ID
module reg_PC_ID
  // synopsys translate_off
  #(parameter reg_log = 1'b1)
  // synopsys translate_on
  ( input             clock,
    input             PC_ID_PC_ID_w_cntrl_issue_pdg_en_in, // std_logic
    input      [31:0] PC_ID_w_in, // addr
    output reg [31:0] PC_ID_r_out // addr
  );


  reg [31:0] reg_val;

  // synopsys translate_off

  reg reg_write_log;

  always @ (negedge clock)
  begin : p_reg_PC_ID_log


    if (reg_log)
    begin
      if (reg_write_log === 1'b1)
      begin
        $fdisplay(trv32p3_cnn.inst_reg_PC.log_file, "PC_ID = %h", reg_val);
      end
    end
  end
  // synopsys translate_on

  always @ (*)
  begin : p_read_reg_PC_ID

    // PC_ID_r_out = 32'h0;

    // (PC_ID_r_rd_PC_ID_ID)
    // [alu.n:209][ctrl.n:109][ctrl.n:160]
    PC_ID_r_out = reg_val;

  end

  always @ (posedge clock)
  begin : p_write_reg_PC_ID

    // synopsys translate_off
    reg_write_log <= 1'b0;
    // synopsys translate_on

    // (PC_ID_wr_PC_ID_w_PC_ID_PC_ID_w_cntrl_issue_pdg_en)
    if (PC_ID_PC_ID_w_cntrl_issue_pdg_en_in)
    begin
      // synopsys translate_off
      reg_write_log <= 1'b1;
      // synopsys translate_on
      reg_val <= PC_ID_w_in;
    end

  end

endmodule
