
<<<<<<< HEAD
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:28 2024
=======
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb  7 12:35:08 2024
>>>>>>> 4598ee6aea7e54d7c8d2ee3c7f6dc45be2dcb746
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_ocd_instr_w : mux_ocd_instr_w
module mux_ocd_instr_w
  ( input             __ocd_ld_PMbS3_r_in, // bool
    input      [31:0] pm_rd_dp_in, // iword
    output reg [31:0] ocd_instr_w_out // iword
  );


  always @ (*)

  begin : p_mux_ocd_instr_w

    ocd_instr_w_out = 32'h0;

    // (ocd_instr_w_copy0_pm_rd___ocd_ld_PMbS3_r_S3_alw)
    if (__ocd_ld_PMbS3_r_in)
    begin
      // [ocd.n:89]
      ocd_instr_w_out = pm_rd_dp_in;
    end

  end

endmodule
