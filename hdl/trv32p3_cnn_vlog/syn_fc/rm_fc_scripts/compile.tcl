##########################################################################################
# Tool: Fusion Compiler
# Script: compile.tcl
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
rm_source -file ./rm_setup/design_setup.tcl
rm_source -file ./rm_setup/fc_setup.tcl
rm_source -file ./rm_setup/header_fc.tcl
if {$HPC_CORE != ""} {rm_source -file ./inputs/plugin/hpc_vars.tcl}

set REPORT_PREFIX ${COMPILE_BLOCK_NAME}
set REPORTS_DIR $REPORTS_DIR/$REPORT_PREFIX; file mkdir $REPORTS_DIR
set_svf ${OUTPUTS_DIR}/${COMPILE_BLOCK_NAME}.svf

open_lib ${DESIGN_LIBRARY}
copy_block -from ${DESIGN_NAME}/${INIT_DESIGN_BLOCK_NAME} -to ${DESIGN_NAME}/${COMPILE_BLOCK_NAME}
current_block ${DESIGN_NAME}/${COMPILE_BLOCK_NAME}

if {$EARLY_DATA_CHECK_POLICY != "none"} {
	## Design check manager
	set_early_data_check_policy -policy $EARLY_DATA_CHECK_POLICY -if_not_exist
}

link_block


## Set active scenarios for the step (please include CTS and hold scenarios for CCD) ;
if {$COMPILE_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $COMPILE_ACTIVE_SCENARIO_LIST
}

if {[sizeof_collection [get_scenarios -filter "hold && active"]] == 0} {
	puts "RM-warning: No active hold scenario is found. Recommended to enable hold scenarios here such that CCD skewing can consider them." 
	puts "RM-info: Please activate hold scenarios for compile_fusion if they are available." 
}



## Non-persistent settings to be applied in each step (optional)
rm_source -file $TCL_USER_NON_PERSISTENT_SCRIPT -optional -print "TCL_USER_NON_PERSISTENT_SCRIPT"

##########################################################################################
## Settings
##########################################################################################

## set_qor_strategy : a commmand which folds various settings of placement, optimization, timing, CTS, and routing, etc.
## - To query the target metric being set, use the "get_attribute [current_design] metric_target" command
set set_qor_strategy_cmd "set_qor_strategy -stage synthesis -metric \"${SET_QOR_STRATEGY_METRIC}\""

if {$ENABLE_REDUCED_EFFORT} {
   lappend set_qor_strategy_cmd -reduced_effort
   puts "RM-info: When reduced_effort is enabled, high effort timing is always disabled"
} elseif {(!$ENABLE_REDUCED_EFFORT && $ENABLE_HIGH_EFFORT_TIMING)} {
   lappend set_qor_strategy_cmd -high_effort_timing
}
puts "RM-info: Running $set_qor_strategy_cmd" 
eval ${set_qor_strategy_cmd}


## set_stage : a command to apply stage-based application options; intended to be used after set_qor_strategy within RM scripts.
set set_stage_cmd "set_stage -step synthesis"
puts "RM-info: Running ${set_stage_cmd}"
eval ${set_stage_cmd}


## HPC_CORE specific
if {$HPC_CORE != "" } {
	set HPC_STAGE compile
	puts "RM-info: HPC_CORE is being set to $HPC_CORE; Loading HPC settings"
	set_hpc_options -core $HPC_CORE -stage $HPC_STAGE
	rm_source -file $HPC_STAGE_SETTING_FILE
}

## Prefix
set_app_options -name opt.common.user_instance_name_prefix -value compile_
set_app_options -name cts.common.user_instance_name_prefix -value compile_cts_

## Routing 
## Set max routing layer
if {$MAX_ROUTING_LAYER != ""} {set_ignored_layers -max_routing_layer $MAX_ROUTING_LAYER}
## Set min routing layer
if {$MIN_ROUTING_LAYER != ""} {set_ignored_layers -min_routing_layer $MIN_ROUTING_LAYER}

## For set_qor_strategy -metric leakage_power, disabling the dynamic power analysis in active scenarios for optimization
# Scenario power analysis will be renabled after optimization for reporting
if {$SET_QOR_STRATEGY_METRIC == "leakage_power"} {
   set rm_dynamic_scenarios [get_object_name [get_scenarios -filter active==true&&dynamic_power==true]]

   if {[llength $rm_dynamic_scenarios] > 0} {
      puts "RM-info: Disabling dynamic analysis for $rm_dynamic_scenarios"
      set_scenario_status -dynamic_power false [get_scenarios $rm_dynamic_scenarios]
  }
}


