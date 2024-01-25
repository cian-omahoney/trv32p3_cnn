
// File generated by Go version U-2022.12#33f3808fcb#221128, Thu Jan 25 16:08:15 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



#include "pdc_commands.h"

#include <stdlib.h>

void pdc_commands::init_bpwp_codes(int core_id)
{
    if (core_id > max_core_id) {
        cerr << "invalid core_id (maximum coreid = " << max_core_id << "): "
             << core_id << '\n';
        exit(1);
    }
    // core ID
    int cid = core_id << 11;

    // breakpoint instruction opcodes          : 000001bbbii (11 bits)
    bp_enable_instr [0] = cid | 0x020;
    bp_export_instr [0] = cid | 0x021;
    bp_disable_instr[0] = cid | 0x022;
    bp_enable_instr [1] = cid | 0x024;
    bp_export_instr [1] = cid | 0x025;
    bp_disable_instr[1] = cid | 0x026;
    bp_enable_instr [2] = cid | 0x028;
    bp_export_instr [2] = cid | 0x029;
    bp_disable_instr[2] = cid | 0x02a;
    bp_enable_instr [3] = cid | 0x02c;
    bp_export_instr [3] = cid | 0x02d;
    bp_disable_instr[3] = cid | 0x02e;

    // map of alias to root memories
    bp_root_mem["PMb"] = "PMb";
    bp_root_mem["PM"] = "PMb";
    bp_root_mem["DMb"] = "DMb";
    bp_root_mem["DMh"] = "DMb";
    bp_root_mem["DMw"] = "DMb";
    bp_root_mem["DMb_stat"] = "DMb";
    bp_root_mem["DMh_stat"] = "DMb";
    bp_root_mem["DMw_stat"] = "DMb";
    bp_root_mem["wDM"] = "wDM";
    bp_root_mem["eDM"] = "eDM";
}
