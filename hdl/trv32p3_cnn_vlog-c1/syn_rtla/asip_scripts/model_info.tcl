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

set RTL_SOURCE_LANGUAGE		"sverilog" ;# used for ASIPs when RTL_SOURCE_FORMAT = script

set FILENAMES		"
trv32p3_cnn/controller/controller.v
trv32p3_cnn/controller/hazards.v
trv32p3_cnn/controller/jtag_scan_register.v
trv32p3_cnn/controller/debug_controller.v
trv32p3_cnn/controller/jtag_interface.v
trv32p3_cnn/controller/jtag_tap_controller.v
trv32p3_cnn/controller/decoder.v
trv32p3_cnn/mux/mux_pm_addr.v
trv32p3_cnn/mux/mux_dm_addr.v
trv32p3_cnn/mux/mux_dmb_wr.v
trv32p3_cnn/mux/mux_x_w1.v
trv32p3_cnn/mux/mux_x_w1_dead.v
trv32p3_cnn/mux/mux_aluA.v
trv32p3_cnn/mux/mux_aluB.v
trv32p3_cnn/mux/mux_pcaA.v
trv32p3_cnn/mux/mux_pcaB.v
trv32p3_cnn/mux/mux_jmp_tgt_ID.v
trv32p3_cnn/mux/mux_aguB.v
trv32p3_cnn/mux/mux_mpyM.v
trv32p3_cnn/mux/mux_ocd_swbreak.v
trv32p3_cnn/mux/mux___pidTGT_w.v
trv32p3_cnn/mux/mux___X_x_w1_wad.v
trv32p3_cnn/mux/mux___X_x_r3_raddr.v
trv32p3_cnn/pipe/pipe___pidTGT.v
trv32p3_cnn/pipe/pipe___ocd_ld_DMbEX.v
trv32p3_cnn/pipe/pipe___ocd_ld_DMbS3.v
trv32p3_cnn/pipe/pipe___ocd_st_DMbEX.v
trv32p3_cnn/pipe/pipe___ocd_st_DMbS3.v
trv32p3_cnn/pipe/pipe___ocd_ld_PMbEX.v
trv32p3_cnn/pipe/pipe___ocd_ld_PMbS3.v
trv32p3_cnn/pipe/pipe___ocd_st_PMbEX.v
trv32p3_cnn/reg/reg_PC.v
trv32p3_cnn/reg/reg_PC_ID.v
trv32p3_cnn/reg/reg_PC_EX.v
trv32p3_cnn/reg/reg_X.v
trv32p3_cnn/reg/reg_ocd_addr.v
trv32p3_cnn/reg/reg_ocd_data.v
trv32p3_cnn/reg/reg_ocd_instr.v
trv32p3_cnn/mem/dm_merge.v
trv32p3_cnn/mem/dm_wbb.v
trv32p3_cnn/mem/mem_PMb.v
trv32p3_cnn/mem/mem_DMb.v
trv32p3_cnn/prim/alu.v
trv32p3_cnn/prim/pca.v
trv32p3_cnn/prim/cmp.v
trv32p3_cnn/prim/div.v
trv32p3_cnn/prim/lx.v
trv32p3_cnn/prim/agu.v
trv32p3_cnn/prim/mpy.v
trv32p3_cnn/prim/ocd_addr_incr.v
trv32p3_cnn/prim/cnn.v
trv32p3_cnn/trv32p3_cnn.v
"

set CLOCK_FREQ [env_get? CLOCK_FREQ 500]; # MHz
set OCD_CLOCK_FREQ [env_get? OCD_CLOCK_FREQ 10]; # MHz
set CLK_NAME               "clock"
set RESET_NAME             "reset_pdc"
set EXT_RESET_NAME             "reset"

set JTAG_CLK_NAME "jtag_tck_in"
set JTAG_RESET "jtag_trst"
set JTAG_INPUT_PORTS_NO_RST {jtag_tdi_in jtag_tms_in}
set JTAG_OUTPUT_PORTS jtag_tdo_out