##########################################################################################
## Additional setup
##########################################################################################
## Create clock NDR - specify TCL_CTS_NDR_RULE_FILE with your script to create and associate your clock NDR rules.
## RM default is ./examples/cts_ndr.tcl which is an RM provided example. Refer to the script for setup and details.
## You need to also specify CTS_NDR_RULE_NAME, CTS_INTERNAL_NDR_RULE_NAME, or CTS_LEAF_NDR_RULE_NAME for it to take effect.
rm_source -file $TCL_CTS_NDR_RULE_FILE -optional -print "TCL_CTS_NDR_RULE_FILE"

## CTS primary corner
## CTS automatically picks a corner with worst delay as the primary corner for its compile stage, 
## which inserts buffers to balance clock delays in all modes of the corner; 
## this setting allows you to manually specify a corner for the tool to use instead
if {$PREROUTE_CTS_PRIMARY_CORNER != ""} {
	puts "RM-info: Setting cts.compile.primary_corner to $PREROUTE_CTS_PRIMARY_CORNER (tool default unspecified)"
	set_app_options -name cts.compile.primary_corner -value $PREROUTE_CTS_PRIMARY_CORNER
}

## Lib cell usage restrictions (set_lib_cell_purpose)
## By default, RM sources set_lib_cell_purpose.tcl for dont use, tie cell, hold fixing, CTS and CTS-exclusive cell restrictions. 
## You can replace it with your own script by specifying the TCL_LIB_CELL_PURPOSE_FILE variable.  
rm_source -file $TCL_LIB_CELL_PURPOSE_FILE -optional -print "TCL_LIB_CELL_PURPOSE_FILE"

## Report NDR and clock settings
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_routing_rules {report_routing_rules -verbose}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_routing_rules {report_clock_routing_rules}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_settings {report_clock_settings}

###########################################################################################
## read_saif 
###########################################################################################
if {$SAIF_FILE_LIST != ""} {
	if {$SAIF_FILE_POWER_SCENARIO != ""} {
		set read_saif_cmd "read_saif \"$SAIF_FILE_LIST\" -scenarios \"$SAIF_FILE_POWER_SCENARIO\""
	} else {
		set read_saif_cmd "read_saif \"$SAIF_FILE_LIST\""
	}
	if {$SAIF_FILE_SOURCE_INSTANCE != ""} {lappend read_saif_cmd -strip_path $SAIF_FILE_SOURCE_INSTANCE}
	if {$SAIF_FILE_TARGET_INSTANCE != ""} {lappend read_saif_cmd -path $SAIF_FILE_TARGET_INSTANCE}
	puts "RM-info: Running $read_saif_cmd"
    	eval ${read_saif_cmd}
}

###########################################################################################
## Pre-compile customizations
###########################################################################################
rm_source -file $TCL_USER_COMPILE_PRE_SCRIPT -optional -print "TCL_USER_COMPILE_PRE_SCRIPT"

##########################################################################################
## DFT Insertion
##########################################################################################

  ##########################################################################################
  ## DFTMAX Compression Configuration (flat flows and bottom-up flows)
  ##########################################################################################

  # For flat flows, make compression specifications in your DFT setup file using the 
  # set_scan_compression_configuration command
  # Then run insert_dft command to insert DFTMAX codec structures before compile.

  # For bottom-up flows, we recommend you only insert scan chains at the block level,
  # and insert a DFTMAX codec at the top level.
  # Be sure to insert a large number of short scan chains at the block level.
  #
  # However if you choose to insert DFTMAX Compression at the block level, then
  # make compression specifications in your DFT setup file using the 
  # set_scan_compression_configuration command
  # and then use DFTMAX Hybrid flow at the top
  # level if you have any uncompressed blocks and want to insert DFTMAX codec
  # at the top level, or choose DFTMAX HASS Integration flow if you do not have
  # any uncompressed blocks and do not want to insert a DFTMAX codec at the top level.

  # For details on DFTMAX Hybrid or HASS Integration flows, please refer to the
  # TestMAX DFT User Guide, Chapter 19, "Hierarchical Adaptive Scan Synthesis"

puts "RM-info: Setting dft.insertion_post_logic_opto to true for in_compile DFT flow"
set_app_options -name dft.insertion_post_logic_opto -value true
## Specify set_scan_element false and set_wrapper_configuration -reuse_threshold commands 
#  prior to compile_fusion -to logic_opto command for an in_compile DFT flow
rm_source -file $TCL_DFT_PRE_IN_COMPILE_SETUP_FILE -optional -print "TCL_DFT_PRE_IN_COMPILE_SETUP_FILE"

##########################################################################################
## Create MV cells
##########################################################################################
# create_mv_cells is optional as MV cells are automatically inserted during compile
# puts "RM-info: Running create_mv_cells"
# create_mv_cells -verbose

##########################################################################################
## Checks
##########################################################################################
puts "RM-info: Running compile_fusion -check_only"
compile_fusion -check_only

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_app_options.start {report_app_options -non_default *}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_lib_cell_purpose {report_lib_cell -objects [get_lib_cells] -column {full_name:20 valid_purposes}}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_activity.driver.start {report_activity -driver}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_variants.start {check_variants -dont_use -included_purposes}

