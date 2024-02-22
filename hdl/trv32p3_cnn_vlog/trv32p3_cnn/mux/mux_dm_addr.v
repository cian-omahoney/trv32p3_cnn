
// File generated by Go version U-2022.12#33f3808fcb#221128, Thu Feb 22 16:53:34 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_dm_addr : mux_dm_addr
module mux_dm_addr
  ( input                    ohe_selector_ID,
    input                    __ocd_ld_DMbEX_r_in, // bool
    input                    __ocd_st_DMbEX_r_in, // bool
    input      signed [31:0] aguR_in, // w32
    input             [31:0] ocd_addr_r_in, // addr
    output reg        [31:0] dm_addr_out // addr
  );


  always @ (*)

  begin : p_mux_dm_addr

    dm_addr_out = 32'h0;

    // (dm_addr_copy0_ocd_addr_r___ocd_ld_DMbEX_r_EX_alw, dm_addr_copy0_ocd_addr_r___ocd_st_DMbEX_r_EX_alw)
    if (__ocd_ld_DMbEX_r_in)
    begin
      // [ocd.n:73]
      dm_addr_out = ocd_addr_r_in;
    end
    if (__ocd_st_DMbEX_r_in)
    begin
      // [ocd.n:80]
      dm_addr_out = ocd_addr_r_in;
    end

    if (ohe_selector_ID) // (dm_addr_copy0_aguR_ID)
    begin
      // [ldst.n:58][ldst.n:95]
      dm_addr_out = $unsigned(aguR_in);
    end

  end

endmodule
