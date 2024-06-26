
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Apr 10 20:00:35 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module debug_controller : debug_controller
module debug_controller
  #(parameter nid = 1)
  ( input                   reset_ext,
    input                   clock,
    input            [31:0] dbg_data_pi_in,
    input                   dbg_data_we_in,
    input                   dbg_ext_break_in,
    input                   dbg_instr_exec_in,
    input            [15:0] jtag_ireg_in,
    input            [31:0] ocd_addr_pdcr_in, // addr
    input      signed [7:0] ocd_data_pdcr_in, // w08
    input            [31:0] ocd_instr_pdcr_in, // iword
    input                   ocd_mode_in, // t1u
    input                   ocd_swbreak_in, // t1u
    input            [31:0] pcr_in, // addr
    output reg       [31:0] dbg_data_po_out,
    output                  dbg_reset_out,
    output                  dbg_set_break_out,
    output reg              en_ocd_addr_pdcw_out, // std_logic
    output reg              en_ocd_data_pdcw_out, // std_logic
    output reg              en_ocd_instr_pdcw_out, // std_logic
    output reg       [31:0] ocd_addr_pdcw_out, // addr
    output reg signed [7:0] ocd_data_pdcw_out, // w08
    output                  ocd_exe_out, // t1u
    output reg       [31:0] ocd_instr_pdcw_out, // iword
    output reg              ocd_ld_DMb_out, // bool
    output reg              ocd_ld_PMb_out, // bool
    output                  ocd_req_out, // t1u
    output reg              ocd_st_DMb_out, // bool
    output reg              ocd_st_PMb_out // bool
  );



  // configuration parameters:
  localparam DBG_LDST_WATCHPOINTS             = 0;
  localparam DBG_RANGE_WATCHPOINTS            = 0;
  localparam DBG_MERGE_WATCHPOINTS_PER_MEMORY = 0;
  localparam DBG_REMEMBER_MEMORY_ACCESS       = 0;

  // register widths
  localparam DBG_DATA_REG_WIDTH               = 8;
  localparam DBG_ADDR_REG_WIDTH               = 32;
  localparam DBG_INSTR_REG_WIDTH              = 32;
  localparam DBG_STATUS_REG_WIDTH             = 16;
  localparam DBG_CONTEXT_REG_WIDTH            = 0;

  // status register bit indices
  localparam DBG_MODE_INDX                    = 0;
  localparam DBG_BP_HIT_INDX                  = 5;
  localparam DBG_BREAKIN_INDX                 = 6;
  localparam DBG_BREAKOUT_INDX                = 7;
  localparam DBG_SWBREAK_INDX                 = 8;

  // register indices
  localparam DBG_DATA_REG_INDX                = 2'b00;
  localparam DBG_ADDR_REG_INDX                = 2'b01;
  localparam DBG_INSTR_REG_INDX               = 2'b10;
  localparam DBG_STATUS_REG_INDX              = 2'b11;

  // register opcodes                         : 11'b0000000rrrr
  localparam DBG_DATA_REG_INSTR               = 11'b00000000000;
  localparam DBG_ADDR_REG_INSTR               = 11'b00000000001;
  localparam DBG_INSTR_REG_INSTR              = 11'b00000000010;
  localparam DBG_STATUS_REG_INSTR             = 11'b00000000011;
  localparam DBG_CONTEXT_REG_INSTR            = 11'b00000000100;

  // instruction opcodes                      : 11'b0000001iiii
  localparam DBG_REQUEST_INSTR                = 11'b00000010001;
  localparam DBG_RESUME_INSTR                 = 11'b00000010010;
  localparam DBG_RESET_INSTR                  = 11'b00000010011;
  localparam DBG_STEP_INSTR                   = 11'b00000010100;
  localparam DBG_EXECUTE_INSTR                = 11'b00000010101;
  localparam DBG_STEPDI_INSTR                 = 11'b00000010100;

  // breakpoint instruction opcodes           : 11'b000001bbbii
  localparam DBG_BP0_ENABLE_INSTR             = 11'b00000100000;
  localparam DBG_BP0_EXPORT_INSTR             = 11'b00000100001;
  localparam DBG_BP0_DISABLE_INSTR            = 11'b00000100010;
  localparam DBG_BP1_ENABLE_INSTR             = 11'b00000100100;
  localparam DBG_BP1_EXPORT_INSTR             = 11'b00000100101;
  localparam DBG_BP1_DISABLE_INSTR            = 11'b00000100110;
  localparam DBG_BP2_ENABLE_INSTR             = 11'b00000101000;
  localparam DBG_BP2_EXPORT_INSTR             = 11'b00000101001;
  localparam DBG_BP2_DISABLE_INSTR            = 11'b00000101010;
  localparam DBG_BP3_ENABLE_INSTR             = 11'b00000101100;
  localparam DBG_BP3_EXPORT_INSTR             = 11'b00000101101;
  localparam DBG_BP3_DISABLE_INSTR            = 11'b00000101110;

  // load/store instruction opcodes           : 11'b000010iiiii
  localparam DBG_PMb_LOAD_INSTR               = 11'b00001000000;
  localparam DBG_PMb_STORE_INSTR              = 11'b00001000001;
  localparam DBG_DMb_LOAD_INSTR               = 11'b00001000010;
  localparam DBG_DMb_STORE_INSTR              = 11'b00001000011;

  // common instructions "11111"...
  localparam DBG_SYNC_REQUEST_INSTR           = 16'b1111100000010001;
  localparam DBG_SYNC_RESUME_INSTR            = 16'b1111100000010010;
  localparam DBG_SYNC_RESET_INSTR             = 16'b1111100000010011;
  localparam DBG_SYNC_STEP_INSTR              = 16'b1111100000010100;
  localparam DBG_SYNC_STEPDI_INSTR            = 16'b1111100000010100;

  reg    [3:0] bp_enable;
  reg    [3:0] bp_export;
  reg    [3:0] bp_hits;
  reg    [3:0] breakout;
  wire   [4:0] core_id;
  wire   core_resume;
  wire   core_selected;
  wire   core_step;
  reg    [31:0] dbg_bp0;
  reg    dbg_bp0_we;
  reg    [31:0] dbg_bp1;
  reg    dbg_bp1_we;
  reg    [31:0] dbg_bp2;
  reg    dbg_bp2_we;
  reg    [31:0] dbg_bp3;
  reg    dbg_bp3_we;
  reg    exec_instr;
  wire   [4:0] jtag_ir_id;
  wire   [10:0] jtag_ir_op;
  wire   new_bp_hit;
  wire   new_breakout;
  wire   reg_bp_hit;
  wire   reg_breakout;
  wire   reg_dbg_mode;
  wire   reg_swbreak;
  reg    request_instr;
  reg    reset_instr;
  reg    resume0_instr;
  reg    resume1_instr;
  wire   set_bp_hit;
  wire   set_breakout;
  wire   set_dbg_mode;
  wire   set_swbreak;
  reg    step0_instr;
  reg    step1_instr;
  reg    [3:0] bp_enable_REG;
  reg    [3:0] bp_export_REG;
  reg    [31:0] dbg_bp0_REG;
  reg    [31:0] dbg_bp1_REG;
  reg    [31:0] dbg_bp2_REG;
  reg    [31:0] dbg_bp3_REG;
  reg    dbg_instr_exec_REG;
  reg    [15:0] dbg_status_REG;
  reg    reset_instr_REG;


  // assign to outputs
  assign ocd_req_out = (resume0_instr || core_step) ? 1'b0
    : (reg_dbg_mode || set_dbg_mode) ? 1'b1
    : 1'b0;
  assign dbg_reset_out = reset_instr_REG;
  assign ocd_exe_out = exec_instr;
  assign dbg_set_break_out = dbg_status_REG[DBG_BREAKOUT_INDX];

  // core selection, local opcode selection
  assign jtag_ir_id = jtag_ireg_in[15:11];
  assign jtag_ir_op = jtag_ireg_in[10:0];
  assign core_id = nid;
  assign core_selected = (jtag_ir_id == core_id) ? 1'b1 : 1'b0;

  always @ (posedge clock or posedge reset_ext)
  begin: delay_proc
    if (reset_ext)
    begin
      dbg_instr_exec_REG <= 1'b0;
      reset_instr_REG <= 1'b0;
    end
    else
    begin
      reset_instr_REG <= reset_instr;
      if ((step0_instr || resume0_instr) && ocd_mode_in)
        dbg_instr_exec_REG <= 1'b1;
      else if (!ocd_mode_in)
        dbg_instr_exec_REG <= 1'b0;
    end
  end

  // select debug register (demux/mux)
  always @ (*)
  begin: dbg_register_mux
    dbg_data_po_out = 0;
    en_ocd_data_pdcw_out = 1'b0;
    ocd_data_pdcw_out = 0;
    en_ocd_addr_pdcw_out = 1'b0;
    ocd_addr_pdcw_out = 0;
    en_ocd_instr_pdcw_out = 1'b0;
    ocd_instr_pdcw_out = 0;
    if (core_selected && (jtag_ir_op[7:4] == 4'b0000))
    begin
      if (dbg_data_we_in)
      begin
        case (jtag_ir_op[1:0])
          DBG_DATA_REG_INDX :
          begin
            en_ocd_data_pdcw_out = 1'b1;
            ocd_data_pdcw_out = $signed(dbg_data_pi_in[31:24]);
          end
          DBG_ADDR_REG_INDX :
          begin
            en_ocd_addr_pdcw_out = 1'b1;
            ocd_addr_pdcw_out = dbg_data_pi_in;
          end
          DBG_INSTR_REG_INDX :
          begin
            en_ocd_instr_pdcw_out = 1'b1;
            ocd_instr_pdcw_out = dbg_data_pi_in;
          end
          default :
            ; // null
        endcase
      end
      case (jtag_ir_op[1:0])
        DBG_DATA_REG_INDX :
          dbg_data_po_out[7:0] = $unsigned(ocd_data_pdcr_in);
        DBG_ADDR_REG_INDX :
          dbg_data_po_out = pcr_in;
        DBG_INSTR_REG_INDX :
          dbg_data_po_out = ocd_instr_pdcr_in;
        DBG_STATUS_REG_INDX :
          dbg_data_po_out[15:0] = dbg_status_REG;
        default :
          ; // null
      endcase
    end
  end

  // decode debug instructions
  always @ (*)
  begin: dbg_instr_decode
    request_instr = 1'b0;
    resume0_instr = 1'b0;
    resume1_instr = 1'b0;
    reset_instr = 1'b0;
    step0_instr = 1'b0;
    step1_instr = 1'b0;
    exec_instr = 1'b0;
    ocd_ld_PMb_out = 1'b0;
    ocd_st_PMb_out = 1'b0;
    ocd_ld_DMb_out = 1'b0;
    ocd_st_DMb_out = 1'b0;

    if (core_selected) // local

      case (jtag_ir_op)
        DBG_REQUEST_INSTR :
          if (dbg_instr_exec_in)
            request_instr = 1'b1;
        DBG_RESUME_INSTR :
          if (dbg_instr_exec_in)
            resume0_instr = 1'b1;
          else if (dbg_instr_exec_REG)
            resume1_instr = 1'b1;
        DBG_RESET_INSTR :
          if (dbg_instr_exec_in)
            reset_instr = 1'b1;
        DBG_STEP_INSTR :
          if (dbg_instr_exec_in)
            step0_instr = 1'b1;
          else if (dbg_instr_exec_REG)
            step1_instr = 1'b1;
        DBG_EXECUTE_INSTR :
          if (dbg_instr_exec_in)
            exec_instr = 1'b1;
        DBG_PMb_LOAD_INSTR :
          if (dbg_instr_exec_in)
            ocd_ld_PMb_out = 1'b1;
        DBG_PMb_STORE_INSTR :
          if (dbg_instr_exec_in)
            ocd_st_PMb_out = 1'b1;
        DBG_DMb_LOAD_INSTR :
          if (dbg_instr_exec_in)
            ocd_ld_DMb_out = 1'b1;
        DBG_DMb_STORE_INSTR :
          if (dbg_instr_exec_in)
            ocd_st_DMb_out = 1'b1;
        default :
          ; // null
      endcase

    else // global instructions

      case (jtag_ireg_in)
        DBG_SYNC_REQUEST_INSTR :
          if (dbg_instr_exec_in)
            request_instr = 1'b1;
        DBG_SYNC_RESUME_INSTR :
          if (dbg_instr_exec_in)
            resume0_instr = 1'b1;
          else if (dbg_instr_exec_REG)
            resume1_instr = 1'b1;
        DBG_SYNC_RESET_INSTR :
          if (dbg_instr_exec_in)
            reset_instr = 1'b1;
        DBG_SYNC_STEP_INSTR :
          if (dbg_instr_exec_in)
            step0_instr = 1'b1;
          else if (dbg_instr_exec_REG)
            step1_instr = 1'b1;
        default :
          ; // null
      endcase

  end

  // single instruction step: release core from dbg mode till first instr. issue
  assign core_step = step0_instr || step1_instr;

  // force release from breakpoint
  assign core_resume = resume0_instr || resume1_instr;

  // decode breakpoint instructions
  always @ (*)
  begin: breakpoint_decode
    bp_enable = bp_enable_REG;
    bp_export = bp_export_REG;
    dbg_bp0_we = 1'b0;
    dbg_bp0 = 0;
    dbg_bp1_we = 1'b0;
    dbg_bp1 = 0;
    dbg_bp2_we = 1'b0;
    dbg_bp2 = 0;
    dbg_bp3_we = 1'b0;
    dbg_bp3 = 0;
    if (core_selected && dbg_instr_exec_in)
      case (jtag_ir_op)
        DBG_RESET_INSTR :
        begin
          bp_enable = 0;
          bp_export = 0;
        end

        DBG_BP0_ENABLE_INSTR :
        begin
          dbg_bp0_we = 1'b1;
          bp_enable[0] = 1'b1;
          dbg_bp0 = ocd_addr_pdcr_in;
        end
        DBG_BP0_EXPORT_INSTR :
          bp_export[0] = 1'b1;
        DBG_BP0_DISABLE_INSTR :
        begin
          bp_enable[0] = 1'b0;
          bp_export[0] = 1'b0;
        end

        DBG_BP1_ENABLE_INSTR :
        begin
          dbg_bp1_we = 1'b1;
          bp_enable[1] = 1'b1;
          dbg_bp1 = ocd_addr_pdcr_in;
        end
        DBG_BP1_EXPORT_INSTR :
          bp_export[1] = 1'b1;
        DBG_BP1_DISABLE_INSTR :
        begin
          bp_enable[1] = 1'b0;
          bp_export[1] = 1'b0;
        end

        DBG_BP2_ENABLE_INSTR :
        begin
          dbg_bp2_we = 1'b1;
          bp_enable[2] = 1'b1;
          dbg_bp2 = ocd_addr_pdcr_in;
        end
        DBG_BP2_EXPORT_INSTR :
          bp_export[2] = 1'b1;
        DBG_BP2_DISABLE_INSTR :
        begin
          bp_enable[2] = 1'b0;
          bp_export[2] = 1'b0;
        end

        DBG_BP3_ENABLE_INSTR :
        begin
          dbg_bp3_we = 1'b1;
          bp_enable[3] = 1'b1;
          dbg_bp3 = ocd_addr_pdcr_in;
        end
        DBG_BP3_EXPORT_INSTR :
          bp_export[3] = 1'b1;
        DBG_BP3_DISABLE_INSTR :
        begin
          bp_enable[3] = 1'b0;
          bp_export[3] = 1'b0;
        end

        default :
          ; // null
      endcase

  end

  // update breakpoint control registers
  always @ (posedge clock or posedge reset_ext)
  begin: update_breakpoint_regs
    if (reset_ext)
    begin
      bp_enable_REG <= 0;
      bp_export_REG <= 0;
      dbg_bp0_REG <= 0;
      dbg_bp1_REG <= 0;
      dbg_bp2_REG <= 0;
      dbg_bp3_REG <= 0;
    end
    else
    begin
      bp_enable_REG <= bp_enable;
      bp_export_REG <= bp_export;
      if (dbg_bp0_we)
      begin
        dbg_bp0_REG <= dbg_bp0;
      end
      if (dbg_bp1_we)
      begin
        dbg_bp1_REG <= dbg_bp1;
      end
      if (dbg_bp2_we)
      begin
        dbg_bp2_REG <= dbg_bp2;
      end
      if (dbg_bp3_we)
      begin
        dbg_bp3_REG <= dbg_bp3;
      end
    end
  end

  // check breakpoint hit
  always @ (*)
  begin: check_breakpoint_hit

    if (reg_bp_hit)
      bp_hits = dbg_status_REG[4:1];
    else
      bp_hits = 0;
    breakout = 0;
    if (dbg_bp0_REG == pcr_in)
    begin
      bp_hits[0] = bp_enable_REG[0];
      breakout[0] = bp_export_REG[0];
    end
    if (dbg_bp1_REG == pcr_in)
    begin
      bp_hits[1] = bp_enable_REG[1];
      breakout[1] = bp_export_REG[1];
    end
    if (dbg_bp2_REG == pcr_in)
    begin
      bp_hits[2] = bp_enable_REG[2];
      breakout[2] = bp_export_REG[2];
    end
    if (dbg_bp3_REG == pcr_in)
    begin
      bp_hits[3] = bp_enable_REG[3];
      breakout[3] = bp_export_REG[3];
    end
  end

  assign new_bp_hit = (core_resume || core_step) ? 1'b0
    : bp_hits[0] || bp_hits[1] || bp_hits[2] || bp_hits[3];

  assign set_bp_hit = (resume0_instr || step0_instr) ? 1'b0
    : (new_bp_hit) ? 1'b1
    : reg_bp_hit;

  assign new_breakout = (core_resume || core_step) ? 1'b0
    : breakout[0] || breakout[1] || breakout[2] || breakout[3];

  assign set_breakout = (resume0_instr || step0_instr) ? 1'b0
    : (new_breakout) ? 1'b1
    : reg_breakout;

  assign set_dbg_mode = (resume0_instr) ? 1'b0
    : (request_instr || dbg_ext_break_in || new_bp_hit || ocd_swbreak_in) ? 1'b1
    : reg_dbg_mode;

  assign set_swbreak = (core_resume || core_step) ? 1'b0
    : (ocd_swbreak_in) ? 1'b1
    : reg_swbreak;

  // implementation of status register
  always @ (posedge clock or posedge reset_ext)
  begin: status_register
    if (reset_ext)
      dbg_status_REG <= 0;
    else
    begin
      dbg_status_REG <= {7'b0000000, set_swbreak,
        set_breakout, dbg_ext_break_in,
        set_bp_hit, bp_hits, set_dbg_mode};
    end
  end

  assign reg_dbg_mode = dbg_status_REG[DBG_MODE_INDX];
  assign reg_bp_hit = dbg_status_REG[DBG_BP_HIT_INDX];
  assign reg_breakout = dbg_status_REG[DBG_BREAKOUT_INDX];
  assign reg_swbreak = dbg_status_REG[DBG_SWBREAK_INDX];

endmodule
