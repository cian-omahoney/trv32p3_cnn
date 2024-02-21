##########################################################################################
# Tool: RTL Architect
# Script: estimation.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
source -echo ./rm_setup/rtl_setup.tcl 

##########################################################################################
# Open Library and Block
##########################################################################################
open_lib   ${WORK_DIR}/${DESIGN_LIBRARY} -ref_libs_for_edit
open_block ${DESIGN_NAME}/${FLOORPLANNING_LABEL_NAME}
save_block -hier -force -label ${ESTIMATION_LABEL_NAME}
close_lib  -purge -force -all
open_block ${WORK_DIR}/${DESIGN_LIBRARY}:${DESIGN_NAME}/${ESTIMATION_LABEL_NAME} -ref_libs_for_edit


##########################################################################################
# Pre RTL Estimation Customizations
##########################################################################################
if {[file exists [which $TCL_USER_ESTIMATION_PRE_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_ESTIMATION_PRE_SCRIPT]"
        source $TCL_USER_ESTIMATION_PRE_SCRIPT
} elseif {$TCL_USER_ESTIMATION_PRE_SCRIPT != ""} {
        puts "RM-error : TCL_USER_ESTIMATION_PRE_SCRIPT($TCL_USER_ESTIMATION_PRE_SCRIPT) is invalid. Please correct it."
}


set set_technology_cmd "set_technology -node"
if {$NODE != ""} { 
              puts "RM-info : Setting technology node. \n"
              lappend set_technology_cmd $NODE
              echo $set_technology_cmd
              eval $set_technology_cmd  
}

##########################################################################################
# Run RTL Estimation
##########################################################################################
if {$FLOORPLAN_STYLE == "abutted"} {
	set_app_option -list {rtl_opt.flow.fully_abutted_style_floorplan true}
        puts "RM-info : Design floorplan is $FLOORPLAN_STYLE. Skip top_estimation stage. \n"
}


set rtl_opt_cmd "rtl_opt -from block_estimation -to top_estimation -block_instances \{${DP_BLOCK_INSTS}\} "

if {$USER_SETTINGS_MAPPING_FILE != ""} {
	append rtl_opt_cmd " -mapping_file \{$USER_SETTINGS_MAPPING_FILE\}"
	puts "RM-info : Mapping file found. Using $USER_SETTINGS_MAPPING_FILE for the design. \n"
} else {
	puts "RM-info : No Mapping file found. \n"
}

if {$DISTRIBUTED} {
         set HOST_OPTIONS "-host_options block_script"
      } else {
         set HOST_OPTIONS ""
      }

if {$FLOW == "hier" } { 
	if {$DISTRIBUTED == "true" && $ABS_BLOCK_INSTS!= ""} {
	        append rtl_opt_cmd " -abs_block_instances \{${ABS_BLOCK_INSTS}\}  ${HOST_OPTIONS}"
		puts "RM-info : Design run in Hier Abstraction && Distributed mode. \n"
	}
	if {$DISTRIBUTED == "true" && $ABS_BLOCK_INSTS== ""} {
        	append rtl_opt_cmd  " ${HOST_OPTIONS}"
        	puts "RM-info : Design run in Hier Distributed mode. \n"
	}
	if {$DISTRIBUTED == "false" && $ABS_BLOCK_INSTS!= ""} {
        	append rtl_opt_cmd " -abs_block_instances \{${ABS_BLOCK_INSTS}\}"
        	puts "RM-info : Design run in Hier Abstraction mode. \n"
	}
	if {$DISTRIBUTED == "false" && $ABS_BLOCK_INSTS== ""} {
		append rtl_opt_cmd ""
		puts "RM-info : Design run in Hier mode. \n"
	}
} else  {
	puts "RM-Error : Please specified $FLOW. \n"
}

echo $rtl_opt_cmd
eval $rtl_opt_cmd


##########################################################################################
# Post RTL Estimation Customizations
##########################################################################################
if {[file exists [which $TCL_USER_ESTIMATION_POST_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_ESTIMATION_POST_SCRIPT]"
        source $TCL_USER_ESTIMATION_POST_SCRIPT
} elseif {$TCL_USER_ESTIMATION_POST_SCRIPT != ""} {
        puts "RM-error : TCL_USER_ESTIMATION_POST_SCRIPT($TCL_USER_ESTIMATION_POST_SCRIPT) is invalid. Please correct it."
}


##########################################################################################
# Save and Exit
##########################################################################################
save_lib -all
echo [date] > estimation
exit

