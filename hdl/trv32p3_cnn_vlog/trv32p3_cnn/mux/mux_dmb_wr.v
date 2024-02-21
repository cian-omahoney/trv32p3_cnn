
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:34:20 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_dmb_wr : mux_dmb_wr
module mux_dmb_wr
  ( input                    ohe_selector_EX,
    input                    __ocd_st_DMbS3_r_in, // bool
    input       signed [7:0] ocd_data_r_in, // w08
    input      signed [31:0] x_r2_in, // w32
    output reg  signed [7:0] dmb_wr_out // w08
  );


  always @ (*)

  begin : p_mux_dmb_wr

    dmb_wr_out = 8'sh0;

    // (dmb_wr_copy0_ocd_data_r___ocd_st_DMbS3_r_S3_alw)
    if (__ocd_st_DMbS3_r_in)
    begin
      // [ocd.n:80]
      dmb_wr_out = ocd_data_r_in;
    end

    if (ohe_selector_EX) // (dmb_wr_copy0_x_r2_EX)
    begin
      // [ldst.n:99](regX.n:82)
      dmb_wr_out = $signed(x_r2_in[7:0]);
    end

  end

endmodule