set check_stage_settings_cmd "check_stage_settings -stage synthesis -metric \"${SET_QOR_STRATEGY_METRIC}\" -step synthesis"
if {$ENABLE_REDUCED_EFFORT} {
 lappend check_stage_settings_cmd -reduced_effort
} elseif {(!$ENABLE_REDUCED_EFFORT && $ENABLE_HIGH_EFFORT_TIMING)} {
 lappend check_stage_settings_cmd -high_effort_timing
}
if {$RESET_CHECK_STAGE_SETTINGS} {lappend check_stage_settings_cmd -reset_app_options}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_stage_settings {eval ${check_stage_settings_cmd}}

puts "RM-info: Marking clock network as ideal"
set currentMode [current_mode]
foreach_in_collection mode [all_modes] {
    current_mode $mode
    set clock_tree [remove_from_collection [all_fanout -flat -clock_tree] [all_registers -clock_pins]]
    if { [sizeof_collection $clock_tree] > 0 } {
        set_ideal_network $clock_tree
        remove_propagated_clock [get_pins -hierarchical]
        remove_propagated_clock [get_ports]
        remove_propagated_clock [all_clocks]
    }
}
current_mode $currentMode

##########################################################################################
## Clock NDR modeling at compile_fusion
##########################################################################################
## Clock NDRs are created in settings.compile.tcl. 
## mark_clock_trees makes compile_fusion recognize them to model the congestion impact when trial CTS is not run.
#puts "RM-info: Running mark_clock_trees -routing_rules to model clock NDR impact during compile_fusion"
#mark_clock_trees -routing_rules

##########################################################################################
## Retiming
##########################################################################################
# set_optimize_registers -modules [get_modules ...]

##########################################################################################
## Initial Compile
##########################################################################################
set compile_cmd "compile_fusion -to logic_opto"
puts "RM-info: Running ${compile_cmd}"
eval ${compile_cmd}
save_block -as ${DESIGN_NAME}/compile_logic_opto
report_qor -summary

puts "RM-info: Incrementally running mark_clock_trees -routing_rules to model clock NDR impact during compile_fusion"
mark_clock_trees -routing_rules

##########################################################################################
## Apply Mapped Netlist Constraints 
##########################################################################################
rm_source -file $TCL_USER_COMPILE_PRE_INITIAL_PLACE_SCRIPT -optional -print "TCL_USER_COMPILE_PRE_INITIAL_PLACE_SCRIPT"


if {[rm_source -file $TCL_DFT_SETUP_FILE -optional -print "TCL_DFT_SETUP_FILE"]} {
## Note : the following executes only if TCL_DFT_SETUP_FILE is sourced
   	puts "RM-info: Running create_test_protocol"
    	create_test_protocol    
    	redirect -tee ${REPORTS_DIR}/${REPORT_PREFIX}.initial_opto.pre-insert_dft.dft_drc {dft_drc -test_mode all_dft}
    	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.pre-insert_dft.report_dft { report_dft }
    	# In “in-compile” DFT insertion flow, insert_dft command inserts the DFTMAX Codec and performs scan stitching.
    	# Use the preview_dft command to report on the DFTMAX Codec and scan chain structures prior to actual insertion

	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.preview_dft { preview_dft }
	puts "RM-info: Running insert_dft"
	insert_dft    
	save_block -as ${DESIGN_NAME}/${INSERT_DFT_BLOCK_NAME}
}


##########################################################################################
## FUSA DCLS Boundary Protection
##########################################################################################
if {$ENABLE_FUSA && $ENABLE_DCLS_BOUNDARY_PROTECTION} {
  puts "RM-info: Enabling DCLS Boundary Protection"
  insert_safety_core_boundary_protection -safety_core_groups [get_safety_core_groups]
}


set compile_cmd "compile_fusion -from initial_place -to initial_drc"
puts "RM-info: Running ${compile_cmd}"
eval ${compile_cmd}
report_qor -summary
save_block -as ${DESIGN_NAME}/compile_initial_drc

rm_source -file $TCL_USER_COMPILE_PRE_INITIAL_OPTO_SCRIPT -optional -print "TCL_USER_COMPILE_PRE_INITIAL_OPTO_SCRIPT"

set compile_cmd "compile_fusion -from initial_opto -to initial_opto"
puts "RM-info: Running ${compile_cmd}"
eval ${compile_cmd}
report_qor -summary
save_block -as ${DESIGN_NAME}/compile_initial_opto

