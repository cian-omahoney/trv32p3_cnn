# File: model.info .tcl
#Information extracted from the ASIP model and Go's Configuration

puts "RM-info (asip) : Running script [info script]\n"

proc env_get? {key default} {
    if {[info exists ::env($key)]} {
        return $::env($key)
    } else {
        return $default
    }
}

set MODEL_NAME trv32p3_cnn

set RTL_SOURCE_LANGUAGE		"vhdl" ;# used for ASIPs when RTL_SOURCE_FORMAT = script

set FILENAMES		"
trv32p3_cnn/data_types.vhd
trv32p3_cnn/controller/cntrl_types.vhd
trv32p3_cnn/controller/controller_ent.vhd
trv32p3_cnn/controller/controller_arch.vhd
trv32p3_cnn/controller/hazards_ent.vhd
trv32p3_cnn/controller/hazards_arch.vhd
trv32p3_cnn/controller/jtag_scan_register_ent.vhd
trv32p3_cnn/controller/jtag_scan_register_arch.vhd
trv32p3_cnn/controller/debug_controller_ent.vhd
trv32p3_cnn/controller/debug_controller_arch.vhd
trv32p3_cnn/controller/jtag_interface_ent.vhd
trv32p3_cnn/controller/jtag_interface_arch.vhd
trv32p3_cnn/controller/jtag_tap_controller_ent.vhd
trv32p3_cnn/controller/jtag_tap_controller_arch.vhd
trv32p3_cnn/controller/decoder_ent.vhd
trv32p3_cnn/controller/decoder_arch.vhd
trv32p3_cnn/mux/mux_pm_addr_ent.vhd
trv32p3_cnn/mux/mux_pm_addr_arch.vhd
trv32p3_cnn/mux/mux_pm_wr_ent.vhd
trv32p3_cnn/mux/mux_pm_wr_arch.vhd
trv32p3_cnn/mux/mux_dm_addr_ent.vhd
trv32p3_cnn/mux/mux_dm_addr_arch.vhd
trv32p3_cnn/mux/mux_dmb_wr_ent.vhd
trv32p3_cnn/mux/mux_dmb_wr_arch.vhd
trv32p3_cnn/mux/mux_x_w1_ent.vhd
trv32p3_cnn/mux/mux_x_w1_arch.vhd
trv32p3_cnn/mux/mux_x_w1_dead_ent.vhd
trv32p3_cnn/mux/mux_x_w1_dead_arch.vhd
trv32p3_cnn/mux/mux_ocd_data_w_ent.vhd
trv32p3_cnn/mux/mux_ocd_data_w_arch.vhd
trv32p3_cnn/mux/mux_ocd_instr_w_ent.vhd
trv32p3_cnn/mux/mux_ocd_instr_w_arch.vhd
trv32p3_cnn/mux/mux_aluA_ent.vhd
trv32p3_cnn/mux/mux_aluA_arch.vhd
trv32p3_cnn/mux/mux_aluB_ent.vhd
trv32p3_cnn/mux/mux_aluB_arch.vhd
trv32p3_cnn/mux/mux_pcaA_ent.vhd
trv32p3_cnn/mux/mux_pcaA_arch.vhd
trv32p3_cnn/mux/mux_pcaB_ent.vhd
trv32p3_cnn/mux/mux_pcaB_arch.vhd
trv32p3_cnn/mux/mux_jmp_tgt_ID_ent.vhd
trv32p3_cnn/mux/mux_jmp_tgt_ID_arch.vhd
trv32p3_cnn/mux/mux_aguB_ent.vhd
trv32p3_cnn/mux/mux_aguB_arch.vhd
trv32p3_cnn/mux/mux_mpyM_ent.vhd
trv32p3_cnn/mux/mux_mpyM_arch.vhd
trv32p3_cnn/mux/mux_ocd_swbreak_ent.vhd
trv32p3_cnn/mux/mux_ocd_swbreak_arch.vhd
trv32p3_cnn/mux/mux_pidTGT_w_ent.vhd
trv32p3_cnn/mux/mux_pidTGT_w_arch.vhd
trv32p3_cnn/mux/mux_X_x_w1_wad_ent.vhd
trv32p3_cnn/mux/mux_X_x_w1_wad_arch.vhd
trv32p3_cnn/pipe/pipe_pidTGT_ent.vhd
trv32p3_cnn/pipe/pipe_pidTGT_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_DMbEX_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_DMbEX_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_DMbS3_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_DMbS3_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_st_DMbEX_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_st_DMbEX_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_st_DMbS3_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_st_DMbS3_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_PMbEX_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_PMbEX_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_PMbS3_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_PMbS3_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_st_PMbEX_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_st_PMbEX_arch.vhd
trv32p3_cnn/reg/reg_PC_ent.vhd
trv32p3_cnn/reg/reg_PC_arch.vhd
trv32p3_cnn/reg/reg_PC_ID_ent.vhd
trv32p3_cnn/reg/reg_PC_ID_arch.vhd
trv32p3_cnn/reg/reg_PC_EX_ent.vhd
trv32p3_cnn/reg/reg_PC_EX_arch.vhd
trv32p3_cnn/reg/reg_X_ent.vhd
trv32p3_cnn/reg/reg_X_arch.vhd
trv32p3_cnn/reg/reg_ocd_addr_ent.vhd
trv32p3_cnn/reg/reg_ocd_addr_arch.vhd
trv32p3_cnn/reg/reg_ocd_data_ent.vhd
trv32p3_cnn/reg/reg_ocd_data_arch.vhd
trv32p3_cnn/reg/reg_ocd_instr_ent.vhd
trv32p3_cnn/reg/reg_ocd_instr_arch.vhd
trv32p3_cnn/mem/dm_merge.vhd
trv32p3_cnn/mem/dm_wbb.vhd
trv32p3_cnn/mem/mem_PMb_ent.vhd
trv32p3_cnn/mem/mem_PMb_arch.vhd
trv32p3_cnn/mem/mem_DMb_ent.vhd
trv32p3_cnn/mem/mem_DMb_arch.vhd
trv32p3_cnn/prim/primitives.vhd
trv32p3_cnn/prim/alu_ent.vhd
trv32p3_cnn/prim/alu_arch.vhd
trv32p3_cnn/prim/pca_ent.vhd
trv32p3_cnn/prim/pca_arch.vhd
trv32p3_cnn/prim/cmp_ent.vhd
trv32p3_cnn/prim/cmp_arch.vhd
trv32p3_cnn/prim/div.vhd
trv32p3_cnn/prim/lx_ent.vhd
trv32p3_cnn/prim/lx_arch.vhd
trv32p3_cnn/prim/agu_ent.vhd
trv32p3_cnn/prim/agu_arch.vhd
trv32p3_cnn/prim/mpy_ent.vhd
trv32p3_cnn/prim/mpy_arch.vhd
trv32p3_cnn/prim/ocd_addr_incr_ent.vhd
trv32p3_cnn/prim/ocd_addr_incr_arch.vhd
trv32p3_cnn/prim/cnn_ent.vhd
trv32p3_cnn/prim/cnn_arch.vhd
trv32p3_cnn/trv32p3_cnn_ent.vhd
trv32p3_cnn/trv32p3_cnn_arch.vhd
trv32p3_cnn/trv32p3_cnn_config.vhd
"

set CLOCK_FREQ [env_get? CLOCK_FREQ 500]; # MHz
set OCD_CLOCK_FREQ [env_get? OCD_CLOCK_FREQ 10]; # MHz
set CLK_NAME               "clock"
set RESET_NAME             "reset_ext"

set JTAG_CLK_NAME "jtag_tck_in"
set JTAG_RESET "jtag_trst"
set JTAG_INPUT_PORTS_NO_RST {jtag_tdi_in jtag_tms_in}
set JTAG_OUTPUT_PORTS jtag_tdo_out

