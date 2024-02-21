##########################################################################################
# Script: endpoint_opt.tcl for route_opt PBA-CCD targeted optimization
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
rm_source -file ./rm_setup/design_setup.tcl
rm_source -file ./rm_setup/fc_setup.tcl
rm_source -file ./rm_setup/header_fc.tcl
if {$HPC_CORE != ""} {rm_source -file ./inputs/plugin/hpc_vars.tcl}

set REPORT_PREFIX $ENDPOINT_OPT_BLOCK_NAME
set REPORTS_DIR $REPORTS_DIR/$REPORT_PREFIX; file mkdir $REPORTS_DIR
set_svf ${OUTPUTS_DIR}/${ENDPOINT_OPT_BLOCK_NAME}.svf 

open_lib $DESIGN_LIBRARY
copy_block -from ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME} -to ${DESIGN_NAME}/${ENDPOINT_OPT_BLOCK_NAME}
current_block ${DESIGN_NAME}/${ENDPOINT_OPT_BLOCK_NAME}
link_block

if {$ENDPOINT_OPT_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $ENDPOINT_OPT_ACTIVE_SCENARIO_LIST
}

## Non-persistent settings to be applied in each step (optional)
rm_source -file $TCL_USER_NON_PERSISTENT_SCRIPT -optional -print "TCL_USER_NON_PERSISTENT_SCRIPT"

##########################################################################################
## Settings
##########################################################################################
## Prefix
set_app_options -name opt.common.user_instance_name_prefix -value endpoint_opt_
set_app_options -name cts.common.user_instance_name_prefix -value endpoint_opt_cts_

## For set_qor_strategy -metric leakage, disabling the dynamic power analysis in active scenarios for optimization
# Scenario power analysis will be renabled after optimization for reporting
if {$SET_QOR_STRATEGY_METRIC == "leakage_power"} {
   set rm_dynamic_scenarios [get_object_name [get_scenarios -filter active==true&&dynamic_power==true]]

   if {[llength $rm_dynamic_scenarios] > 0} {
      puts "RM-info: Disabling dynamic analysis for $rm_dynamic_scenarios"
      set_scenario_status -dynamic_power false [get_scenarios $rm_dynamic_scenarios]
  }
}

##########################################################################################
## Pre-command customizations
##########################################################################################
rm_source -file $TCL_USER_ENDPOINT_OPT_PRE_SCRIPT -optional -print "TCL_USER_ENDPOINT_OPT_PRE_SCRIPT"

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_app_options.start {report_app_options -non_default *}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_lib_cell_purpose {report_lib_cell -objects [get_lib_cells] -column {full_name:20 valid_purposes}}

redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor.start {report_qor -scenarios [all_scenarios] -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
redirect -append -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor.start {report_qor -summary -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_global_timing.start {report_global_timing -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}

set check_stage_settings_cmd "check_stage_settings -stage pnr -metric \"${SET_QOR_STRATEGY_METRIC}\" -step post_route"
if {$ENABLE_REDUCED_EFFORT} {lappend check_stage_settings_cmd -reduced_effort}
if {$RESET_CHECK_STAGE_SETTINGS} {lappend check_stage_settings_cmd -reset_app_options}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_stage_settings {eval ${check_stage_settings_cmd}}

#########################################################################################
## PBA-CCD targeted optimization
##########################################################################################
## Prerequisites : already done with RM's 3 route_opt flow : 1st CCD route_opt, 2nd route_opt with PBA enabled; 3rd size-only route_opt
## Run PBA-CCD skewing and datapath opto on selected end points for controlling optimization for last mile Fmax push

if {![rm_source -file $TCL_USER_ENDPOINT_OPT_SCRIPT -optional -print "TCL_USER_ENDPOINT_OPT_SCRIPT"]} {
## Note : The following executes if TCL_USER_ENDPOINT_OPT_SCRIPT is not sourced
	set targeted_ep_ropt_pba_ccd_cmd "targeted_ep_ropt_pba_ccd -max_paths $ENDPOINT_OPT_MAX_PATHS -slack_lesser_than $ENDPOINT_OPT_SLACK_THRESHOLD -scenarios \"$ENDPOINT_OPT_TARGET_SCENARIOS\""
	if {$ENDPOINT_OPT_PATH_GROUP_FILTER != ""} {
		lappend targeted_ep_ropt_pba_ccd_cmd -path_group_filter $ENDPOINT_OPT_PATH_GROUP_FILTER
	}

	for {set i 1} {$i < [expr $ENDPOINT_OPT_LOOP + 1]} {incr i} {
		puts "RM-info: Running $targeted_ep_ropt_pba_ccd_cmd #${i}"
		eval $targeted_ep_ropt_pba_ccd_cmd
		puts "RM-info: Completed $targeted_ep_ropt_pba_ccd_cmd #${i}"
		if {$ENDPOINT_OPT_LOOP > 1} {save_block -as ${DESIGN_NAME}/${ENDPOINT_OPT_BLOCK_NAME}_${i}}
	}
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
}

##########################################################################################
## Post-command customizations
##########################################################################################
rm_source -file $TCL_USER_ENDPOINT_OPT_POST_SCRIPT -optional -print "TCL_USER_ENDPOINT_OPT_POST_SCRIPT" 

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

## Re-enable power analysis if disabled for set_qor_strategy -metric timing
if {[info exists rm_dynamic_scenarios] && [llength $rm_dynamic_scenarios] > 0} {
   puts "RM-info: Reenabling dynamic power analysis for $rm_dynamic_scenarios"
   set_scenario_status -dynamic_power true [get_scenarios $rm_dynamic_scenarios]
}

save_block

##########################################################################################
## Report and output
##########################################################################################
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
echo [date] > endpoint_opt

exit 

