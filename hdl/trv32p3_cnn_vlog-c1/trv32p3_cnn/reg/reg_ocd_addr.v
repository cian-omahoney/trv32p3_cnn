
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:43 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-c1 -cgo_options-c1.cfg -Itrv32p3_cnn_vlog-c1/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module reg_ocd_addr : reg_ocd_addr
module reg_ocd_addr
  // synopsys translate_off
  #(parameter reg_log = 1'b1)
  // synopsys translate_on
  ( input             reset,
    input             clock,
    input             __ocd_ld_DMbEX_r_in, // bool
    input             __ocd_ld_PMbEX_r_in, // bool
    input             __ocd_st_DMbEX_r_in, // bool
    input             __ocd_st_PMbEX_r_in, // bool
    input             en_ocd_addr_pdcw_in, // std_logic
    input      [31:0] ocd_addr_pdcw_in, // addr
    input      [31:0] ocd_addr_w_in, // addr
    output reg [31:0] ocd_addr_pdcr_out, // addr
    output reg [31:0] ocd_addr_r_out // addr
  );


  reg [31:0] reg_val;

  reg [31:0] reg_val_next;

  reg  reg_write_enab;


  // synopsys translate_off

  reg reg_write_log;

  always @ (negedge clock)
  begin : p_reg_ocd_addr_log


    if (reg_log)
    begin
      if (reg_write_log === 1'b1)
      begin
        $fdisplay(trv32p3_cnn.inst_reg_PC.log_file, "ocd_addr = %h", reg_val);
      end
    end
  end
  // synopsys translate_on

  always @ (*)
  begin : p_read_reg_ocd_addr

    // ocd_addr_pdcr_out = 32'h0;
    // ocd_addr_r_out = 32'h0;

    // (ocd_addr_pdcr_rd_ocd_addr, ocd_addr_r_rd_ocd_addr_alw)
    ocd_addr_pdcr_out = reg_val;
    // [ocd.n:63]
    ocd_addr_r_out = reg_val;

  end

  always @ (*)
  begin : p_write_combin_reg_ocd_addr

    reg_write_enab = 1'h0;
    // next value assigned here to avoid latches and simplify muxes
    reg_val_next = ocd_addr_w_in;


    // (ocd_addr_wr_ocd_addr_w___ocd_ld_DMbEX_r_EX_alw, ocd_addr_wr_ocd_addr_w___ocd_ld_PMbEX_r_EX_alw, ocd_addr_wr_ocd_addr_w___ocd_st_DMbEX_r_EX_alw, ocd_addr_wr_ocd_addr_w___ocd_st_PMbEX_r_EX_alw, ocd_addr_wr_ocd_addr_pdcw)
    if (__ocd_ld_DMbEX_r_in)
    begin
      // [ocd.n:71]
      reg_write_enab = 1'b1;
    end
    if (__ocd_ld_PMbEX_r_in)
    begin
      // [ocd.n:87]
      reg_write_enab = 1'b1;
      reg_val_next = ocd_addr_w_in;
    end
    if (__ocd_st_DMbEX_r_in)
    begin
      // [ocd.n:78]
      reg_write_enab = 1'b1;
      reg_val_next = ocd_addr_w_in;
    end
    if (__ocd_st_PMbEX_r_in)
    begin
      // [ocd.n:94]
      reg_write_enab = 1'b1;
      reg_val_next = ocd_addr_w_in;
    end
    if (en_ocd_addr_pdcw_in)
    begin
      reg_write_enab = 1'b1;
      reg_val_next = ocd_addr_pdcw_in;
    end

  end

  always @ (posedge clock or posedge reset)
  begin : p_write_reg_ocd_addr

    if (reset)
    begin
      // synopsys translate_off
      reg_write_log <= 1'b0;
      // synopsys translate_on
      reg_val <= 32'h0;
    end
    else
    begin
      // synopsys translate_off
      reg_write_log <= 1'b0;
      // synopsys translate_on
      if (reg_write_enab)
      begin
        reg_val <= reg_val_next;
        // synopsys translate_off
        if (reg_write_enab === 1'b1)
        begin
          reg_write_log <= 1'b1;
        end
        // synopsys translate_on
      end
    end
  end

endmodule
