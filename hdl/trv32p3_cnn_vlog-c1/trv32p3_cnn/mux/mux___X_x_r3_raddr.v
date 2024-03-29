
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:23 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-c1 -cgo_options-c1.cfg -Itrv32p3_cnn_vlog-c1/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module mux___X_x_r3_raddr : mux___X_x_r3_raddr
module mux___X_x_r3_raddr
  ( input            ohe_selector_EX,
    input            ohe_selector_ID,
    input      [4:0] __CTt5u_cstP15_ID_in, // t5u
    input      [4:0] __CTt5u_cstP7_EX_in, // t5u
    output reg [4:0] __X_x_r3_rad_out // t5u
  );


  // synopsys dc_tcl_script_begin
  // set_ungroup [current_design]
  // synopsys dc_tcl_script_end
  always @ (*)

  begin : p_mux___X_x_r3_raddr

    __X_x_r3_rad_out = 5'h0;

    if (ohe_selector_EX) // (__X_x_r3_raddr_cp___CTt5u_cstP7_EX_EX)
    begin
      // [cnn.n:28](regX.n:107)
      __X_x_r3_rad_out = __CTt5u_cstP7_EX_in;
    end

    if (ohe_selector_ID) // (__X_x_r3_raddr_cp___CTt5u_cstP15_ID_ID)
    begin
      // [ldst.n:54][ldst.n:91][ctrl.n:189](regX.n:89)
      __X_x_r3_rad_out = __CTt5u_cstP15_ID_in;
    end

  end

endmodule
