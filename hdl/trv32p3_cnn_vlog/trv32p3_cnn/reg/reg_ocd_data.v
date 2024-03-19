
// File generated by Go version U-2022.12#33f3808fcb#221128, Tue Mar 19 15:58:50 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module reg_ocd_data : reg_ocd_data
module reg_ocd_data
  // synopsys translate_off
  #(parameter reg_log = 1'b1)
  // synopsys translate_on
  ( input                   reset,
    input                   clock,
    input                   __ocd_ld_DMbS3_r_in, // bool
    input                   en_ocd_data_pdcw_in, // std_logic
    input      signed [7:0] ocd_data_pdcw_in, // w08
    input      signed [7:0] ocd_data_w_in, // w08
    output reg signed [7:0] ocd_data_pdcr_out, // w08
    output reg signed [7:0] ocd_data_r_out // w08
  );


  reg signed [7:0] reg_val;

  // synopsys translate_off

  reg reg_write_log;

  always @ (negedge clock)
  begin : p_reg_ocd_data_log


    if (reg_log)
    begin
      if (reg_write_log === 1'b1)
      begin
        $fdisplay(trv32p3_cnn.inst_reg_PC.log_file, "ocd_data = %h", reg_val);
      end
    end
  end
  // synopsys translate_on

  always @ (*)
  begin : p_read_reg_ocd_data

    // ocd_data_pdcr_out = 8'sh0;
    // ocd_data_r_out = 8'sh0;

    // (ocd_data_pdcr_rd_ocd_data, ocd_data_r_rd_ocd_data_alw)
    ocd_data_pdcr_out = reg_val;
    // [ocd.n:64]
    ocd_data_r_out = reg_val;

  end

  always @ (posedge clock or posedge reset)
  begin : p_write_reg_ocd_data

    if (reset)
    begin
      // synopsys translate_off
      reg_write_log <= 1'b0;
      // synopsys translate_on
      reg_val <= 8'sh0;
    end
    else
    begin
      // synopsys translate_off
      reg_write_log <= 1'b0;
      // synopsys translate_on

      // (ocd_data_wr_ocd_data_w___ocd_ld_DMbS3_r_S3_alw, ocd_data_wr_ocd_data_pdcw)
      if (__ocd_ld_DMbS3_r_in)
      begin
        // [ocd.n:73]
        // synopsys translate_off
        reg_write_log <= 1'b1;
        // synopsys translate_on
        reg_val <= ocd_data_w_in;
      end
      if (en_ocd_data_pdcw_in)
      begin
        // synopsys translate_off
        reg_write_log <= 1'b1;
        // synopsys translate_on
        reg_val <= ocd_data_pdcw_in;
      end

    end
  end

endmodule
