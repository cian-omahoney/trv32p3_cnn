##########################################################################################
# Tool: Fusion Compiler
# Script: init_design.from_rtl.tcl
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

########################################################################
## Library creation
########################################################################

	if {[file exists $DESIGN_LIBRARY]} {
		file delete -force $DESIGN_LIBRARY
	}

	set create_lib_cmd "create_lib $DESIGN_LIBRARY"

	if {[file exists [which $TECH_FILE]]} {
		lappend create_lib_cmd -tech $TECH_FILE ;# recommended
	} elseif {$TECH_LIB != ""} {
		lappend create_lib_cmd -use_technology_lib $TECH_LIB ;# optional
	}

	if {$DESIGN_LIBRARY_SCALE_FACTOR != ""} {
		lappend create_lib_cmd -scale_factor $DESIGN_LIBRARY_SCALE_FACTOR
	}

	## Library configuration flow: calls library manager under the hood to generate .nlibs, store, and link them
	#  - To enable it, in design_setup.tcl, set LIBRARY_CONFIGURATION_FLOW to true,
	#    specify LINK_LIBRARY with .db files, and specify REFERENCE_LIBRARY with physical source files. 
	#    In fc_setup.tcl, make sure search_path includes all relevant locations. 
	if {$LIBRARY_CONFIGURATION_FLOW} {
		set link_library $LINK_LIBRARY
	}

	lappend create_lib_cmd -ref_libs $REFERENCE_LIBRARY

	puts "RM-info: $create_lib_cmd"
	eval ${create_lib_cmd}

