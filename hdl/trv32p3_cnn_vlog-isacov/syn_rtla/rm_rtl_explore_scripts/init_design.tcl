##########################################################################################
# Tool: RTL Architect
# Script: init_design.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
source -echo ./rm_setup/rtl_setup.tcl 

##########################################################################################
# Create Library
##########################################################################################
if {[file exists [which ${TECH_FILE}]]} {
	create_lib ${WORK_DIR}/${DESIGN_LIBRARY} -ref_libs ${REFERENCE_LIBRARY} -technology ${TECH_FILE}
} elseif {${TECH_LIB} != ""} {
	create_lib ${WORK_DIR}/${DESIGN_LIBRARY} -ref_libs ${REFERENCE_LIBRARY} -use_technology_lib ${TECH_LIB}
}


##########################################################################################
# Read in the RTL Design
##########################################################################################
# Enable DMM 
set_current_mismatch_config auto_fix
get_current_mismatch_config

# To ensure SAIF simulation properly annotated  
set_app_options -name hdlin.naming.upf_compatible -value true
set_app_options -name hdlin.naming.sverilog_union_member  -value true

if {[file exists [which $TCL_USER_READ_RTL_PRE_SCRIPT]]} {
        puts "RM-info: Sourcing [which $TCL_USER_READ_RTL_PRE_SCRIPT]"
        source -echo $TCL_USER_READ_RTL_PRE_SCRIPT
} elseif {$TCL_USER_READ_RTL_PRE_SCRIPT != ""} {
        puts "RM-error: TCL_USER_READ_RTL_PRE_SCRIPT($TCL_USER_READ_RTL_PRE_SCRIPT) is invalid. Please correct it."
}

switch ${RTL_SOURCE_FORMAT} {
   sverilog {
      puts "RM-info : Reading RTL file(s) ${RTL_SOURCE_FILES}"
      analyze -format sverilog ${RTL_SOURCE_FILES}
   }
   verilog {
      puts "RM-info : Reading RTL file(s) ${RTL_SOURCE_FILES}"
      analyze -format verilog ${RTL_SOURCE_FILES}
   }
   vhdl {
      puts "RM-info : Reading RTL file(s) ${RTL_SOURCE_FILES}"
      analyze -format vhdl ${RTL_SOURCE_FILES}
   }
   script {
      if {[file exists [which ${RTL_READ_SCRIPT}]]} {
         puts "RM-info : Sourcing [which ${RTL_READ_SCRIPT}]"
         source -echo ${RTL_READ_SCRIPT}
      } else {
         puts "RM-error : RTL_READ_INPUT_SCRIPT(${RTL_READ_SCRIPT}) is invalid. Please correct it."
         exit
      }
   }
   default {
      puts "RM-error : Unknown RTL_SOURCE_FORMAT (${RTL_SOURCE_FORMAT})"
      exit 
   }
}

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# ASIPs require a customized elaborate command for VHDL
# Therefore, if RTL_SOURCE_FORMAT is 'script', the
# following commands can be skipped, they have been
# included in  RTL_READ_SCRIPT.
if {![info exists env(ASIP_FLOW)] || $RTL_SOURCE_FORMAT != "script"} {
######### END CHANGED FOR ASIP SCRIPTS ############
if {$EARLY_DATA_CHECK_POLICY != "none"} {
	puts "RM-info: Enabling Design check manager(DCM) setting"
	elaborate ${DESIGN_NAME}
	set_early_data_check_policy -policy $EARLY_DATA_CHECK_POLICY -if_not_exist
	set_top_module ${DESIGN_NAME}
	## Report Early Data Check Results
	redirect -file ./${REPORTS_DIR}/${DESIGN_NAME}.report_early_data_checks.list_of_checks {report_early_data_checks -policy}
	redirect -file ./${REPORTS_DIR}/${DESIGN_NAME}.report_early_data_checks.rpt {report_early_data_checks -verbose}
  } else {
    puts " RM-Info : Design check manager(DCM) is not enabled"
	elaborate ${DESIGN_NAME}
	set_top_module ${DESIGN_NAME}
}
######### BEGIN CHANGED FOR ASIP SCRIPTS ############
}
######### END CHANGED FOR ASIP SCRIPTS ############

report_design_mismatch -verbose > ./${REPORTS_DIR}/design.mismatch.rpt

if {$ENABLE_PRE_RTL_OPT_NETLIST_CHECKS == "true"} {
	check_design -checks netlist 
	puts "RM-Info : Perform prelude netlist checks to foreseen bad RTL coding error.\n"
} 

saif_map -start 			;#Starts the internal name-mapping mechanism and records the name transformations

##########################################################################################
# Tech Setup File 
###########################################################################################
if {$ROUTING_LAYER_DIRECTION_OFFSET_LIST != ""} {
  	source -echo -verbose  ${TCL_TECH_SETUP_FILE}
	puts "RM-info : Sourcing ${TCL_TECH_SETUP_FILE} for routing information. \n"
} else {
	puts "RM-warning : Please specify the routing direction in ROUTING_LAYER_DIRECTION_OFFSET_LIST, else tool will auto assign the routing direction. Result might not be optimal. \n"
}


