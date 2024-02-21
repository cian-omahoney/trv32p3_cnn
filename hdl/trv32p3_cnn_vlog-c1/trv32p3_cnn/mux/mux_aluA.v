
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:23 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-c1 -cgo_options-c1.cfg -Itrv32p3_cnn_vlog-c1/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux_aluA : mux_aluA
module mux_aluA
  ( input                    bin_selector_EX,
    input             [31:0] PC_EX_r_in, // addr
    input      signed [31:0] x_r1_in, // w32
    output reg signed [31:0] aluA_out // w32
  );


  // synopsys dc_tcl_script_begin
  // set_ungroup [current_design]
  // synopsys dc_tcl_script_end
  always @ (*)

  begin : p_mux_aluA

    aluA_out = 32'sh0;

    case (bin_selector_EX)
      1'b0 : // (aluA_copy0_PC_EX_r_EX)
      begin
        // [alu.n:210]
        aluA_out = $signed(PC_EX_r_in);
      end
      default : // (aluA_copy0_x_r1_EX)
      begin
        // [alu.n:69][alu.n:131][alu.n:167](regX.n:75)
        aluA_out = x_r1_in;
      end
    endcase

  end

endmodule
