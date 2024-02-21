##########################################################################################
# Original Script: design_setup.tcl ->  design_setup.tcl.ORIG
# Version: T-2022.06
##########################################################################################

if {[info exists env(ASIP_FLOW)]} {
    rm_source -file $::env(ASIP_SCRIPTS)/asip_setup.tcl
} else {
    rm_source -file $::env(ASIP_FC_DIR)/rm_setup/design_setup.ORIG
}

