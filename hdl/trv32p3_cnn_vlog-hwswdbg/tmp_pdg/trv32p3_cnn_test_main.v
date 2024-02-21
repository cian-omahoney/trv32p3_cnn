
// File generated by pdg version U-2022.12#33f3808fcb#221128
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// pdg -I../lib -D__go__ -Verilog -cgo_options-hwswdbg.cfg -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 +wtrv32p3_cnn_vlog-hwswdbg/tmp_pdg trv32p3_cnn


module test_driver;
  integer file, out_file, r;
  reg [2500*8:1] line, command;

`include "trv32p3_cnn_primitives.v"

  task test_w32_add_w32_w32;
    begin : test_w32_add_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_add_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_add_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_add_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_sub_w32_w32;
    begin : test_w32_sub_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_sub_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_sub_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_sub_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_slt_w32_w32;
    begin : test_w32_slt_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_slt_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_slt_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_slt_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_sltu_w32_w32;
    begin : test_w32_sltu_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_sltu_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_sltu_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_sltu_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_seq0_w32;
    begin : test_w32_seq0_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      r = $sscanf(line, "%s %h %h ", command, a, __pdg__return_sig_expected);
      w32_seq0_w32(__pdg__return_sig_found, a);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h , expected %h, found %h", "w32_seq0_w32", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h // expected %h, found %h", "w32_seq0_w32", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_sne0_w32;
    begin : test_w32_sne0_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      r = $sscanf(line, "%s %h %h ", command, a, __pdg__return_sig_expected);
      w32_sne0_w32(__pdg__return_sig_found, a);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h , expected %h, found %h", "w32_sne0_w32", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h // expected %h, found %h", "w32_sne0_w32", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_mul_w32_w32;
    begin : test_w32_mul_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_mul_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_mul_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_mul_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_mulh_w32_w32;
    begin : test_w32_mulh_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_mulh_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_mulh_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_mulh_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_mulhsu_w32_w32;
    begin : test_w32_mulhsu_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_mulhsu_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_mulhsu_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_mulhsu_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_mulhu_w32_w32;
    begin : test_w32_mulhu_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_mulhu_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_mulhu_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_mulhu_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_band_w32_w32;
    begin : test_w32_band_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_band_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_band_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_band_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_bor_w32_w32;
    begin : test_w32_bor_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_bor_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_bor_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_bor_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_bxor_w32_w32;
    begin : test_w32_bxor_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_bxor_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_bxor_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_bxor_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_bool_eq_w32_w32;
    begin : test_bool_eq_w32_w32_task
      reg               __pdg__return_sig_expected;
      reg               __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      bool_eq_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "bool_eq_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "bool_eq_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_bool_ne_w32_w32;
    begin : test_bool_ne_w32_w32_task
      reg               __pdg__return_sig_expected;
      reg               __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      bool_ne_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "bool_ne_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "bool_ne_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_bool_lt_w32_w32;
    begin : test_bool_lt_w32_w32_task
      reg               __pdg__return_sig_expected;
      reg               __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      bool_lt_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "bool_lt_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "bool_lt_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_bool_ge_w32_w32;
    begin : test_bool_ge_w32_w32_task
      reg               __pdg__return_sig_expected;
      reg               __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      bool_ge_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "bool_ge_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "bool_ge_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_bool_ltu_w32_w32;
    begin : test_bool_ltu_w32_w32_task
      reg               __pdg__return_sig_expected;
      reg               __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      bool_ltu_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "bool_ltu_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "bool_ltu_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_bool_geu_w32_w32;
    begin : test_bool_geu_w32_w32_task
      reg               __pdg__return_sig_expected;
      reg               __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      bool_geu_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "bool_geu_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "bool_geu_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_sra_w32_w32;
    begin : test_w32_sra_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_sra_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_sra_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_sra_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_sll_w32_w32;
    begin : test_w32_sll_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_sll_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_sll_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_sll_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_srl_w32_w32;
    begin : test_w32_srl_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h ", command, a, b, __pdg__return_sig_expected);
      w32_srl_w32_w32(__pdg__return_sig_found, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h , expected %h, found %h", "w32_srl_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h // expected %h, found %h", "w32_srl_w32_w32", a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_sext_w08;
    begin : test_w32_sext_w08_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed  [7:0] a;
      r = $sscanf(line, "%s %h %h ", command, a, __pdg__return_sig_expected);
      w32_sext_w08(__pdg__return_sig_found, a);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h , expected %h, found %h", "w32_sext_w08", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h // expected %h, found %h", "w32_sext_w08", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_zext_w08;
    begin : test_w32_zext_w08_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed  [7:0] a;
      r = $sscanf(line, "%s %h %h ", command, a, __pdg__return_sig_expected);
      w32_zext_w08(__pdg__return_sig_found, a);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h , expected %h, found %h", "w32_zext_w08", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h // expected %h, found %h", "w32_zext_w08", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_sext_w16;
    begin : test_w32_sext_w16_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [15:0] a;
      r = $sscanf(line, "%s %h %h ", command, a, __pdg__return_sig_expected);
      w32_sext_w16(__pdg__return_sig_found, a);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h , expected %h, found %h", "w32_sext_w16", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h // expected %h, found %h", "w32_sext_w16", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_w32_zext_w16;
    begin : test_w32_zext_w16_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [15:0] a;
      r = $sscanf(line, "%s %h %h ", command, a, __pdg__return_sig_expected);
      w32_zext_w16(__pdg__return_sig_found, a);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h , expected %h, found %h", "w32_zext_w16", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h // expected %h, found %h", "w32_zext_w16", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_void_nop;
    begin : test_void_nop_task
      r = $sscanf(line, "%s ", command);
      void_nop();
    end
  endtask

  task test_addr_incr1_addr;
    begin : test_addr_incr1_addr_task
      reg        [31:0] __pdg__return_sig_expected;
      reg        [31:0] __pdg__return_sig_found;
      reg        [31:0] a;
      r = $sscanf(line, "%s %h %h ", command, a, __pdg__return_sig_expected);
      addr_incr1_addr(__pdg__return_sig_found, a);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h , expected %h, found %h", "addr_incr1_addr", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h // expected %h, found %h", "addr_incr1_addr", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_addr_incr4_addr;
    begin : test_addr_incr4_addr_task
      reg        [31:0] __pdg__return_sig_expected;
      reg        [31:0] __pdg__return_sig_found;
      reg        [31:0] a;
      r = $sscanf(line, "%s %h %h ", command, a, __pdg__return_sig_expected);
      addr_incr4_addr(__pdg__return_sig_found, a);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h , expected %h, found %h", "addr_incr4_addr", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h // expected %h, found %h", "addr_incr4_addr", a, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  task test_void_mul_hw_w32_w32_t2u_w32_w32;
    begin : test_void_mul_hw_w32_w32_t2u_w32_w32_task
      reg signed [31:0] opa;
      reg signed [31:0] opb;
      reg         [1:0] mode;
      reg signed [31:0] pl_expected;
      reg signed [31:0] pl_found;
      reg signed [31:0] ph_expected;
      reg signed [31:0] ph_found;
      r = $sscanf(line, "%s %h %h %h %h %h ", command, opa, opb, mode, pl_expected, ph_expected);
      void_mul_hw_w32_w32_t2u_w32_w32(opa, opb, mode, pl_found, ph_found);
      if (pl_expected !== pl_found)
      begin
        $display("FAILURE: %s %h %h %h %h %h , expected %h, found %h", "void_mul_hw_w32_w32_t2u_w32_w32", opa, opb, mode, pl_expected, ph_expected, pl_expected, pl_found);
        $fdisplay(out_file, "%s %h %h %h %h %h // expected %h, found %h", "void_mul_hw_w32_w32_t2u_w32_w32", opa, opb, mode, pl_expected, ph_expected, pl_expected, pl_found);
      end
      if (ph_expected !== ph_found)
      begin
        $display("FAILURE: %s %h %h %h %h %h , expected %h, found %h", "void_mul_hw_w32_w32_t2u_w32_w32", opa, opb, mode, pl_expected, ph_expected, ph_expected, ph_found);
        $fdisplay(out_file, "%s %h %h %h %h %h // expected %h, found %h", "void_mul_hw_w32_w32_t2u_w32_w32", opa, opb, mode, pl_expected, ph_expected, ph_expected, ph_found);
      end
    end
  endtask

  task test_w32_mac_w32_w32_w32;
    begin : test_w32_mac_w32_w32_w32_task
      reg signed [31:0] __pdg__return_sig_expected;
      reg signed [31:0] __pdg__return_sig_found;
      reg signed [31:0] c;
      reg signed [31:0] a;
      reg signed [31:0] b;
      r = $sscanf(line, "%s %h %h %h %h ", command, c, a, b, __pdg__return_sig_expected);
      w32_mac_w32_w32_w32(__pdg__return_sig_found, c, a, b);
      if (__pdg__return_sig_expected !== __pdg__return_sig_found)
      begin
        $display("FAILURE: %s %h %h %h %h , expected %h, found %h", "w32_mac_w32_w32_w32", c, a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
        $fdisplay(out_file, "%s %h %h %h %h // expected %h, found %h", "w32_mac_w32_w32_w32", c, a, b, __pdg__return_sig_expected, __pdg__return_sig_expected, __pdg__return_sig_found);
      end
    end
  endtask

  initial
  begin : file_block
    file = $fopen("trv32p3_cnn_testcases.txt", "r");
    out_file = $fopen("trv32p3_cnn_verilog_failures.txt", "w");
    while (!$feof(file))
    begin
      r = $fgets(line, file);
      r = $sscanf(line, " %s ", command);
      case (command)
        "w32_add_w32_w32":
          test_w32_add_w32_w32();
        "w32_sub_w32_w32":
          test_w32_sub_w32_w32();
        "w32_slt_w32_w32":
          test_w32_slt_w32_w32();
        "w32_sltu_w32_w32":
          test_w32_sltu_w32_w32();
        "w32_seq0_w32":
          test_w32_seq0_w32();
        "w32_sne0_w32":
          test_w32_sne0_w32();
        "w32_mul_w32_w32":
          test_w32_mul_w32_w32();
        "w32_mulh_w32_w32":
          test_w32_mulh_w32_w32();
        "w32_mulhsu_w32_w32":
          test_w32_mulhsu_w32_w32();
        "w32_mulhu_w32_w32":
          test_w32_mulhu_w32_w32();
        "w32_band_w32_w32":
          test_w32_band_w32_w32();
        "w32_bor_w32_w32":
          test_w32_bor_w32_w32();
        "w32_bxor_w32_w32":
          test_w32_bxor_w32_w32();
        "bool_eq_w32_w32":
          test_bool_eq_w32_w32();
        "bool_ne_w32_w32":
          test_bool_ne_w32_w32();
        "bool_lt_w32_w32":
          test_bool_lt_w32_w32();
        "bool_ge_w32_w32":
          test_bool_ge_w32_w32();
        "bool_ltu_w32_w32":
          test_bool_ltu_w32_w32();
        "bool_geu_w32_w32":
          test_bool_geu_w32_w32();
        "w32_sra_w32_w32":
          test_w32_sra_w32_w32();
        "w32_sll_w32_w32":
          test_w32_sll_w32_w32();
        "w32_srl_w32_w32":
          test_w32_srl_w32_w32();
        "w32_sext_w08":
          test_w32_sext_w08();
        "w32_zext_w08":
          test_w32_zext_w08();
        "w32_sext_w16":
          test_w32_sext_w16();
        "w32_zext_w16":
          test_w32_zext_w16();
        "void_nop":
          test_void_nop();
        "addr_incr1_addr":
          test_addr_incr1_addr();
        "addr_incr4_addr":
          test_addr_incr4_addr();
        "void_mul_hw_w32_w32_t2u_w32_w32":
          test_void_mul_hw_w32_w32_t2u_w32_w32();
        "w32_mac_w32_w32_w32":
          test_w32_mac_w32_w32_w32();
      endcase
    end
    $fclose(file);
    $fclose(out_file);
  end
endmodule
