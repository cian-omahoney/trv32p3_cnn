##########################################################################################
# Script: route_auto.tcl
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
rm_source -file ./rm_setup/design_setup.tcl
rm_source -file ./rm_setup/fc_setup.tcl
rm_source -file ./rm_setup/header_fc.tcl
if {$HPC_CORE != ""} {rm_source -file ./inputs/plugin/hpc_vars.tcl}

set REPORT_PREFIX $ROUTE_AUTO_BLOCK_NAME
set REPORTS_DIR $REPORTS_DIR/$REPORT_PREFIX; file mkdir $REPORTS_DIR
set_svf ${OUTPUTS_DIR}/${ROUTE_AUTO_BLOCK_NAME}.svf 

open_lib $DESIGN_LIBRARY
copy_block -from ${DESIGN_NAME}/${CLOCK_OPT_OPTO_BLOCK_NAME} -to ${DESIGN_NAME}/${ROUTE_AUTO_BLOCK_NAME}
current_block ${DESIGN_NAME}/${ROUTE_AUTO_BLOCK_NAME}
link_block

if {$ROUTE_AUTO_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $ROUTE_AUTO_ACTIVE_SCENARIO_LIST
}


## Non-persistent settings to be applied in each step (optional)
rm_source -file $TCL_USER_NON_PERSISTENT_SCRIPT -optional -print "TCL_USER_NON_PERSISTENT_SCRIPT"

##########################################################################################
## Settings
##########################################################################################
## set_stage : a command to apply stage-based application options; intended to be used after set_qor_strategy within RM scripts.
set_stage -step route

## HPC_CORE specific
if {$HPC_CORE != "" } {
	set HPC_STAGE route_auto
	puts "RM-info: HPC_CORE is being set to $HPC_CORE; Loading HPC settings"
	set_hpc_options -core $HPC_CORE -stage $HPC_STAGE
	rm_source -file $HPC_STAGE_SETTING_FILE
}

## Prefix
set_app_options -name opt.common.user_instance_name_prefix -value route_auto_

##########################################################################################
## Pre-route_auto customizations
##########################################################################################
rm_source -file $TCL_USER_ROUTE_AUTO_PRE_SCRIPT -optional -print "TCL_USER_ROUTE_AUTO_PRE_SCRIPT"

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_app_options.start {report_app_options -non_default *}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_lib_cell_purpose {report_lib_cell -objects [get_lib_cells] -column {full_name:20 valid_purposes}}

redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor.start {report_qor -scenarios [all_scenarios] -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
redirect -append -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor.start {report_qor -summary -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_global_timing.start {report_global_timing -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}

set check_stage_settings_cmd "check_stage_settings -stage pnr -metric \"${SET_QOR_STRATEGY_METRIC}\" -step route"
if {$ENABLE_REDUCED_EFFORT} {lappend check_stage_settings_cmd -reduced_effort}
if {$RESET_CHECK_STAGE_SETTINGS} {lappend check_stage_settings_cmd -reset_app_options}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_stage_settings {eval ${check_stage_settings_cmd}}


##########################################################################################
## Routing flow
##########################################################################################
if {![rm_source -file $TCL_USER_ROUTE_AUTO_SCRIPT -optional -print "TCL_USER_ROUTE_AUTO_SCRIPT"]} {
# Note : The following executes if TCL_USER_ROUTE_AUTO_SCRIPT is not sourced

	##########################################################################
	## Routing with single command : route_auto (default)
	##########################################################################
	## Note: GR phase will be skipped if global route optimization was done
	puts "RM-info: Running route_auto"
	route_auto

}

## Redundant via insertion
if {$ENABLE_REDUNDANT_VIA_INSERTION} {
	add_redundant_vias
}

## Fix remaining routing DRCs
#route_detail -incremental true -initial_drc_from_input true

## Create shields
if {$ENABLE_CREATE_SHIELDS} {
	if {$CREATE_SHIELDS_GROUND_NET != ""} {
		create_shields -shielding_mode reshield -with_ground $CREATE_SHIELDS_GROUND_NET
	} else {
		create_shields -shielding_mode reshield
	}
	set_extraction_options -virtual_shield_extraction false
}

##########################################################################################
## Post-route_auto customizations
##########################################################################################
rm_source -file $TCL_USER_ROUTE_AUTO_POST_SCRIPT -optional -print "TCL_USER_ROUTE_AUTO_POST_SCRIPT"

##########################################################################################
## connect_pg_net
##########################################################################################
if {![rm_source -file $TCL_USER_CONNECT_PG_NET_SCRIPT -optional -print "TCL_USER_CONNECT_PG_NET_SCRIPT"]} {
## Note : the following executes if TCL_USER_CONNECT_PG_NET_SCRIPT is not sourced
	connect_pg_net
        # For non-MV designs with more than one PG, you should use connect_pg_net in manual mode.
}

## Run check_routes to save updated routing DRC to the block
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_routes {check_routes}

save_block

## StarRC in-design extraction (optional) : a config file is required to set up a proper StarRC run
if {[file exists [which $ROUTE_OPT_STARRC_CONFIG_FILE]]} {
	set_starrc_in_design -config $ROUTE_OPT_STARRC_CONFIG_FILE
} elseif {$ROUTE_OPT_STARRC_CONFIG_FILE != ""} {
	puts "RM-error: ROUTE_OPT_STARRC_CONFIG_FILE($ROUTE_OPT_STARRC_CONFIG_FILE) is invalid. Please correct it."
}

## StarRC in-design extraction validation flow
## Discover potential setup issues of StarRC in-design extraction
## Low effort performs setup checks for config file path, StarRC path, layer mapping file path, and corner mapping;
## medium effort creates StarRC command file in your local dir; high effort invokes StarRC. 
#	check_starrc_in_design -effort <low|medium|high>

##########################################################################################
## Report and output
##########################################################################################
## Recommended timing settings for reporting on routed designs (AWP, CCS receiver, and SI timing window)
puts "RM-info: Setting time.delay_calc_waveform_analysis_mode to full_design and time.enable_ccs_rcv_cap to true for reporting"
set_app_options -name time.delay_calc_waveform_analysis_mode -value full_design ;# tool default disabled; enables AWP
set_app_options -name time.enable_ccs_rcv_cap -value true ;# tool default false; enables CCS receiver model; required

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

print_message_info -ids * -summary
echo [date] > route_auto

exit 

