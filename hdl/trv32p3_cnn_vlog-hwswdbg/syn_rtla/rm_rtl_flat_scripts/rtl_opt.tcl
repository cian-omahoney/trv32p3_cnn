##########################################################################################
# Tool: RTL Architect
# Script: rtl_opt.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
source -echo ./rm_setup/rtl_setup.tcl

##########################################################################################
# Open Library and Block
##########################################################################################
open_lib   ${WORK_DIR}/${DESIGN_LIBRARY} -ref_libs_for_edit
open_block ${DESIGN_NAME}/${INIT_DESIGN_LABEL_NAME}
save_block -hier -force -label ${RTL_OPT_LABEL_NAME}
close_lib  -purge -force -all
open_block ${WORK_DIR}/${DESIGN_LIBRARY}:${DESIGN_NAME}/${RTL_OPT_LABEL_NAME} -ref_libs_for_edit


##########################################################################################
# Import user floorplan (Hier flow will load floorplan in commit stage)
##########################################################################################
if {$DEF_FLOORPLAN_FILES != ""} {
 	puts "RM-info : Reading DEF file $DEF_FLOORPLAN_FILES \n"
	read_def $DEF_FLOORPLAN_FILES

} elseif {[file exists [which $TCL_PHYSICAL_CONSTRAINTS_FILE]]} {
  	puts "RM-info : Creating floorplan from TCL file $TCL_PHYSICAL_CONSTRAINTS_FILE \n"
  	source -echo -verbose $TCL_PHYSICAL_CONSTRAINTS_FILE
} else {
	set_auto_floorplan_constraints -core_utilization $AUTO_FLOORPLAN_UTILIZATION 		;# User can check man page for more details.
	puts "RM-info : core_utilization : $AUTO_FLOORPLAN_UTILIZATION \n"
	report_auto_floorplan_constraints

	#user can control pin placement, Example:
	#set_block_pin_constraints -side 1 -self
	#set_block_pin_constraints -side 2 -self -allowed_layers M4
	report_block_pin_constraints
	report_block_pin_constraints -self
}

if {$EXPERT_FLOORPLAN_MODE == "true"} {
	source -echo -verbose $EXPERT_FLOORPLAN_SETTINGS
	puts "RM-info : Expert floorplan settings from TCL file $EXPERT_FLOORPLAN_SETTINGS \n"
} 


##########################################################################################
## DFT (to resolve DFT commands which is not save across session)
##########################################################################################
if {$DEFAULT_DFT_MODE == "true"} {
	set_app_option -name dft.test_enable_dftip_insertion_rtla  -value true 
	puts "RM-info : Default DFT settings from TCL file $DEFAULT_DFT_SETTINGS \n"
	source -echo -verbose $DEFAULT_DFT_SETTINGS
} else {
	if {[file exists [which $TCL_DFT_SETUP_FILE]]} {
	puts "RM-info : Sourcing  [which $TCL_DFT_SETUP_FILE]"
	source -echo -verbose $TCL_DFT_SETUP_FILE	
######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Print error only if a setup file name has been set
# Changed to:
        } elseif {$TCL_DFT_SETUP_FILE != ""} {
######### END CHANGED FOR ASIP SCRIPTS ############
	   puts "RM-Error : TCL_DFT_SETUP_FILE ($TCL_DFT_SETUP_FILE) is not found. Please correct it."
        }
}


##########################################################################################
# Conditioning
##########################################################################################
# Pre RTL Conditioning Customizations
##########################################################################################
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
# BreakPoint Flow Triggered if Conditioning post script or Estimation pre script exists
##########################################################################################

if {[file exists $TCL_USER_CONDITIONING_POST_SCRIPT] || [file exists $TCL_USER_ESTIMATION_PRE_SCRIPT]} {
  puts "RM-info : Running rtl_opt with break-point. \n"

  ##########################################################################################
  # Run RTL Conditioning
  ##########################################################################################
  set rtl_opt_cmd "rtl_opt -from conditioning -to conditioning "

  if {$FLOW == "flat"} {
  	lappend rtl_opt_cmd
          puts "RM-info : Design run in Block mode. \n"
  } else  {
  	puts "RM-Error : Please specify FLOW as flat. \n"
  }

  echo $rtl_opt_cmd
  eval $rtl_opt_cmd

  save_block -hier -force -label ${CONDITIONING_LABEL_NAME}


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
  # Estimation
  ##########################################################################################
  # Pre RTL Estimation Customizations
  ##########################################################################################
  if {[file exists [which $TCL_USER_ESTIMATION_PRE_SCRIPT]]} {
          puts "RM-info : Sourcing [which $TCL_USER_ESTIMATION_PRE_SCRIPT]"
          source $TCL_USER_ESTIMATION_PRE_SCRIPT
  } elseif {$TCL_USER_ESTIMATION_PRE_SCRIPT != ""} {
          puts "RM-error : TCL_USER_ESTIMATION_PRE_SCRIPT($TCL_USER_ESTIMATION_PRE_SCRIPT) is invalid. Please correct it."
  }


  ##########################################################################################
  # Run RTL Estimation
  ##########################################################################################

  set rtl_opt_cmd "rtl_opt -from estimation -to estimation "

  if {$FLOW == "flat"} {
  	lappend rtl_opt_cmd
          puts "RM-info : Design run in Flat mode. \n"
  } else {
  	puts "RM-Error : Please specify FLOW as flat. \n"
  }

  echo $rtl_opt_cmd
  eval $rtl_opt_cmd

} else { 
  puts "RM-info : Running rtl_opt without break-point. \n"
  set rtl_opt_cmd "rtl_opt"
  if {$FLOW == "flat"} {
  	lappend rtl_opt_cmd
  	puts "RM-info : Design run in Block mode. \n"
  } else  {
  	puts "RM-Error : Please specify FLOW as flat. \n"
  }

  echo $rtl_opt_cmd
  eval $rtl_opt_cmd

}
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
echo [date] > rtl_opt 
exit


