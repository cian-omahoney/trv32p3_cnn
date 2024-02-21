##########################################################################################
# Tool: Fusion Compiler
# Script: read_rtl.tcl
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

# Controls HDLC naming style settings to make it easier to apply
# the same UPF file across multiple tools at the RTL level
set_app_options -name hdlin.naming.upf_compatible -value true

# set_app_options -name hdlin.elaborate.ff_infer_async_set_reset -value true
# set_app_options -name hdlin.elaborate.ff_infer_sync_set_reset  -value false

####################################
## Pre read RTL customizations
####################################
rm_source -file $TCL_USER_READ_RTL_PRE_SCRIPT -optional -print "TCL_USER_READ_RTL_PRE_SCRIPT"

########################################################################
## Analyze / Elaborate
########################################################################
switch ${RTL_SOURCE_FORMAT} {
        sverilog {
                analyze -format sverilog ${RTL_SOURCE_FILES}
                elaborate ${DESIGN_NAME}
                set_top_module ${DESIGN_NAME}
        }
        verilog {
                analyze -format verilog ${RTL_SOURCE_FILES}
                elaborate ${DESIGN_NAME}
                set_top_module ${DESIGN_NAME}
        }
        vhdl {
                analyze -format vhdl ${RTL_SOURCE_FILES}
                elaborate ${DESIGN_NAME}
                set_top_module ${DESIGN_NAME}
        }
        script {
		if {![rm_source -file $FC_RTL_READ_SCRIPT]} {
		## Note : The following executes only if FC_RTL_READ_SCRIPT is not sourced
			exit
		}
        }
        default {
                puts "RM-error: Unknown RTL_READ_FORMAT(${RTL_READ_FORMAT})"
                exit 
        }
}

####################################
## Post read RTL customizations
####################################
rm_source -file $TCL_USER_READ_RTL_POST_SCRIPT -optional -print "TCL_USER_READ_RTL_POST_SCRIPT"


