##########################################################################################
# Tool: RTL Architect
# Script: conditioning.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
source -echo ./rm_setup/rtl_setup.tcl 

##########################################################################################
# Open Library and Block
##########################################################################################
open_lib   ${WORK_DIR}/${DESIGN_LIBRARY} -ref_libs_for_edit
open_block ${DESIGN_NAME}/${SPLITS_LABEL_NAME}
save_block -hier -force -label ${CONDITIONING_LABEL_NAME}
close_lib  -purge -force -all
open_block ${WORK_DIR}/${DESIGN_LIBRARY}:${DESIGN_NAME}/${CONDITIONING_LABEL_NAME} -ref_libs_for_edit


##########################################################################################
# Pre RTL Conditioning Customizations
##########################################################################################
if {$DEF_FLOORPLAN_FILES != ""} {
 	puts "RM-info : Reading DEF file $DEF_FLOORPLAN_FILES \n"
	read_def $DEF_FLOORPLAN_FILES
} elseif {[file exists [which $TCL_PHYSICAL_CONSTRAINTS_FILE]]} {
  	puts "RM-info : Creating floorplan from TCL file $TCL_PHYSICAL_CONSTRAINTS_FILE \n"
  	source -echo -verbose $TCL_PHYSICAL_CONSTRAINTS_FILE
}

set_auto_floorplan_constraints -core_utilization $AUTO_FLOORPLAN_UTILIZATION		;# User can check man page for more details.
puts "RM-info : core_utilization : $AUTO_FLOORPLAN_UTILIZATION \n"
set_app_options -name rtl_opt.floorplan.enable_feedthroughs -value $ALLOW_FEEDTHROUGH

#user can control pin placement, Example:
#set_block_pin_constraints -side 1 -self
#set_block_pin_constraints -side 2 -self -allowed_layers M4

report_auto_floorplan_constraints
report_block_pin_constraints

if {[file exists [which $TCL_USER_CONDITIONING_PRE_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_CONDITIONING_PRE_SCRIPT]"
        source $TCL_USER_CONDITIONING_PRE_SCRIPT
} elseif {$TCL_USER_CONDITIONING_PRE_SCRIPT != ""} {
        puts "RM-error : TCL_USER_CONDITIONING_PRE_SCRIPT($TCL_USER_CONDITIONING_PRE_SCRIPT) is invalid. Please correct it."
}


set set_technology_cmd "set_technology -node"
if {$NODE != ""} { 
              puts "RM-info : Setting technology node. \n"
              lappend set_technology_cmd $NODE
              echo $set_technology_cmd
              eval $set_technology_cmd  
}

##########################################################################################
# Run RTL Conditioning
##########################################################################################
if {$FLOORPLAN_STYLE == "abutted"} {
	set_app_option -list {rtl_opt.flow.fully_abutted_style_floorplan true}
        puts "RM-info : Design floorplan is $FLOORPLAN_STYLE. Skip top_conditioning stage. \n"
}

set rtl_opt_cmd "rtl_opt -from block_conditioning -to top_conditioning -block_instances \{${DP_BLOCK_INSTS}\}"

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
} else {
	puts "RM-Error : Please specify FLOW as hier. \n"
}

echo $rtl_opt_cmd
eval $rtl_opt_cmd


##########################################################################################
# Post RTL Conditioning Customizations
##########################################################################################
if {[file exists [which $TCL_USER_CONDITIONING_POST_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_CONDITIONING_POST_SCRIPT]"
        source $TCL_USER_CONDITIONING_POST_SCRIPT
} elseif {$TCL_USER_CONDITIONING_POST_SCRIPT != ""} {
        puts "RM-error : TCL_USER_CONDITIONING_POST_SCRIPT($TCL_USER_CONDITIONING_POST_SCRIPT) is invalid. Please correct it."
}


##########################################################################################
# Save and Exit
##########################################################################################
save_lib -all
echo [date] > conditioning
exit

