##########################################################################################
# Script: icv_in_design.tcl
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
rm_source -file ./rm_setup/design_setup.tcl
rm_source -file ./rm_setup/fc_setup.tcl
rm_source -file ./rm_setup/header_fc.tcl
if {$HPC_CORE != ""} {rm_source -file ./inputs/plugin/hpc_vars.tcl}

set REPORT_PREFIX $ICV_IN_DESIGN_BLOCK_NAME
set REPORTS_DIR $REPORTS_DIR/$REPORT_PREFIX; file mkdir $REPORTS_DIR

open_lib $DESIGN_LIBRARY
copy_block -from ${DESIGN_NAME}/${ICV_IN_DESIGN_FROM_BLOCK_NAME} -to ${DESIGN_NAME}/${ICV_IN_DESIGN_BLOCK_NAME}
current_block ${DESIGN_NAME}/${ICV_IN_DESIGN_BLOCK_NAME}
link_block

if {$ICV_IN_DESIGN_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $ICV_IN_DESIGN_ACTIVE_SCENARIO_LIST
}
## Non-persistent settings to be applied in each step (optional)
rm_source -file $TCL_USER_NON_PERSISTENT_SCRIPT -optional -print "TCL_USER_NON_PERSISTENT_SCRIPT"

########################################################################
## Pre In-design ICV customizations
########################################################################
rm_source -file $TCL_USER_ICV_IN_DESIGN_PRE_SCRIPT -optional -print "TCL_USER_ICV_IN_DESIGN_PRE_SCRIPT"

####################################
## report_app_options & report_lib_cell_purpose	
####################################
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_app_options.start {report_app_options -non_default *}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_lib_cell_purpose {report_lib_cell -objects [get_lib_cells] -column {full_name:20 valid_purposes}}

redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor.start {report_qor -scenarios [all_scenarios] -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
redirect -append -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor.start {report_qor -summary -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_global_timing.start {report_global_timing -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}

## Verify that the DRC runset is properly setup.
if {$ICV_IN_DESIGN_DRC} {
	## Runset for signoff_check_drc
	if {[file exists [which $ICV_IN_DESIGN_DRC_CHECK_RUNSET]]} {
		puts "RM-info: Setting signoff.check_drc.runset to [which $ICV_IN_DESIGN_DRC_CHECK_RUNSET]"
		set_app_options -name signoff.check_drc.runset -value $ICV_IN_DESIGN_DRC_CHECK_RUNSET
	} else {
		puts "RM-error: ICV_IN_DESIGN_DRC_CHECK_RUNSET($ICV_IN_DESIGN_DRC_CHECK_RUNSET) is invalid. Please correct it."

                exit

	}
}
## Verify that the metal fill runset is properly setup.
if {$ICV_IN_DESIGN_METAL_FILL} {
	if {$ICV_IN_DESIGN_METAL_FILL_TRACK_BASED == "off"} {
		##  A valid runset is required for non track-based metal fill. Specify runset for signoff_create_metal_fill
		if {[file exists [which $ICV_IN_DESIGN_METAL_FILL_RUNSET]]} {
			puts "RM-info: Setting signoff.create_metal_fill.runset to [which $ICV_IN_DESIGN_METAL_FILL_RUNSET]"
			set_app_options -name signoff.create_metal_fill.runset -value $ICV_IN_DESIGN_METAL_FILL_RUNSET
		} else {
			puts "RM-error: ICV_IN_DESIGN_METAL_FILL_RUNSET($ICV_IN_DESIGN_METAL_FILL_RUNSET) is invalid. Please correct it."

                	exit

		}
	}
}

## The following options are applicable to both signoff_check_drc and signoff_create_metal_fill.
if {$WRITE_GDS_LAYER_MAP_FILE != ""} {
	set_app_options -name signoff.physical.layer_map_file -value $WRITE_GDS_LAYER_MAP_FILE
} elseif {$WRITE_OASIS_LAYER_MAP_FILE != ""} {
	set_app_options -name signoff.physical.layer_map_file -value $WRITE_OASIS_LAYER_MAP_FILE
} else {
	puts "RM-warning: The layer mapping file is needed to map to GDS/OASIS layers (i.e.WRITE_GDS_LAYER_MAP_FILE/WRITE_OASIS_LAYER_MAP_FILE)"
}
set_app_options -name signoff.physical.merge_stream_files -value $STREAM_FILES_FOR_MERGE ;# Specify stream files for merge
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_app_options.signoff.physical.rpt {report_app_options signoff.physical.*} ;# Report signoff.physical application options

save_block ;# Save to disk is required as ICV reads from disk file instead of memory

########################################################################
## signoff_check_drc and signoff_fix_drc
########################################################################

if {$ICV_IN_DESIGN_DRC} {

	########################################################################
	## signoff_check_drc
	########################################################################
	set_app_options -name signoff.check_drc.run_dir -value $ICV_IN_DESIGN_DRC_CHECK_RUNDIR ;# RM default z_check_drc
	set_app_options -name signoff.check_drc.excluded_cell_types -value $ICV_IN_DESIGN_DRC_EXCLUDED_CELL_TYPES ;# Specify include excluded cell types	
	set_app_options -name signoff.check_drc.ignore_child_cell_errors -value $ICV_IN_DESIGN_DRC_IGNORE_CHILD_CELL_ERRORS ;# Specify child cells to ignore
        if { $ICV_IN_DESIGN_DRC_USER_DEFINED_OPTIONS != "" } {
		set_app_options -name signoff.check_drc.user_defined_options -value $ICV_IN_DESIGN_DRC_USER_DEFINED_OPTIONS ;# Specify user defined options
	}
	set_app_options -name signoff.check_drc.fill_view_data -value $ICV_IN_DESIGN_DRC_FILL_VIEW_DATA

	## Specify which views are read.
	if {$ICV_IN_DESIGN_DRC_CELL_VIEWS == "layout"} {
		set_app_options -name signoff.check_drc.read_layout_views -value {*}
	} elseif {$ICV_IN_DESIGN_DRC_CELL_VIEWS == "design"}  {
		set_app_options -name signoff.check_drc.read_design_views -value {*}
	} else {
		puts "RM-info: Frame views will be read in for analysis."
		reset_app_options signoff.check_drc.read_layout_views
		reset_app_options signoff.check_drc.read_design_views
	}

	redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_app_options.signoff.check_drc.rpt {report_app_options signoff.check_drc.*} ;# Report signoff.check_drc application options

	# Run signoff_check_drc
	set signoff_check_drc_cmd "signoff_check_drc"
	if {$ICV_IN_DESIGN_DRC_SELECT_RULES != ""} {
		lappend signoff_check_drc_cmd -select_rule $ICV_IN_DESIGN_DRC_SELECT_RULES
	}
	if {$ICV_IN_DESIGN_DRC_UNSELECT_RULES != ""} {
		lappend signoff_check_drc_cmd -unselect_rule $ICV_IN_DESIGN_DRC_UNSELECT_RULES
	}

	puts "RM-info: Running $signoff_check_drc_cmd"
	eval ${signoff_check_drc_cmd}

	## Note: Ideally results from signoff_check_drc should be reviewed and corrective action
	#  taken on appropriate app.options before invoking signoff_fix_drc.
	#  Note that signoff.fix_drc.max_errors_per_rule defaults at 1000. If more than 1000 DRC violations
	#  are reported of a specific type, this error type will be excluded from fixing. This condition
	#  may indicate that there is some other issue with the design.

	if {$ICV_IN_DESIGN_ADR} {

		########################################################################
		## signoff_fix_drc (controlled by ICV_IN_DESIGN_ADR, default true)
		########################################################################
		#  Specify valid ICV_IN_DESIGN_ADR_DPT_RULES if you want signoff_fix_drc to be used for DPT rules fixing
		#  Review the signoff_fix_drc/result_summary.rpt for complete details of signoff_fix_drc

		set_app_options -name signoff.fix_drc.user_defined_options -value $ICV_IN_DESIGN_ADR_USER_DEFINED_OPTIONS ;# Specify user defined options

		########################################################################
		## signoff_fix_drc for non-DPT
		########################################################################
		set_app_options -name signoff.fix_drc.init_drc_error_db -value $ICV_IN_DESIGN_DRC_CHECK_RUNDIR ;# RM default z_check_drc
		set_app_options -name signoff.fix_drc.run_dir -value $ICV_IN_DESIGN_ADR_RUNDIR ;# RM default z_adr
		set_app_options -name signoff.fix_drc.custom_guidance -value off

		## signoff_drc_check after fixing
		if {$ICV_IN_DESIGN_ADR_DPT_RULES != ""} {
			signoff_fix_drc -unselect_rules $ICV_IN_DESIGN_ADR_DPT_RULES
		} else {
			signoff_fix_drc
		}
		save_block

		set_app_options -name signoff.check_drc.run_dir -value $ICV_IN_DESIGN_POST_ADR_RUNDIR ;# RM default z_post_adr
		puts "RM-info: Running $signoff_check_drc_cmd"
		eval ${signoff_check_drc_cmd}

		########################################################################
		## signoff_fix_drc for DPT
		########################################################################
		if {$ICV_IN_DESIGN_ADR_DPT_RULES != ""} {
			set_app_options -name signoff.fix_drc.init_drc_error_db -value $ICV_IN_DESIGN_POST_ADR_RUNDIR ;# RM default z_post_adr
			set_app_options -name signoff.fix_drc.run_dir -value $ICV_IN_DESIGN_ADR_DPT_RUNDIR ;# RM default z_adr_with_dpt
			set_app_options -name signoff.fix_drc.custom_guidance -value dpt

			signoff_fix_drc -select_rules $ICV_IN_DESIGN_ADR_DPT_RULES
			save_block

			## signoff_drc_check after DPT fixing
			set_app_options -name signoff.check_drc.run_dir -value $ICV_IN_DESIGN_POST_ADR_DPT_RUNDIR ;# RM default z_post_adr_with_dpt
			puts "RM-info: Running $signoff_check_drc_cmd"
			eval ${signoff_check_drc_cmd}

			set_app_options -name signoff.fix_drc.custom_guidance -value off
		}
	}
}

####################################
## signoff_create_metal_fill
####################################
if {$ICV_IN_DESIGN_METAL_FILL} {

	if {$ICV_IN_DESIGN_METAL_FILL_RUNDIR != ""} {
		puts "RM-info: Setting signoff.create_metal_fill.run_dir to $ICV_IN_DESIGN_METAL_FILL_RUNDIR"
		set_app_options -name signoff.create_metal_fill.run_dir -value $ICV_IN_DESIGN_METAL_FILL_RUNDIR
	}
	set_app_options -name signoff.create_metal_fill.user_defined_options -value $ICV_IN_DESIGN_METAL_FILL_USER_DEFINED_OPTIONS ;# Specify user defined options
	set_app_options -name signoff.create_metal_fill.fix_density_errors -value $ICV_IN_DESIGN_METAL_FILL_FIX_DENSITY_ERRORS

	if {$ICV_IN_DESIGN_METAL_FILL_TRACK_BASED == "off"} {

		## Non track-based metal fill setup
		set create_metal_fill_cmd "signoff_create_metal_fill"
	} else {

		## Track-based metal fill setup

		## For track-based metal fill creation, it is recommended to specify foundry node for -track_fill in order to use -fill_all_track
		if {$ICV_IN_DESIGN_METAL_FILL_TRACK_BASED != "generic"} {
			set create_metal_fill_cmd "signoff_create_metal_fill -track_fill $ICV_IN_DESIGN_METAL_FILL_TRACK_BASED -fill_all_tracks true"
		} else {
			set create_metal_fill_cmd "signoff_create_metal_fill -track_fill $ICV_IN_DESIGN_METAL_FILL_TRACK_BASED"
		}

		## Track-based metal fill creation: optionally specify a ICV_IN_DESIGN_METAL_FILL_TRACK_BASED_PARAMETER_FILE  
		if {$ICV_IN_DESIGN_METAL_FILL_TRACK_BASED_PARAMETER_FILE != "auto" && [file exists [which $ICV_IN_DESIGN_METAL_FILL_TRACK_BASED_PARAMETER_FILE]]} {
			lappend create_metal_fill_cmd -track_fill_parameter_file $ICV_IN_DESIGN_METAL_FILL_TRACK_BASED_PARAMETER_FILE
		}
	}

	## Timing-driven
	if {$ICV_IN_DESIGN_METAL_FILL_TIMING_DRIVEN_THRESHOLD != ""} {
		lappend create_metal_fill_cmd -timing_preserve_setup_slack_threshold $ICV_IN_DESIGN_METAL_FILL_TIMING_DRIVEN_THRESHOLD

		# Extraction options
		set_extraction_options -real_metalfill_extraction none

		# Optional app options to block fill creation on critical nets. Below are examples.
		# 	set_app_options -name signoff.create_metal_fill.space_to_nets -value {{M1 4x} {M2 4x} ...}
		# 	set_app_options -name signoff.create_metal_fill.space_to_clock_nets -value {{M1 5x} {M2 5x} ...}
		# 	set_app_options -name signoff.create_metal_fill.space_to_nets_on_adjacent_layer -value {{M1 3x} {M2 3x} ...}
		# 	set_app_options -name signoff.create_metal_fill.fix_density_error -value true
		# 	set_app_options -name signoff.create_metal_fill.apply_nondefault_rules -value true
	}

	if {$ICV_IN_DESIGN_METAL_FILL_SELECT_LAYERS != ""} {
		lappend create_metal_fill_cmd -select_layers $ICV_IN_DESIGN_METAL_FILL_SELECT_LAYERS
	}

	redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_app_options.signoff.create_metal_fill.rpt {report_app_options signoff.create_metal_fill.*} ;# Report signoff.create_metal_fill application options

	puts "RM-info: Running $create_metal_fill_cmd"
	eval $create_metal_fill_cmd

	if {$ICV_IN_DESIGN_DRC} {
		set_app_options -name signoff.check_drc.run_dir -value $ICV_IN_DESIGN_POST_METAL_FILL_RUNDIR ;# RM default z_MFILL_after
		puts "RM-info: Running $signoff_check_drc_cmd"
		eval $signoff_check_drc_cmd

	} else {
		puts "RM-info: The signoff_check_drc command after signoff_create_metal_fill is skipped."
	}

	set_extraction_options -real_metalfill_extraction floating
}

####################################
## Post In-design ICV customizations
####################################
rm_source -file $TCL_USER_ICV_IN_DESIGN_POST_SCRIPT -optional -print "TCL_USER_ICV_IN_DESIGN_POST_SCRIPT"

####################################
## Report and output
####################################
if {$REPORT_QOR} {
	if {$REPORT_PARALLEL_SUBMIT_COMMAND != ""} {
		## Generate a file to pass necessary RM variables for running report_qor.tcl to the report_parallel command
		rm_generate_variables_for_report_parallel -work_directory ${REPORTS_DIR} -file_name rm_tcl_var.tcl

		## Parallel reporting using the report_parallel command (requires a valid REPORT_PARALLEL_SUBMIT_COMMAND)
		report_parallel -work_directory ${REPORTS_DIR} -submit_command ${REPORT_PARALLEL_SUBMIT_COMMAND} -max_cores ${REPORT_PARALLEL_MAX_CORES} -user_scripts [list "${REPORTS_DIR}/rm_tcl_var.tcl" "[which report_qor.tcl]"]
	} else {
		## Classic reporting
		rm_source -file report_qor.tcl
	}
}

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_routes {check_routes}

print_message_info -ids * -summary
echo [date] > icv_in_design

exit 

