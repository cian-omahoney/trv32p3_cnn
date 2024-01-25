##########################################################################################
# Tool: RTL Architect
# Script: floorplanning.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
source -echo ./rm_setup/rtl_setup.tcl 

##########################################################################################
# Open Library and Block
##########################################################################################
open_lib   ${WORK_DIR}/${DESIGN_LIBRARY} -ref_libs_for_edit
open_block ${DESIGN_NAME}/${CONDITIONING_LABEL_NAME}
save_block -hier -force -label ${FLOORPLANNING_LABEL_NAME}
close_lib  -purge -force -all
open_block ${WORK_DIR}/${DESIGN_LIBRARY}:${DESIGN_NAME}/${FLOORPLANNING_LABEL_NAME} -ref_libs_for_edit


##########################################################################################
# Pre RTL Floorplanning Customizations
##########################################################################################
# set_auto_floorplan_constraints can be added here prior to floorplanning breakpoint and will be honored. (although this has already been set prior to conditioning and is persistent)
# User could applying pin constraints prior to floorplanning as well 

# move from conditioning.tcl 
if {$EXPERT_FLOORPLAN_MODE == "true"} {
	source -echo -verbose $EXPERT_FLOORPLAN_SETTINGS
	puts "RM-info : Expert floorplan settings from TCL file $EXPERT_FLOORPLAN_SETTINGS \n"
} elseif {$DEF_FLOORPLAN_FILES != "" || $TCL_PHYSICAL_CONSTRAINTS_FILE != ""  } {
	set_app_options -list { rtl_opt.floorplan.skip_stages { initialize_floorplan }} ;# Specify floorplaning stages to skip, valid values are initialize_floorplan, shape_blocks, hier_placement, top_level_pin_assignment, block_level_pin_assignment, budgeting.
}


if {[file exists [which $TCL_USER_FLOORPLANNING_PRE_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_FLOORPLANNING_PRE_SCRIPT]"
        source $TCL_USER_FLOORPLANNING_PRE_SCRIPT
} elseif {$TCL_USER_FLOORPLANNING_PRE_SCRIPT != ""} {
        puts "RM-error : TCL_USER_FLOORPLANNING_PRE_SCRIPT($TCL_USER_FLOORPLANNING_PRE_SCRIPT) is invalid. Please correct it."
}


##########################################################################################
# Run RTL Floorplanning Conditioning
##########################################################################################
set rtl_opt_cmd "rtl_opt -from floorplanning -to floorplanning -block_instances \{${DP_BLOCK_INSTS}\} "

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
# Post RTL Floorplanning Customizations
##########################################################################################
if {[file exists [which $TCL_USER_FLOORPLANNING_POST_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_FLOORPLANNING_POST_SCRIPT]"
        source $TCL_USER_FLOORPLANNING_POST_SCRIPT
} elseif {$TCL_USER_FLOORPLANNING_POST_SCRIPT != ""} {
        puts "RM-error : TCL_USER_FLOORPLANNING_POST_SCRIPT($TCL_USER_FLOORPLANNING_POST_SCRIPT) is invalid. Please correct it."
}


##########################################################################################
# Save and Exit
##########################################################################################
save_lib -all
echo [date] > floorplanning
exit 

