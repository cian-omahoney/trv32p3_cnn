
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:40 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-isacov -cgo_options-isacov.cfg -Itrv32p3_cnn_vlog-isacov/tmp_pdg -updg -updg_controller trv32p3_cnn



  // Look through your hierarchy to find the core instance
  // You may need to traverse a few levels before hitting the core instance
  `define CORE_BASE                    test_bench.inst_trv32p3_cnn

  // Within the core, bind a coverage interface to the decoder 
  bind `CORE_BASE.inst_decoder trv32p3_cnn_cov_if cov_vif(
      .clk(`CORE_BASE.inst_decoder.clock),
      .instr(`CORE_BASE.inst_decoder.reg_IR_ID),
      .instr_valid(`CORE_BASE.inst_decoder.reg_ID_valid)
  );