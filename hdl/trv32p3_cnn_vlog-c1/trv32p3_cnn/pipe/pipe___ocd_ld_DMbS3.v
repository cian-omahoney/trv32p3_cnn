
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:43 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-c1 -cgo_options-c1.cfg -Itrv32p3_cnn_vlog-c1/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module pipe___ocd_ld_DMbS3 : pipe___ocd_ld_DMbS3
module pipe___ocd_ld_DMbS3
  ( input  clock,
    input  __ocd_ld_DMbEX_w_in, // bool
    output __ocd_ld_DMbS3_r_out // bool
  );


  reg pipe_val___ocd_ld_DMbS3_r_out;
  reg pipe_val___ocd_ld_DMbS3_r_out_next;
  reg pipe_we___ocd_ld_DMbS3_r_out;

  assign __ocd_ld_DMbS3_r_out = pipe_val___ocd_ld_DMbS3_r_out;


  always @ (*)
  begin : p_pipe___ocd_ld_DMbS3
    pipe_val___ocd_ld_DMbS3_r_out_next = 0;
    pipe_we___ocd_ld_DMbS3_r_out = 1'h0;

    // (_pipe__ocd_ld_DMbEX_S3)
    pipe_we___ocd_ld_DMbS3_r_out = 1'b1;
    pipe_val___ocd_ld_DMbS3_r_out_next = __ocd_ld_DMbEX_w_in;

  end

  always @ (posedge clock)
  begin : clck_p_pipe___ocd_ld_DMbS3
    if (pipe_we___ocd_ld_DMbS3_r_out)
    begin
      pipe_val___ocd_ld_DMbS3_r_out <= pipe_val___ocd_ld_DMbS3_r_out_next;
    end
  end
endmodule
