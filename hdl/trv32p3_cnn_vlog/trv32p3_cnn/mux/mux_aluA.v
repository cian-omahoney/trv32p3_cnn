
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:36:54 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_aluA : mux_aluA
module mux_aluA
  ( input                    ohe_selector_EX,
    input             [31:0] PC_EX_r_in, // addr
    input      signed [31:0] x_r1_in, // w32
    output reg signed [31:0] aluA_out // w32
  );


  always @ (*)

  begin : p_mux_aluA

    // aluA_out = 32'sh0;

    // (aluA_copy0_PC_EX_r_EX)
    // [alu.n:210]
    aluA_out = $signed(PC_EX_r_in);

    if (ohe_selector_EX) // (aluA_copy0_x_r1_EX)
    begin
      // [alu.n:69][alu.n:131][alu.n:167](regX.n:75)
      aluA_out = x_r1_in;
    end

  end

endmodule
