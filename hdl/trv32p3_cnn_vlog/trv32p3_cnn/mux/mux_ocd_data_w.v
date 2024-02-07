
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb  7 12:35:08 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_ocd_data_w : mux_ocd_data_w
module mux_ocd_data_w
  ( input                   __ocd_ld_DMbS3_r_in, // bool
    input      signed [7:0] dmb_rd_dp_in, // w08
    output reg signed [7:0] ocd_data_w_out // w08
  );


  always @ (*)

  begin : p_mux_ocd_data_w

    ocd_data_w_out = 8'sh0;

    // (ocd_data_w_copy0_dmb_rd___ocd_ld_DMbS3_r_S3_alw)
    if (__ocd_ld_DMbS3_r_in)
    begin
      // [ocd.n:73]
      ocd_data_w_out = dmb_rd_dp_in;
    end

  end

endmodule
