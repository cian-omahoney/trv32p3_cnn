
// File generated by Go version U-2022.12#33f3808fcb#221128, Sat Mar 16 14:40:42 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_pm_addr : mux_pm_addr
module mux_pm_addr
  ( input             __ocd_ld_PMbEX_r_in, // bool
    input             __ocd_st_PMbEX_r_in, // bool
    input             pm_ld_pdg_en_in, // std_logic
    input      [31:0] ocd_addr_r_in, // addr
    input      [31:0] pm_addr1_in, // addr
    output reg [31:0] pm_addr_out // addr
  );


  always @ (*)

  begin : p_mux_pm_addr

    pm_addr_out = 32'h0;

    // (pm_addr_copy0_ocd_addr_r___ocd_ld_PMbEX_r_EX_alw, pm_addr_copy0_ocd_addr_r___ocd_st_PMbEX_r_EX_alw)
    if (__ocd_ld_PMbEX_r_in)
    begin
      // [ocd.n:89]
      pm_addr_out = ocd_addr_r_in;
    end
    if (__ocd_st_PMbEX_r_in)
    begin
      // [ocd.n:95]
      pm_addr_out = ocd_addr_r_in;
    end

    // (pm_addr_copy_pm_addr1_pm_ld_pdg_en)
    if (pm_ld_pdg_en_in)
    begin
      pm_addr_out = pm_addr1_in;
    end

  end

endmodule