########################################################################
## Design creation
########################################################################

  #################################################################################
  ## Read in the RTL design
  #################################################################################

  set_svf ${OUTPUTS_DIR}/${INIT_DESIGN_BLOCK_NAME}.svf
  rm_source -file read_rtl.tcl

  if {$EARLY_DATA_CHECK_POLICY != "none"} {
	## Design check manager
	set_early_data_check_policy -policy $EARLY_DATA_CHECK_POLICY -if_not_exist
  }

  #################################################################################
  ## OR Read in the elaborated design from the same release
  #################################################################################

  # copy_block -from elaborated_${DESIGN_LIBRARY}:${DESIGN_NAME}/${READ_RTL_BLOCK_NAME} -to ${DESIGN_LIBRARY}:${DESIGN_NAME}
  # close_lib elaborated_${DESIGN_LIBRARY}
  # current_block ${DESIGN_LIBRARY}:${DESIGN_NAME}
  # link_block

  ####################################
  ## Save elaborated design
  ####################################

  save_block -as ${DESIGN_NAME}/${READ_RTL_BLOCK_NAME}

  # if {[file exists elaborated_${DESIGN_LIBRARY}]} { file delete -force elaborated_${DESIGN_LIBRARY} }
  # copy_lib -to elaborated_${DESIGN_LIBRARY} -no_designs
  # copy_block -from ${DESIGN_NAME}/${READ_RTL_BLOCK_NAME} -to elaborated_${DESIGN_LIBRARY}:${DESIGN_NAME}/${READ_RTL_BLOCK_NAME}
  # save_lib elaborated_${DESIGN_LIBRARY}
  # close_lib elaborated_${DESIGN_LIBRARY}

  ####################################
  ## Design mismatch reports
  ####################################			 

  redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_design.design_mismatch \
    { check_design -ems_database check_design.design_mismatch.ems -checks design_mismatch }

  redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_design_mismatch \
    { report_design_mismatch -verbose }

  redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_unbound \
    { report_unbound }

  ###################################
  ## start SAIF mapping database
  ###################################

  saif_map -start

  ###################################
  ## DFT Ports
  ###################################

  # Create DFT ports if necessary
  rm_source -file $TCL_DFT_PORTS_FILE -optional -print "TCL_DFT_PORTS_FILE"

  rm_source -file $TCL_USER_CREATE_DFT_PORTS_POST_SCRIPT -optional -print "TCL_USER_CREATE_DFT_PORTS_POST_SCRIPT"

  ################################################################
  ## Read and commit the UPF file(s)  
  ################################################################
  if {$UPF_MODE == "golden"} {
	set_app_options -name mv.upf.enable_golden_upf -value true ;# tool default false
  }

  if {$UPF_MODE != "none"} {
	if {[file exists [which $UPF_FILE]]} {
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
  }


  ################################################################
  ## Floorplanning  
  ################################################################

	####################################
	## Floorplanning : technology setup 
	####################################
	## Technology setup includes routing layer direction, offset, site default, and site symmetry
	#  - If TECH_FILE is used, technology setup is required 
	#  - If TECH_LIB is used and it does not contain the technology setup, then it is required
	#  Specify your technology setup script through TCL_TECH_SETUP_FILE. RM default is init_design.tech_setup.tcl.
	if {$TECH_FILE != "" || ($TECH_LIB != "" && !$TECH_LIB_INCLUDES_TECH_SETUP_INFO)} {
		rm_source -file $TCL_TECH_SETUP_FILE -optional -print "TCL_TECH_SETUP_FILE"
	}

	# Ruled based query may be required to read the floorplan files
	# Modify set_query_rules if other characters are used for hierarchy separators
	# or bus names.
	# set_query_rules
	# This should be turned off after the constraint read in order to minimize runtime.
	# set_app_options -name design.enable_rule_based_query -value true
	# set_app_options -name design.enable_rule_based_query -value false

	####################################
	## Floorplanning : from DEF 
	####################################
	## Floorplanning by reading $DEF_FLOORPLAN_FILES (supports multiple DEF files)
	#  Script first checks if all the specified DEF files are valid, if not, read_def is skipped
	if {$DEF_FLOORPLAN_FILES != ""} {
		set RM_DEF_FLOORPLAN_FILE_is_not_found FALSE
		foreach def_file $DEF_FLOORPLAN_FILES {
	      		if {![file exists [which $def_file]]} {
	      			puts "RM-error : DEF floorplan file ($def_file) is invalid."
	      			set RM_DEF_FLOORPLAN_FILE_is_not_found TRUE
	      		}
		}

	      	if {!$RM_DEF_FLOORPLAN_FILE_is_not_found} {
			set read_def_cmd "read_def $DEF_READ_OPTIONS [list $DEF_FLOORPLAN_FILES]" ;## HPC
	      		#set read_def_cmd "read_def -add_def_only_objects $DEF_OBJECTS_TO_ADD [list $DEF_FLOORPLAN_FILES]" 
	      		#if {$DEF_SITE_NAME_PAIRS != ""} {lappend read_def_cmd -convert $DEF_SITE_NAME_PAIRS}
	      		puts "RM-info: Creating floorplan from DEF file DEF_FLOORPLAN_FILES ($DEF_FLOORPLAN_FILES)"
			puts "RM-info: $read_def_cmd"
	      		eval ${read_def_cmd}

			redirect -var x {catch {resolve_pg_nets}} ;# workaround in case resolve_pg_nets returns warning that causes conditional to exit unexpectedly 
			puts $x
			if {[regexp ".*NDMUI-096.*" $x]} {
				puts "RM-error: UPF may have an issue. Please review and correct it."
			}

	      	} else {
	      		puts "RM-error : At least one of the DEF_FLOORPLAN_FILES specified is invalid. Please correct it."
	      		puts "RM-info: Skipped reading of DEF_FLOORPLAN_FILES"
	      	}
	}

	####################################
	## Floorplanning : from write_floorplan 
	####################################
	## Floorplanning by reading the write_floorplan generated TCL file, $TCL_FLOORPLAN_FILE
	if {$DEF_FLOORPLAN_FILES == "" && $TCL_FLOORPLAN_FILE != ""} {
		rm_source -file $TCL_FLOORPLAN_FILE
	}

	####################################
	## Floorplanning : initialize_floorplan
	#################################### 
	## Configure autofloorplan if neither DEF_FLOORPLAN_FILES nor TCL_FLOORPLAN_FILE is specified
	if {$DEF_FLOORPLAN_FILES == "" && $TCL_FLOORPLAN_FILE == ""} {
	      	puts "RM-info: floorplan will be automatically created during compile"
                # set_auto_floorplan_constraints
	}

	################################################################
	## Additional floorplan constraints  
	################################################################
	#  If DEF_FLOORPLAN_FILES is provided but can not cover certain floorplan constraint types, then they can be provided here.
	#  If initialize_floorplan is used, additional floorplan constraints can be provided here. 
	#  For example, bounds, pin guides, or route guides, etc
	rm_source -file $TCL_ADDITIONAL_FLOORPLAN_FILE -optional -print "TCL_ADDITIONAL_FLOORPLAN_FILE"

	## IO, and macro placement: Refer to examples/init_design.flat_design_planning_example.tcl for sample commands

  ###################################
  ## Design Constraints
  ###################################

  # Puts design constraints such as dont_touch, size_only, clock-gating settings, ... in this file
  rm_source -file $TCL_CONSTRAINTS_SETUP_FILE -optional -print "TCL_CONSTRAINTS_SETUP_FILE"

  ################################################################
  ## Timing constraints  
  ################################################################
  ## Specify a Tcl script to read in your TLU+ files by using the read_parasitic_tech command;
  #  Refer to examples/TCL_PARASITIC_SETUP_FILE.tcl for sample commands
  rm_source -file $TCL_PARASITIC_SETUP_FILE -optional -print "TCL_PARASITIC_SETUP_FILE"

  ## Specify a Tcl script to create your corners, modes, scenarios and load respective constraints;
  #  Two examples are provided: 
  #  - examples/TCL_MCMM_SETUP_FILE.explicit.tcl: provide mode, corner, and scenario constraints; create modes, corners, 
  #    and scenarios; source mode, corner, and scenario constraints, respectively 
  #  - examples/TCL_MCMM_SETUP_FILE.auto_expanded.tcl: provide constraints for the scenarios; create modes, corners, 
  #    and scenarios; source scenario constraints which are then expanded to associated modes and corners
  rm_source -file $TCL_MCMM_SETUP_FILE -optional -print "TCL_MCMM_SETUP_FILE"