##########################################################################################
# Create DFT Ports
##########################################################################################
# Create DFT ports if necessary
if { ${DFT_FLOW} != "" } {   
      if {[file exists [which $TCL_DFT_PORTS_FILE]]} {
              puts "RM-info: Sourcing [which $TCL_DFT_PORTS_FILE]"
              source -echo $TCL_DFT_PORTS_FILE
      } elseif {$TCL_DFT_PORTS_FILE != ""} {
              puts "RM-error: TCL_DFT_PORTS_FILE($TCL_DFT_PORTS_FILE) is invalid. Please correct it."
      }
}

###################################
## DFT
###################################
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

################################################################
## Read and commit the UPF file(s)  
################################################################
if {$UPF_MODE == "golden"} {
	set_app_options -name mv.upf.enable_golden_upf -value true ;# tool default false
 }

 if {$UPF_MODE != "none" && [file exists [which $UPF_FILE]]} {
	load_upf $UPF_FILE
	  ## Read the supply set file
	  if {[file exists [which $UPF_UPDATE_SUPPLY_SET_FILE]]} {
		  load_upf $UPF_UPDATE_SUPPLY_SET_FILE
	  } elseif {$UPF_UPDATE_SUPPLY_SET_FILE != ""} {
		  puts "RM-error: UPF_UPDATE_SUPPLY_SET_FILE($UPF_UPDATE_SUPPLY_SET_FILE) is invalid. Please correct it."
	  }
		  commit_upf
	} elseif {$UPF_FILE != ""} {
		puts "RM-error : UPF file($UPF_FILE) is invalid. Please correct it."
	}


##########################################################################################
# Read in the Logical Design Constraints
##########################################################################################
## Specify a Tcl script to read in your TLU+ files by using the read_parasitic_tech command;
#  Refer to init_design.read_parasitic_tech_example.tcl for sample commands
if {[file exists [which $TCL_PARASITIC_SETUP_FILE]]} {
  	puts "RM-info : Sourcing [which $TCL_PARASITIC_SETUP_FILE]"
  	source -echo -verbose $TCL_PARASITIC_SETUP_FILE
} elseif {$TCL_PARASITIC_SETUP_FILE != ""} {
  	puts "RM-error : TCL_PARASITIC_SETUP_FILE($TCL_PARASITIC_SETUP_FILE) is invalid. Please correct it."
}

## Specify a Tcl script to create your corners, modes, scenarios and load respective constraints;
#  Two examples are provided: 
#  - init_design.mcmm_example.explicit.tcl: provide mode, corner, and scenario constraints; create modes, corners, 
#    and scenarios; source mode, corner, and scenario constraints, respectively 
#  - init_design.mcmm_example.auto_expanded.tcl: provide constraints for the scenarios; create modes, corners, 
#    and scenarios; source scenario constraints which are then expanded to associated modes and corners

if {[file exists [which $TCL_MCMM_SETUP_FILE]]} {
	puts "RM-info : Loading MCMM file $TCL_MCMM_SETUP_FILE \n"
	source -echo -verbose $TCL_MCMM_SETUP_FILE
} else {
	puts "RM-warning : MCMM file not found \n"
}


##########################################################################################
# Read SAIF
##########################################################################################
if {[file exists [which $SAIF_FILE_LIST]] && [llength $SAIF_FILE_LIST] == 1} {
  if {[file exists [which $SAIF_FILE_LIST]]} {
                  if {$SAIF_FILE_POWER_SCENARIO != ""} {
                                  set read_saif_cmd "read_saif $SAIF_FILE_LIST -scenarios $SAIF_FILE_POWER_SCENARIO"
                  } else {
                                  set read_saif_cmd "read_saif $SAIF_FILE_LIST"
                  }
                  if {$SAIF_FILE_SOURCE_INSTANCE != ""} {lappend read_saif_cmd -strip_path $SAIF_FILE_SOURCE_INSTANCE}
                  puts "RM-info: Running $read_saif_cmd"
                  eval ${read_saif_cmd}
  } elseif {$SAIF_FILE_LIST != ""} {
                  puts "RM-error: SAIF_FILE($SAIF_FILE_LIST) is invalid. Please correct it. \n"           
  }
} elseif {[llength $SAIF_FILE_LIST] > 1} {
  	puts "RM-error : Please provide a single SAIF file, multiple SAIF files are not supported in RTLA. \n"

} else {
  	puts "RM-warning : SAIF file not found! \n"
}

################################################################
## FUSA Setup
################################################################
if {$ENABLE_FUSA} {
  source -echo -verbose init_design.fusa_setup.tcl
}

##########################################################################################
## Post-init_design customizations
##########################################################################################
if {[file exists [which $TCL_USER_INIT_DESIGN_POST_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_INIT_DESIGN_POST_SCRIPT]"
        source $TCL_USER_INIT_DESIGN_POST_SCRIPT
} elseif {$TCL_USER_INIT_DESIGN_POST_SCRIPT != ""} {
        puts "RM-error : TCL_USER_INIT_DESIGN_POST_SCRIPT($TCL_USER_INIT_DESIGN_POST_SCRIPT) is invalid. Please correct it."
}


##########################################################################################
# Save and Exit
##########################################################################################
save_block -force -label ${INIT_DESIGN_LABEL_NAME}
save_lib   -all
echo [date] > init_design
exit