## write test protocols for each DFT mode
foreach mode $DFT_MODES_LIST {
    redirect -tee $REPORTS_DIR/$COMPILE_BLOCK_NAME.initial_opto.$mode.dft_drc {dft_drc -test_mode $mode}
    write_test_protocol -test_mode $mode -output $OUTPUTS_DIR/$COMPILE_BLOCK_NAME.initial_opto.$mode.spf
}

##########################################################################
## Regular MSCTS at place_opt 
##########################################################################
if {$CTS_STYLE == "MSCTS"} {
	if {[rm_source -file $TCL_REGULAR_MSCTS_FILE]} {
	## Note : the following executes only if TCL_REGULAR_MSCTS_FILE is sourced
		set_app_options -name compile.flow.enable_multisource_clock_trees -value true
                save_block -as ${DESIGN_NAME}/${COMPILE_BLOCK_NAME}_MSCTS
	}
} elseif {$CTS_STYLE != "standard"} {
	puts "RM-error: Specified CTS_STYLE($CTS_STYLE) is not supported, standard will be used." 
}

##########################################################################################
## Unified Flow
##########################################################################################
if {${UNIFIED_FLOW}} {

        ## set_stage : a command to apply stage-based application options; intended to be used after set_qor_strategy within RM scripts.
        set set_stage_cmd "set_stage -step compile_place"
        puts "RM-info: Running ${set_stage_cmd}"
        eval ${set_stage_cmd}

	## HPC_CORE specific
	if {$HPC_CORE != "" } {
		set HPC_STAGE compile_place
		puts "RM-info: HPC_CORE is being set to $HPC_CORE; Loading HPC settings"
		set_hpc_options -core $HPC_CORE -stage $HPC_STAGE
		rm_source -file $HPC_STAGE_SETTING_FILE
	}

        rm_source -file $TCL_USER_COMPILE_PRE_UNIFIED_SCRIPT -optional -print "TCL_USER_COMPILE_PRE_UNIFIED_SCRIPT"

        set compile_cmd "compile_fusion -from final_place"
        puts "RM-info: Running ${compile_cmd}"
        eval ${compile_cmd}
        report_qor -summary
}

###########################################################################################
## Post-compile customizations
###########################################################################################
rm_source -file $TCL_USER_COMPILE_POST_SCRIPT -optional -print "TCL_USER_COMPILE_POST_SCRIPT"

if {![rm_source -file $TCL_USER_CONNECT_PG_NET_SCRIPT -optional -print "TCL_USER_CONNECT_PG_NET_SCRIPT"]} {
## Note : the following executes if TCL_USER_CONNECT_PG_NET_SCRIPT is not sourced
	connect_pg_net
        # For non-MV designs with more than one PG, you should use connect_pg_net in manual mode.
}
## Re-enable power analysis if disabled for set_qor_strategy -metric leakage_power
if {[info exists rm_dynamic_scenarios] && [llength $rm_dynamic_scenarios] > 0} {
   puts "RM-info: Reenabling dynamic power analysis for $rm_dynamic_scenarios"
   set_scenario_status -dynamic_power true [get_scenarios $rm_dynamic_scenarios]
}

change_names -rules verilog -hierarchy -skip_physical_only_cells

if {$UPF_MODE == "golden"} {
        set upf_files "${UPF_FILE}"
        if {[file exists [which ${UPF_UPDATE_SUPPLY_SET_FILE}]]} { lappend upf_files "${UPF_UPDATE_SUPPLY_SET_FILE}" }                        
        write_ascii_files -force \
            -output ${OUTPUTS_DIR}/${COMPILE_BLOCK_NAME}.ascii_files \
            -golden_upf "${upf_files}"
} else {
        write_ascii_files -force \
            -output ${OUTPUTS_DIR}/${COMPILE_BLOCK_NAME}.ascii_files
}
saif_map -type ptpx -essential -write_map ${OUTPUTS_DIR}/${COMPILE_BLOCK_NAME}.saif.ptpx.map
saif_map -write_map ${OUTPUTS_DIR}/${COMPILE_BLOCK_NAME}.saif.fc.map

## write_scan_def must be excuted before save_block to update scandef
write_scan_def -output ${OUTPUTS_DIR}/${COMPILE_BLOCK_NAME}.scandef -version 5.8

## write test protocols and dft_drc for each DFT mode
foreach mode $DFT_MODES_LIST {
    redirect -tee $REPORTS_DIR/$COMPILE_BLOCK_NAME.$mode.dft_drc {dft_drc -test_mode $mode}
    write_test_protocol -test_mode $mode -output $OUTPUTS_DIR/$COMPILE_BLOCK_NAME.$mode.spf
}

save_block
if {$UNIFIED_FLOW} {
    save_block -as ${DESIGN_NAME}/${PLACE_OPT_BLOCK_NAME}
}

set_svf -off

###########################################################################################
## Report and output
###########################################################################################
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

report_msg -summary
print_message_info -ids * -summary
echo [date] > compile

exit 

