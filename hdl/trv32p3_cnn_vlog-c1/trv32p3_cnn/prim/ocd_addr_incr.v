
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:43 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-c1 -cgo_options-c1.cfg -Itrv32p3_cnn_vlog-c1/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module ocd_addr_incr : ocd_addr_incr
module ocd_addr_incr
  ( input             __ocd_ld_PMbEX_r_in, // bool
    input             __ocd_st_DMbEX_r_in, // bool
    input             __ocd_st_PMbEX_r_in, // bool
    input      [31:0] ocd_addr_r_in, // addr
    output reg [31:0] ocd_addr_w_out // addr
  );


`include "primitives.v"

  always @ (*)

  begin : p_ocd_addr_incr

    // ocd_addr_w_out = 32'h0;

    // (ocd_addr_w_incr1_ocd_addr_r_ocd_addr_incr___ocd_ld_DMbEX_r_EX_alw, ocd_addr_w_incr1_ocd_addr_r_ocd_addr_incr___ocd_st_DMbEX_r_EX_alw, ocd_addr_w_incr4_ocd_addr_r_ocd_addr_incr___ocd_ld_PMbEX_r_EX_alw, ocd_addr_w_incr4_ocd_addr_r_ocd_addr_incr___ocd_st_PMbEX_r_EX_alw)
    // [ocd.n:71]
    addr_incr1_addr(ocd_addr_w_out, ocd_addr_r_in);
    if (__ocd_st_DMbEX_r_in)
    begin
      // [ocd.n:78]
      addr_incr1_addr(ocd_addr_w_out, ocd_addr_r_in);
    end
    if (__ocd_ld_PMbEX_r_in)
    begin
      // [ocd.n:87]
      addr_incr4_addr(ocd_addr_w_out, ocd_addr_r_in);
    end
    if (__ocd_st_PMbEX_r_in)
    begin
      // [ocd.n:94]
      addr_incr4_addr(ocd_addr_w_out, ocd_addr_r_in);
    end

  end

endmodule
