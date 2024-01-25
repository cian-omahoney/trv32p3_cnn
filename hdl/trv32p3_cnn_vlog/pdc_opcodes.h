
// File generated by Go version U-2022.12#33f3808fcb#221128, Thu Jan 25 16:08:15 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



#ifndef _pdc_opcodes_h
#define _pdc_opcodes_h

// configuration parameters:
const int DBG_LDST_WATCHPOINTS             = 0;
const int DBG_RANGE_WATCHPOINTS            = 0;
const int DBG_MERGE_WATCHPOINTS_PER_MEMORY = 0;
const int DBG_REMEMBER_MEMORY_ACCESS       = 0;
const int DBG_REMEMBER_DATA_SELECT         = 0;
const int DBG_INTERFACE_TYPE               = 0;
const int DBG_NUM_BREAKPOINT_UNITS         = 4;
const int DBG_SW_BREAKPOINTS               = 1;

// register widths
const int DBG_DATA_REG_WIDTH               = 8;
const int DBG_ADDR_REG_WIDTH               = 32;
const int DBG_INSTR_REG_WIDTH              = 32;
const int DBG_STATUS_REG_WIDTH             = 16;
const int DBG_CONTEXT_REG_WIDTH            = 0;

// status register bit indices
const int DBG_MODE_INDX                    = 0;
const int DBG_BP_HIT_INDX                  = 5;
const int DBG_BREAKIN_INDX                 = 6;
const int DBG_BREAKOUT_INDX                = 7;
const int DBG_SWBREAK_INDX                 = 8;

// register indices
const int DBG_DATA_REG_INDX                = 0x0;
const int DBG_ADDR_REG_INDX                = 0x1;
const int DBG_INSTR_REG_INDX               = 0x2;
const int DBG_STATUS_REG_INDX              = 0x3;

// register opcodes                        : 0000000rrrr (11 bits)
const int DBG_DATA_REG_INSTR               = 0x000;
const int DBG_ADDR_REG_INSTR               = 0x001;
const int DBG_INSTR_REG_INSTR              = 0x002;
const int DBG_STATUS_REG_INSTR             = 0x003;
const int DBG_CONTEXT_REG_INSTR            = 0x004;

// instruction opcodes                     : 0000001iiii (11 bits)
const int DBG_REQUEST_INSTR                = 0x011;
const int DBG_RESUME_INSTR                 = 0x012;
const int DBG_RESET_INSTR                  = 0x013;
const int DBG_STEP_INSTR                   = 0x014;
const int DBG_EXECUTE_INSTR                = 0x015;
const int DBG_STEPDI_INSTR                 = 0x014;

// breakpoint instruction opcodes          : 000001bbbii (11 bits)
const int DBG_BP0_ENABLE_INSTR             = 0x020;
const int DBG_BP0_EXPORT_INSTR             = 0x021;
const int DBG_BP0_DISABLE_INSTR            = 0x022;
const int DBG_BP1_ENABLE_INSTR             = 0x024;
const int DBG_BP1_EXPORT_INSTR             = 0x025;
const int DBG_BP1_DISABLE_INSTR            = 0x026;
const int DBG_BP2_ENABLE_INSTR             = 0x028;
const int DBG_BP2_EXPORT_INSTR             = 0x029;
const int DBG_BP2_DISABLE_INSTR            = 0x02a;
const int DBG_BP3_ENABLE_INSTR             = 0x02c;
const int DBG_BP3_EXPORT_INSTR             = 0x02d;
const int DBG_BP3_DISABLE_INSTR            = 0x02e;

// load/store instruction opcodes          : 000010iiiii (11 bits)
const int DBG_PMb_LOAD_INSTR               = 0x040;
const int DBG_PMb_STORE_INSTR              = 0x041;
const int DBG_DMb_LOAD_INSTR               = 0x042;
const int DBG_DMb_STORE_INSTR              = 0x043;

// repeat load/store instruction opcodes   : 000011iiiii (11 bits)
const int DBG_PMb_REPEAT_LOAD_INSTR        = 0x060;
const int DBG_PMb_REPEAT_STORE_INSTR       = 0x061;
const int DBG_DMb_REPEAT_LOAD_INSTR        = 0x062;
const int DBG_DMb_REPEAT_STORE_INSTR       = 0x063;

// common instructions "11111"...
const int DBG_SYNC_REQUEST_INSTR           = 0xf811;
const int DBG_SYNC_RESUME_INSTR            = 0xf812;
const int DBG_SYNC_RESET_INSTR             = 0xf813;
const int DBG_SYNC_STEP_INSTR              = 0xf814;
const int DBG_SYNC_STEPDI_INSTR            = 0xf814;

#endif

