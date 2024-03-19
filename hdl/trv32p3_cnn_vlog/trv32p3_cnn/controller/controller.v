
// File generated by Go version U-2022.12#33f3808fcb#221128, Sat Mar 16 14:40:42 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module controller : controller
module controller
  ( input                    reset,
    input                    clock,
    input                    ohe_selector_EX,
    input              [1:0] bin_selector_ID,
    input                    cnd_in, // bool
    input                    hzd_stall_in,
    input                    issue_sig_in,
    input      signed [31:0] jmp_tgt_EX_in, // w32
    input      signed [31:0] jmp_tgt_ID_in, // w32
    input                    ocd_exe_in, // t1u
    input             [31:0] ocd_instr_r_in, // iword
    input                    ocd_req_in, // t1u
    input             [31:0] pcr_in, // addr
    input             [31:0] pm_rd_in, // iword
    output reg               PC_ID_PC_ID_w_cntrl_issue_pdg_en_out, // std_logic
    output reg        [31:0] PC_ID_w_out, // addr
    output reg               PC_pcw_cntrl_nxtpc_pdg_en_out, // std_logic
    output reg               kill_ID_out,
    output reg signed [31:0] lnk_id_out, // w32
    output reg               ocd_mode_out, // t1u
    output reg        [31:0] pcw_out, // addr
    output reg        [31:0] pm_addr_out, // addr
    output reg               pm_ld_pdg_en_out, // std_logic
    output reg               trn_ID_valid_out,
    output reg        [31:0] trn_IR_ID_out
  );


  wire en_vd_br_cnd_of13_cd_EX;
  wire en_lnk_id_jal_of21_ID;
  wire en_lnk_id_jalr_trgt_ID;

  wire en_jump_of13_cd_sig;
  wire en_jump_of21_sig;
  wire en_jump_trgt_sig;

  assign en_vd_br_cnd_of13_cd_EX = ohe_selector_EX;
  assign en_lnk_id_jal_of21_ID = bin_selector_ID == 2'b01;
  assign en_lnk_id_jalr_trgt_ID = bin_selector_ID == 2'b10;

  assign en_jump_of13_cd_sig = (en_vd_br_cnd_of13_cd_EX && cnd_in);
  assign en_jump_of21_sig = en_lnk_id_jal_of21_ID;
  assign en_jump_trgt_sig = en_lnk_id_jalr_trgt_ID;


  // File generated by pdg version U-2022.12#33f3808fcb#221128
  // Copyright 2014-2022 Synopsys, Inc. All rights reserved.
  // pdg -I../lib -D__go__ -pcu -Verilog -cgo_options.cfg -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 +wtrv32p3_cnn_vlog/tmp_pdg trv32p3_cnn


  // Storages local to the pcu
  reg               r_booting;
  reg               pdg_update_r_booting;
  reg               pdg_we_r_booting;
  reg               r_fetched;
  reg               pdg_update_r_fetched;
  reg               pdg_we_r_fetched;
  reg         [3:0] r_state;
  reg         [3:0] pdg_update_r_state;
  reg               pdg_we_r_state;
  reg               t_stop_issue;

  // user_issue
  always @ (*)
  begin : p_user_issue
    reg        [31:0] PC_IF_l;
    reg               br_EX;
    reg               flush_IF;
    reg               flush_ID;
    reg               could_issue;
    reg        [31:0] ii;
    reg               instr_avail;
    reg               interruptible;
    reg               ocd_req_int;
    reg               stop_issue;
    reg        [31:0] ii_0;
    reg         [7:0] tmp;
    reg         [7:0] tmp_0;
    reg         [7:0] tmp_1;
    reg         [7:0] tmp_2;
    reg               issue_ins;
    reg         [7:0] tmp_3;
    reg         [7:0] tmp_4;
    reg         [7:0] tmp_5;
    reg         [7:0] tmp_6;

    trn_ID_valid_out = 0;
    trn_IR_ID_out = 0;
    kill_ID_out = 1'b0;
    PC_ID_PC_ID_w_cntrl_issue_pdg_en_out = 1'b0;
    PC_ID_w_out = 32'h0;
    lnk_id_out = 32'sh0;
    ocd_mode_out = 1'b0;
    t_stop_issue = 1'b0;

    ii_0 = 32'h0;
    tmp = 8'h0;
    tmp_0 = 8'h0;
    tmp_1 = 8'h0;
    tmp_2 = 8'h0;
    tmp_3 = 8'h0;
    tmp_4 = 8'h0;
    tmp_5 = 8'h0;
    tmp_6 = 8'h0;

    pdg_we_r_booting = 1'b0;
    pdg_update_r_booting = 1'b0;
    pdg_we_r_state = 1'b0;
    pdg_update_r_state = 4'h0;

    PC_IF_l = pcr_in;
    lnk_id_out = $signed(PC_IF_l);
    br_EX = en_jump_of13_cd_sig;
    flush_IF = br_EX;
    flush_ID = br_EX;
    if (flush_ID)
    begin
      kill_ID_out = 1;
    end
    could_issue = issue_sig_in && !(hzd_stall_in && !flush_ID);
    ii = pm_rd_in;
    instr_avail = r_fetched;
    interruptible = could_issue;
    ocd_req_int = ocd_req_in && interruptible;
    if (r_state == 4'h0)
    begin
      if (ocd_req_int)
      begin
        pdg_we_r_state = 1'b1;
        pdg_update_r_state = 4'hF;
      end
    end
    else
    begin
      if (r_state == 4'hF)
      begin
        if (!ocd_req_in)
        begin
          pdg_we_r_state = 1'b1;
          pdg_update_r_state = 4'hE;
        end
      end
      else
      begin
        if (r_state == 4'hE)
        begin
          pdg_we_r_state = 1'b1;
          pdg_update_r_state = 4'hC;
        end
        else
        begin
          if (r_state == 4'hC)
          begin
            if (instr_avail)
            begin
              pdg_we_r_state = 1'b1;
              pdg_update_r_state = 4'h8;
            end
          end
          else
          begin
            if (r_state == 4'h8)
            begin
              pdg_we_r_state = 1'b1;
              pdg_update_r_state = 4'h0;
            end
          end
        end
      end
    end
    stop_issue = r_state == 4'h0 && ocd_req_int || r_state == 4'hF || r_state == 4'hE || r_state == 4'hC;
    ocd_mode_out = r_state == 4'hF || r_state == 4'hE || r_state == 4'hC;
    if (ocd_exe_in)
    begin
      ii_0 = ocd_instr_r_in;
      tmp = ii_0[0+:8];
      tmp_0 = ii_0[8+:8];
      tmp_1 = ii_0[16+:8];
      tmp_2 = ii_0[24+:8];
      trn_ID_valid_out = 1;
      trn_IR_ID_out = {tmp_2, tmp_1, tmp_0, tmp};
    end
    issue_ins = instr_avail && !flush_IF && could_issue && !stop_issue;
    if (issue_ins)
    begin
      tmp_3 = ii[0+:8];
      tmp_4 = ii[8+:8];
      tmp_5 = ii[16+:8];
      tmp_6 = ii[24+:8];
      trn_ID_valid_out = 1;
      trn_IR_ID_out = {tmp_6, tmp_5, tmp_4, tmp_3};
      PC_ID_PC_ID_w_cntrl_issue_pdg_en_out = 1'b1;
      PC_ID_w_out = PC_IF_l;
    end
    else
    begin
    end
    if (r_booting)
    begin
      pdg_we_r_booting = 1'b1;
      pdg_update_r_booting = 1'b0;
    end
    t_stop_issue = stop_issue;
  end //p_user_issue


  // user_next_pc
  always @ (*)
  begin : p_user_next_pc
    reg        [31:0] PC_IF_l;
    reg               br_EX;
    reg               jalr_ID;
    reg               jal_ID;
    reg        [31:0] incr_pc;
    reg               leave_dbg;
    reg        [31:0] jump_pc;
    reg               jump;
    reg        [31:0] t;
    reg        [31:0] next_pc;
    reg               could_issue;
    reg               could_jump;
    reg               instr_avail;
    reg               update_pc;
    reg               ocd_issue_stall;
    reg               fetch_next;
    reg        [31:0] t_0;
    reg        [31:0] fetch_pc;
    reg               fetch;

    PC_pcw_cntrl_nxtpc_pdg_en_out = 1'b0;
    pcw_out = 32'h0;
    pm_addr_out = 32'h0;
    pm_ld_pdg_en_out = 1'b0;

    pdg_we_r_fetched = 1'b0;
    pdg_update_r_fetched = 1'b0;

    PC_IF_l = pcr_in;
    br_EX = en_jump_of13_cd_sig;
    jalr_ID = en_jump_trgt_sig;
    jal_ID = en_jump_of21_sig;
    // synopsys translate_off
    if (!clock && !(reset))
    begin
      assert({{7{1'b0}}, br_EX} + {{7{1'b0}}, jal_ID && !br_EX} + {{7{1'b0}}, jalr_ID && !br_EX} <= 8'h1) else
        $fatal(1, "time %0d PDG_ASSERT (trv32p3_cnn_pcu.p:L180:C2) : Assertion triggered!", $time);
    end
    // synopsys translate_on
    incr_pc = PC_IF_l + 32'h4;
    leave_dbg = r_state == 4'hE;
    jump_pc = PC_IF_l;
    if (leave_dbg)
    begin
      jump_pc = PC_IF_l;
    end
    else
    begin
      if (br_EX)
      begin
        jump_pc = $unsigned(jmp_tgt_EX_in);
      end
      else
      begin
        if (jalr_ID)
        begin
          jump_pc = $unsigned(jmp_tgt_ID_in);
        end
        else
        begin
          if (jal_ID)
          begin
            jump_pc = $unsigned(jmp_tgt_ID_in);
          end
        end
      end
    end
    jump = br_EX || jal_ID || jalr_ID;
    if (jump)
    begin
      t = jump_pc;
    end
    else
    begin
      t = incr_pc;
    end
    next_pc = t;
    could_issue = issue_sig_in && !hzd_stall_in;
    could_jump = br_EX || jalr_ID && !hzd_stall_in || jal_ID && !hzd_stall_in;
    instr_avail = r_fetched;
    update_pc = could_issue && instr_avail && !t_stop_issue || could_jump;
    if (update_pc)
    begin
      PC_pcw_cntrl_nxtpc_pdg_en_out = 1'b1;
      pcw_out = next_pc;
    end
    ocd_issue_stall = r_state == 4'hC;
    fetch_next = could_issue && instr_avail && !ocd_issue_stall || could_jump;
    if (fetch_next)
    begin
      t_0 = next_pc;
    end
    else
    begin
      t_0 = PC_IF_l;
    end
    fetch_pc = t_0;
    fetch = r_state != 4'hF;
    pdg_we_r_fetched = 1'b1;
    pdg_update_r_fetched = fetch;
    pm_addr_out = fetch_pc;
    if (fetch)
    begin
      pm_ld_pdg_en_out = 1'b1;
    end
  end //p_user_next_pc


  always @ (posedge clock or posedge reset)
  begin : p_update_status
    if (reset)
    begin
      r_booting <= 1'b1;
      r_fetched <= 1'b0;
      r_state <= 4'h0;
    end
    else
    begin
      if (pdg_we_r_booting)
        r_booting <= pdg_update_r_booting;
      if (pdg_we_r_fetched)
        r_fetched <= pdg_update_r_fetched;
      if (pdg_we_r_state)
        r_state <= pdg_update_r_state;
    end
  end // p_update_status
endmodule
