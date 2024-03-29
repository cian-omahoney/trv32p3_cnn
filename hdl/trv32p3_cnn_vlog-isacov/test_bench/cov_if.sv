
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:21 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-isacov -cgo_options-isacov.cfg -Itrv32p3_cnn_vlog-isacov/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

typedef logic [31:0] instr_t;

// Covergroup
`define CG_ISA                   CG_isa with function sample(instr_t valid_instr)
`define VALID_INSTR_ENCODING     valid_instr
`define COVERGROUP_EXTN
`include "trv32p3_cnn_cg_isa.svh"

interface trv32p3_cnn_cov_if (
                              input bit clk,
                              input logic [31:0] instr,
                              input bit instr_valid);

  CG_isa cg = new();

  initial begin
    forever begin
      @(posedge clk)
      if (instr_valid) begin
        cg.sample(instr);
      end
    end
  end

endinterface : trv32p3_cnn_cov_if
