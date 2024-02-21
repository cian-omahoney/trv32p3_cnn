
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 18:04:14 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn




// File generated by pdg version U-2022.12#33f3808fcb#221128
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// pdg -I../lib -D__go__ -Verilog -cgo_options.cfg -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 +wtrv32p3_cnn_vlog/tmp_pdg trv32p3_cnn


task w32_add_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_add_w32_w32_task
    result = a + b;
  end
endtask

task w32_sub_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_sub_w32_w32_task
    result = a - b;
  end
endtask

task w32_slt_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_slt_w32_w32_task
    result = $signed({{31{1'b0}}, a < b});
  end
endtask

task w32_sltu_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_sltu_w32_w32_task
    result = $signed({{31{1'b0}}, $unsigned(a) < $unsigned(b)});
  end
endtask

task w32_seq0_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a
  );
  begin : w32_seq0_w32_task
    result = $signed({{31{1'b0}}, a == 32'sh0});
  end
endtask

task w32_sne0_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a
  );
  begin : w32_sne0_w32_task
    result = $signed({{31{1'b0}}, a != 32'sh0});
  end
endtask

task w32_mul_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_mul_w32_w32_task
    reg signed [63:0] rtrn;
    rtrn = a * b;
    result = $signed(rtrn[31:0]);
  end
endtask

task w32_mulh_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_mulh_w32_w32_task
    reg signed [63:0] p;
    p = a * b;
    result = $signed(p[63 : 32]);
  end
endtask

task w32_mulhsu_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_mulhsu_w32_w32_task
    reg signed [63:0] p;
    p = a * $signed({1'b0, $unsigned(b)});
    result = $signed(p[63 : 32]);
  end
endtask

task w32_mulhu_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_mulhu_w32_w32_task
    reg        [63:0] p;
    reg signed [63:0] p_0;
    p = $unsigned(a) * $unsigned(b);
    p_0 = $signed(p);
    result = $signed(p_0[63 : 32]);
  end
endtask

task w32_band_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_band_w32_w32_task
    result = a & b;
  end
endtask

task w32_bor_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_bor_w32_w32_task
    result = a | b;
  end
endtask

task w32_bxor_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_bxor_w32_w32_task
    result = a ^ b;
  end
endtask

task bool_eq_w32_w32
  ( output reg               result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : bool_eq_w32_w32_task
    result = a == b;
  end
endtask

task bool_ne_w32_w32
  ( output reg               result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : bool_ne_w32_w32_task
    result = a != b;
  end
endtask

task bool_lt_w32_w32
  ( output reg               result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : bool_lt_w32_w32_task
    result = a < b;
  end
endtask

task bool_ge_w32_w32
  ( output reg               result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : bool_ge_w32_w32_task
    result = a >= b;
  end
endtask

task bool_ltu_w32_w32
  ( output reg               result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : bool_ltu_w32_w32_task
    result = $unsigned(a) < $unsigned(b);
  end
endtask

task bool_geu_w32_w32
  ( output reg               result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : bool_geu_w32_w32_task
    result = $unsigned(a) >= $unsigned(b);
  end
endtask

task w32_sra_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_sra_w32_w32_task
    result = (a >>> $unsigned($signed(b[4 : 0])));
  end
endtask

task w32_sll_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_sll_w32_w32_task
    reg        [31:0] rtrn;
    rtrn = $unsigned(a) << $unsigned($signed(b[4 : 0]));
    result = $signed(rtrn);
  end
endtask

task w32_srl_w32_w32
  ( output reg signed [31:0] result,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_srl_w32_w32_task
    reg        [31:0] rtrn;
    rtrn = ($unsigned(a) >> $unsigned($signed(b[4 : 0])));
    result = $signed(rtrn);
  end
endtask

task w32_sext_w08
  ( output reg signed [31:0] result,
    input      signed  [7:0] a
  );
  begin : w32_sext_w08_task
    result = $signed({{24{a[7]}}, a});
  end
endtask

task w32_zext_w08
  ( output reg signed [31:0] result,
    input      signed  [7:0] a
  );
  begin : w32_zext_w08_task
    result = $signed({{24{1'b0}}, $unsigned(a)});
  end
endtask

task w32_sext_w16
  ( output reg signed [31:0] result,
    input      signed [15:0] a
  );
  begin : w32_sext_w16_task
    result = $signed({{16{a[15]}}, a});
  end
endtask

task w32_zext_w16
  ( output reg signed [31:0] result,
    input      signed [15:0] a
  );
  begin : w32_zext_w16_task
    result = $signed({{16{1'b0}}, $unsigned(a)});
  end
endtask

task void_nop
  ( );
  begin : void_nop_task
  end
endtask

task addr_incr1_addr
  ( output reg        [31:0] result,
    input             [31:0] a
  );
  begin : addr_incr1_addr_task
    result = a + 32'h1;
  end
endtask

task addr_incr4_addr
  ( output reg        [31:0] result,
    input             [31:0] a
  );
  begin : addr_incr4_addr_task
    result = a + 32'h4;
  end
endtask

task void_mul_hw_w32_w32_t2u_w32_w32
  ( input      signed [31:0] opa,
    input      signed [31:0] opb,
    input              [1:0] mode,
    output reg signed [31:0] pl,
    output reg signed [31:0] ph
  );
  begin : void_mul_hw_w32_w32_t2u_w32_w32_task
    reg signed [32:0] a;
    reg signed [32:0] b;
    reg signed [65:0] r;
    a = $signed({mode[1] & opa[31] , $unsigned(opa)});
    b = $signed({mode[0] & opb[31] , $unsigned(opb)});
    r = a * b;
    pl = $signed(r[31 : 0]);
    ph = $signed(r[63 : 32]);
  end
endtask

task w32_mac_w32_w32_w32
  ( output reg signed [31:0] result_0,
    input      signed [31:0] c,
    input      signed [31:0] a,
    input      signed [31:0] b
  );
  begin : w32_mac_w32_w32_w32_task
    reg signed [31:0] multResult;
    reg signed [31:0] result;
    reg signed [63:0] multResult_0;
    reg signed [31:0] INT32_SATURATION_result;
    reg signed [31:0] saturatedResult;
    reg signed [31:0] INT32_SATURATION_result_0;
    reg signed [31:0] fullResult;
    reg signed [63:0] fullResult_0;
    reg signed [31:0] saturatedResult_0;
    multResult_0 = a * b;
    if (multResult_0 > 64'sh7FFFFFFF)
    begin
      saturatedResult = 32'sh7FFFFFFF;
    end
    else
    begin
      if (multResult_0 < -64'sh80000000)
      begin
        saturatedResult = -32'sh80000000;
      end
      else
      begin
        saturatedResult = $signed(multResult_0[31 : 0]);
      end
    end
    INT32_SATURATION_result = saturatedResult;
    multResult = INT32_SATURATION_result;
    fullResult = c + multResult;
    fullResult_0 = $signed({{32{fullResult[31]}}, fullResult});
    if (fullResult_0 > 64'sh7FFFFFFF)
    begin
      saturatedResult_0 = 32'sh7FFFFFFF;
    end
    else
    begin
      if (fullResult_0 < -64'sh80000000)
      begin
        saturatedResult_0 = -32'sh80000000;
      end
      else
      begin
        saturatedResult_0 = $signed(fullResult_0[31 : 0]);
      end
    end
    INT32_SATURATION_result_0 = saturatedResult_0;
    result = INT32_SATURATION_result_0;
    result_0 = result;
  end
endtask

