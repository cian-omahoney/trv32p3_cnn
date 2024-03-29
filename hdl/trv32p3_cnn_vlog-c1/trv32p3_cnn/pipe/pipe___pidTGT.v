
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:23 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-c1 -cgo_options-c1.cfg -Itrv32p3_cnn_vlog-c1/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module pipe___pidTGT : pipe___pidTGT
module pipe___pidTGT
  ( input                clock,
    input                ohe_selector_ID,
    input  signed [31:0] __pidTGT_w_in, // w32
    output signed [31:0] __pidTGT_r_out // w32
  );


  reg signed [31:0] pipe_val___pidTGT_r_out;
  reg signed [31:0] pipe_val___pidTGT_r_out_next;
  reg pipe_we___pidTGT_r_out;

  assign __pidTGT_r_out = pipe_val___pidTGT_r_out;


  always @ (*)
  begin : p_pipe___pidTGT
    pipe_val___pidTGT_r_out_next = 0;
    pipe_we___pidTGT_r_out = 1'h0;

    if (ohe_selector_ID) // (_pipe_pidTGT_ID)
    begin
      // [ctrl.n:114][ctrl.n:155][ctrl.n:194]
      pipe_we___pidTGT_r_out = 1'b1;
      pipe_val___pidTGT_r_out_next = __pidTGT_w_in;
    end

  end

  always @ (posedge clock)
  begin : clck_p_pipe___pidTGT
    if (pipe_we___pidTGT_r_out)
    begin
      pipe_val___pidTGT_r_out <= pipe_val___pidTGT_r_out_next;
    end
  end
endmodule
