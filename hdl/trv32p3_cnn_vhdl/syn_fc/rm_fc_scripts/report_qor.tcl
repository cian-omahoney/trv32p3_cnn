##########################################################################################
# Script: report_qor.tcl
# Purpose: Reporting with -nosplit options added to commands that support it
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
if {$REPORT_PREFIX != ""} {

####################################
## Clock tree QoR
####################################
if {[regexp $REPORT_PREFIX $INIT_DESIGN_BLOCK_NAME]} {
	puts "RM-info: Reporting clock tree information ...\n"
	parallel_execute {
		{report_clock_qor -type area -nosplit} ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.cell_area
		{report_clock_qor -type structure -nosplit} ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.structure
	}
} elseif {![regexp $REPORT_PREFIX $COMPILE_BLOCK_NAME]} {
	puts "RM-info: Reporting clock tree information and QoR ...\n"
	redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.summary {report_clock_qor -nosplit}
	parallel_execute {
		{report_clock_qor -type latency -show_paths -nosplit} ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.latency
		{report_clock_qor -type area -nosplit} ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.cell_area
		{report_clock_qor -type structure -nosplit} ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.structure
		{report_clock_qor -type drc_violators -all -nosplit} ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.drc_violators
		{report_clock_timing -type summary -clock_synthesis_view -scenarios [all_scenarios] -nosplit} ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_timing.summary
		{report_clock_timing -type skew -clock_synthesis_view -scenarios [all_scenarios] -nosplit} ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_timing.skew
		{report_clock_timing -type latency -clock_synthesis_view -scenarios [all_scenarios] -nosplit} ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_timing.latency 
	}
	if {[get_app_option_value -name cts.compile.enable_local_skew] || [get_app_option_value -name cts.optimize.enable_local_skew] || [get_app_option_value -name clock_opt.flow.enable_ccd]} {\
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.local_skew {report_clock_qor -type local_skew -nosplit}
	}
}

if {$REPORT_QOR_REPORT_POWER && ![regexp $REPORT_PREFIX $COMPILE_BLOCK_NAME]} { 
	if {[sizeof_collection [get_scenarios -filter "active && (dynamic_power || leakage_power)"]] > 0} {
		puts "RM-info: Running report_clock_qor -type power ...\n"
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.power {report_clock_qor -type power -nosplit}
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_power.per_segment {report_clock_power -nosplit -type per_segment}
	}
}

####################################
## Timing Constraints 
####################################
puts "RM-info: Reporting timing constraints ...\n"
parallel_execute {
	{report_modes -nosplit} ${REPORTS_DIR}/${REPORT_PREFIX}.report_modes
	{report_pvt -nosplit} ${REPORTS_DIR}/${REPORT_PREFIX}.report_pvt
	{report_corners [all_corners]} ${REPORTS_DIR}/${REPORT_PREFIX}.report_corners
}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_scenarios {report_scenarios -nosplit}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clocks {report_clocks -mode [all_modes] -nosplit}

####################################
## Timing and QoR 
####################################
puts "RM-info: Reporting timing and QoR ...\n"

## Show special inbuilt path groups **async_default** and **clock_gating_default** in timing report 
## Note: User specified path groups has higher precedence than these. (global-scoped)
#	set_app_options -name time.use_special_default_path_groups -value true ;# tool default false

## QoR
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor {report_qor -scenarios [all_scenarios] -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
redirect -tee -append -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor {report_qor -summary -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.proc_qor {proc_qor -pba_mode [get_app_option_value -name time.pba_optimization_mode]}

## global timing 
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_global_timing {report_global_timing -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}

## Timing (-variation enabled for POCV)
if {[get_app_option_value -name time.pocvm_enable_analysis]} {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.no_variation.max {report_timing -delay max -scenarios [all_scenarios] \
        -input_pins -nets -transition_time -capacitance -attributes -physical -derate -report_by group -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.max {report_timing -delay max -scenarios [all_scenarios] \
	-input_pins -nets -transition_time -capacitance -attributes -physical -derate -report_by group -pba_mode [get_app_option_value -name time.pba_optimization_mode] -variation -nosplit}

	foreach_in_collection scenario [get_scenarios -filter {active && setup}] {
		set scenario_name [get_object_name $scenario]
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.max.end.${scenario_name} {report_timing -delay max -path end -nosplit -max_paths 5000 -scenarios ${scenario_name}}
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.max.${scenario_name} {report_timing -delay max -scenarios ${scenario_name} -path_type full_clock_expanded -variation \
        	-input_pins -nets -transition_time -capacitance -attributes -physical -derate -crosstalk -report_by group -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit -max_paths 300}
                redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.no_variation.max.${scenario_name} {report_timing -delay max -scenarios ${scenario_name} -path_type full_clock_expanded \
                -input_pins -nets -transition_time -capacitance -attributes -physical -derate -crosstalk -report_by group -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit -max_paths 300}
	}	
} else {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.max {report_timing -delay max -scenarios [all_scenarios] \
	-input_pins -nets -transition_time -capacitance -attributes -physical -derate -report_by group -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}

	foreach_in_collection scenario [get_scenarios -filter {active && setup}] {
		set scenario_name [get_object_name $scenario]
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.max.end.${scenario_name} {report_timing -delay max -path end -nosplit -max_paths 5000 -scenarios ${scenario_name}}
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.max.${scenario_name} {report_timing -delay max -scenarios ${scenario_name} -path_type full_clock_expanded \
        	-input_pins -nets -transition_time -capacitance -attributes -physical -derate -crosstalk -report_by group -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit -max_paths 300}
	}
}

# Min timing report is generated in postcts (-variation enabled for POCV)
if {[regexp $REPORT_PREFIX "$CLOCK_OPT_CTS_BLOCK_NAME|$CLOCK_OPT_OPTO_BLOCK_NAME|$ROUTE_AUTO_BLOCK_NAME|$ROUTE_OPT_BLOCK_NAME|$CHIP_FINISH_BLOCK_NAME|$ICV_IN_DESIGN_BLOCK_NAME|$TIMING_ECO_BLOCK_NAME|$FUNCTIONAL_ECO_BLOCK_NAME|$ENDPOINT_OPT_BLOCK_NAME"]} {
	if {[get_app_option_value -name time.pocvm_enable_analysis]} {
                redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.no_variation.min {report_timing -delay min -scenarios [all_scenarios] \
                -input_pins -nets -transition_time -capacitance -attributes -physical -derate -report_by group -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.min {report_timing -delay min -scenarios [all_scenarios] \
		-input_pins -nets -transition_time -capacitance -attributes -physical -derate -report_by group -pba_mode [get_app_option_value -name time.pba_optimization_mode] -variation -nosplit}

		foreach_in_collection scenario [get_scenarios -filter {active && hold}] {
			set scenario_name [get_object_name $scenario]
			redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.min.end.${scenario_name} {report_timing -delay min -path end -nosplit -max_paths 5000 -scenarios ${scenario_name}}
			redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.min.${scenario_name} {report_timing -delay min -scenarios ${scenario_name} -path_type full_clock_expanded -variation \
        		-input_pins -nets -transition_time -capacitance -attributes -physical -derate -crosstalk -report_by group -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit -max_paths 300}
                        redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.no_variation.min.${scenario_name} {report_timing -delay min -scenarios ${scenario_name} -path_type full_clock_expanded \
                        -input_pins -nets -transition_time -capacitance -attributes -physical -derate -crosstalk -report_by group -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit -max_paths 300}
		}

	} else {
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.min {report_timing -delay min -scenarios [all_scenarios] \
		-input_pins -nets -transition_time -capacitance -attributes -physical -derate -report_by group -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}

		foreach_in_collection scenario [get_scenarios -filter {active && hold}] {
			set scenario_name [get_object_name $scenario]
			redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.min.end.${scenario_name} {report_timing -delay min -path end -nosplit -max_paths 5000 -scenarios ${scenario_name}}
			redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.min.${scenario_name} {report_timing -delay min -scenarios ${scenario_name} -path_type full_clock_expanded \
        		-input_pins -nets -transition_time -capacitance -attributes -physical -derate -crosstalk -report_by group -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit -max_paths 300}
		}
	}
}

## Constraint violations
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_constraint {report_constraint -all_violators -max_transition -max_capacitance -scenarios [all_scenarios] -nosplit}

## Debugging
puts "RM-info: Analyzing design violations ...\n"
# analyze_design_violations for setup
# The command will automatically add "type" (ie, setup or hold) as part of the report name
# For example, the report name for setup type would be ${REPORTS_DIR}/${REPORT_PREFIX}.analyze_design_violations.setup
if {[regexp $REPORT_PREFIX "$COMPILE_BLOCK_NAME|$PLACE_OPT_BLOCK_NAME|$CLOCK_OPT_OPTO_BLOCK_NAME"]} {
	analyze_design_violations -type setup -stage preroute -output ${REPORTS_DIR}/${REPORT_PREFIX}.analyze_design_violations
} elseif {[regexp $REPORT_PREFIX "$ROUTE_OPT_BLOCK_NAME"]} {
	analyze_design_violations -type setup -stage postroute -output ${REPORTS_DIR}/${REPORT_PREFIX}.analyze_design_violations
}

# analyze_design_violations for hold
if {[regexp $REPORT_PREFIX "$CLOCK_OPT_OPTO_BLOCK_NAME"]} {
	analyze_design_violations -type hold -stage preroute -output ${REPORTS_DIR}/${REPORT_PREFIX}.analyze_design_violations
} elseif {[regexp $REPORT_PREFIX "$ROUTE_OPT_BLOCK_NAME"]} {
	analyze_design_violations -type hold -stage postroute -output ${REPORTS_DIR}/${REPORT_PREFIX}.analyze_design_violations
}

if {[regexp $REPORT_PREFIX $COMPILE_BLOCK_NAME]} {
        redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_transformed_registers {report_transformed_registers -nosplit}
        redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_gating {report_clock_gating -nosplit}
        redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_resources {report_resources -nosplit}
        redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_logic_levels {report_logic_levels -nosplit}
        redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_dft {report_dft -nosplit}
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_activity.rtl {report_activity -rtl}
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_activity.driver.end {report_activity -driver}
	######### BEGIN CHANGED FOR ASIP SCRIPTS ############
	if {[info exists env(ASIP_FLOW)]} {
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_area_hierarchy {report_area -hierarchy -nosplit}
	}
	######### END CHANGED FOR ASIP SCRIPTS ############
}
if {![regexp $REPORT_PREFIX "$COMPILE_BLOCK_NAME|$INIT_DESIGN_BLOCK_NAME"]} {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_activity {report_activity -verbose}
}

####################################
## MV
####################################
# check_mv_design -erc_mode and -power_connectivity
	redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_mv_design.erc_mode {check_mv_design -erc_mode}
	redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_mv_design {check_mv_design} ;# check_mv_design is also covered by check_design
if {[regexp $REPORT_PREFIX $INIT_DESIGN_BLOCK_NAME]} {
        redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_power_domains {report_power_domains -nosplit}
        redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_voltage_areas {report_voltage_areas -nosplit}
        redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_power_scopes {report_power_scopes -nosplit}
        redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_pst {report_pst -nosplit}
        redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_supply_set {report_supply_set -nosplit}
}
if {!([regexp $REPORT_PREFIX "$COMPILE_BLOCK_NAME"] && !${UNIFIED_FLOW})} { 
	redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_mv_design.power_connectivity {check_mv_design -power_connectivity}
	redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_pg_connectivity {check_pg_connectivity}
}

redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_mv_path {report_mv_path -all_not_associated}

####################################
## Power 
####################################
if {![regexp $REPORT_PREFIX "$COMPILE_BLOCK_NAME|$INIT_DESIGN_BLOCK_NAME"]} {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_threshold_voltage_group {report_threshold_voltage_group -nosplit}
}

if {$REPORT_QOR_REPORT_POWER} { 
	set power_scenarios [get_scenarios -filter "leakage_power==true||dynamic_power==true"]
	if { [sizeof_collection $power_scenarios] > 0 } {
	  puts "RM-info: Running report_power ...\n"

	  ## Activate inactive power scenarios
	  if { [sizeof_collection [filter $power_scenarios "active==false"]] > 0 } {
	    set inactive_power_scenarios [filter $power_scenarios "active==false"]
	    set_scenario_status $inactive_power_scenarios -active true
	  } else {
	    set inactive_power_scenarios {}
	  }

	  ## Retrieve all power scenarios
	  set power_scenarios [get_scenarios -filter "leakage_power==true||dynamic_power==true"]

	  ## With REPORT_POWER_SAIF_FILE
	  if {$REPORT_POWER_SAIF_FILE != ""} {
	    if { [file exists [which ${REPORT_POWER_SAIF_FILE}]] } {
	      ## Source saif_map if it exists
	      if { [file exists [which $REPORT_POWER_SAIF_MAP]] } {
	        saif_map -read $REPORT_POWER_SAIF_MAP
	      }

	      ## read_saif
	      reset_switching_activity -scenarios $power_scenarios
	      set scaling_factor  [lindex [sh zgrep TIMESCALE $REPORT_POWER_SAIF_FILE ] 1]
	      puts "RM-info: Running read_saif ${REPORT_POWER_SAIF_FILE} -scaling_ratio $scaling_factor -strip_path $SAIF_FILE_SOURCE_INSTANCE -scenarios [get_object_name $power_scenarios]"
	      read_saif {{$REPORT_POWER_SAIF_FILE -scaling_ratio $scaling_factor}} -strip_path $SAIF_FILE_SOURCE_INSTANCE -scenarios $power_scenarios

	      ## report the amount of annotation that was propagated
	      redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_power {report_activity -driver -show_zeros -verbose -scenarios $power_scenarios }

	      ## set app options to align with PT
	      set_app_option -name power.default_toggle_rate -value 0.0
	      set_app_option -name power.default_static_probability -value 0.0
	      set_app_option -name power.propagation_effort -value high
	      set_app_option -name power.use_ccs_rcv_cap -value true
	      set_app_option -name power.use_enhanced_multidriven_net_driver_type -value true
	      set_app_option -name power.include_primary_input_swcap -value true

	      ## report_power	    
	      puts "RM-info: Running report_power with REPORT_POWER_SAIF_FILE ($REPORT_POWER_SAIF_FILE) ...\n"
	      redirect -tee -append -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_power {report_power -verbose -scenarios $power_scenarios -nosplit}
	    } else {
	      puts "RM-error: REPORT_POWER_SAIF_FILE ($REPORT_POWER_SAIF_FILE) is invalid. Please correct it. report_pooer is skipped"
	    }

	  ## Without REPORT_POWER_SAIF_FILE
	  } else {
	    redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_power {report_power -verbose -scenarios $power_scenarios -nosplit}
	  }

	  ## Restore active status
	  if { [sizeof_collection $inactive_power_scenarios] > 0 } {
	    set_scenario_status $inactive_power_scenarios -active false
	  }

	} else {
          puts "RM-info: No power scenarios found. Skipping report_power."
	}
}

####################################
## report_design  
####################################
puts "RM-info: Reporting design information ...\n"
if {[regexp $REPORT_PREFIX "$CLOCK_OPT_CTS_BLOCK_NAME|$CLOCK_OPT_OPTO_BLOCK_NAME|$ROUTE_AUTO_BLOCK_NAME|$ROUTE_OPT_BLOCK_NAME|$CHIP_FINISH_BLOCK_NAME|$ICV_IN_DESIGN_BLOCK_NAME|$TIMING_ECO_BLOCK_NAME|$FUNCTIONAL_ECO_BLOCK_NAME|$ENDPOINT_OPT_BLOCK_NAME"]} {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_design {report_design -library -netlist -floorplan -routing -nosplit}
} else {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_design {report_design -library -netlist -floorplan -nosplit}
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_tracks {report_tracks -nosplit}
}
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_utilization {report_utilization}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_reference {report_reference -hierarchical -nosplit}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_ignored_layers {report_ignored_layers}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_extraction_options {report_extraction_options -corners [all_corners]}
####################################
## check_design, check_netlist & check_legality 
####################################
puts "RM-info: Checking design issues ...\n"

## Run the pre-defined mega-check pre_placement_stage which includes
#  atomic checks such as mv_design, design_mismatch, rp_constraints, timing, and scan chain.
if {[regexp $REPORT_PREFIX "$INIT_DESIGN_BLOCK_NAME"]} {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_design.pre_placement_stage {check_design -ems_database check_design.pre_placement_stage.ems -checks pre_placement_stage}
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_netlist {check_netlist -summary}
}

## Run the pre-defined mega-check pre_clock_tree_stage which includes
#  atomic checks such as mv_design, design_mismatch, timing, scan chain, legality, design_extraction, and clock tree.
if {${UNIFIED_FLOW}} {
    if {[regexp $REPORT_PREFIX "$COMPILE_BLOCK_NAME"]} {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_design.pre_clock_tree_stage {check_design -ems_database check_design.pre_clock_tree_stage.ems -checks pre_clock_tree_stage}
    }
}

if {[regexp $REPORT_PREFIX "$PLACE_OPT_BLOCK_NAME"]} {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_design.pre_clock_tree_stage {check_design -ems_database check_design.pre_clock_tree_stage.ems -checks pre_clock_tree_stage}
}

## Run the pre-defined mega-check pre_route_stage which includes
#  atomic checks such as mv_design, design_mismatch, timing, scan chain, design_extraction, and routeability. 
if {[regexp $REPORT_PREFIX "$CLOCK_OPT_OPTO_BLOCK_NAME"]} {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_design.pre_route_stage {check_design -ems_database check_design.pre_route_stage.ems -checks pre_route_stage}
}

## Report Early Data Check Results
if {$EARLY_DATA_CHECK_POLICY != "none"} {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_early_data_checks.list_of_checks {report_early_data_checks -policy}
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_early_data_checks.rpt {report_early_data_checks -verbose}
}

## Run check_variants
if {![regexp $REPORT_PREFIX "$INIT_DESIGN_BLOCK_NAME"]} {
        redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_variants.end {check_variants -dont_use -included_purposes}
}

## Run check_legality
if {![regexp $REPORT_PREFIX "$INIT_DESIGN_BLOCK_NAME"]} {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_legality {check_legality -verbose}
}
####################################
## FUSA
####################################
if {$ENABLE_FUSA} {
	puts "RM-info: Running FuSa Safety Report...\n"
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_safety_status {report_safety_status}
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_fsm {report_fsm -all -verbose}
}

####################################
## MISC  
####################################
puts "RM-info: Reporting units ...\n"
if {[regexp $REPORT_PREFIX "$INIT_DESIGN_BLOCK_NAME"]} {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_units {report_units -nosplit}
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_user_units {report_user_units -nosplit}
}

puts "RM-info: Reporting non-default app option settings ...\n"
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_app_options.end {report_app_options -non_default *}
puts "RM-info: Reporting size_only and dont_touch information ...\n"
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_size_only {report_size_only -all}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_dont_touch {report_dont_touch -all}
puts "RM-info: Reporting ideal_network information ...\n"
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_ideal_network {report_ideal_network -scenarios [all_scenarios]}

########################################################################
## non-SI reporting at route_auto stage  
########################################################################
if {[regexp $REPORT_PREFIX $ROUTE_AUTO_BLOCK_NAME]} {
	if {[get_app_option_value -name time.si_enable_analysis]} {
		set RM_current_value_enable_si true
	}
	puts "RM-info: time.si_enable_analysis is set to false ...\n"
	set_app_options -name time.si_enable_analysis -value false

	puts "RM-info: Reporting timing and QoR in non-SI mode ...\n"
	## QoR
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.no_si.report_qor {report_qor -scenarios [all_scenarios] -nosplit}
	redirect -tee -append -file ${REPORTS_DIR}/${REPORT_PREFIX}.no_si.report_qor {report_qor -summary -nosplit}

	## Timing (-variation enabled for POCV)
	if {[get_app_option_value -name time.pocvm_enable_analysis]} {
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.no_si.report_timing.max {report_timing -delay max -scenarios [all_scenarios] \
		-input_pins -nets -transition_time -capacitance -attributes -physical -derate -report_by group -variation -nosplit}
                redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.no_si.report_timing.no_variation.max {report_timing -delay max -scenarios [all_scenarios] \
                -input_pins -nets -transition_time -capacitance -attributes -physical -derate -report_by group -nosplit}
	} else {
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.no_si.report_timing.max {report_timing -delay max -scenarios [all_scenarios] \
		-input_pins -nets -transition_time -capacitance -attributes -physical -derate -report_by group -nosplit}
	}

	## Restore user default of time.si_enable_analysis
	if {[info exists RM_current_value_enable_si] && ${RM_current_value_enable_si}} {
		set_app_options -name time.si_enable_analysis -value true
	}
}

########################################################################
## report_drc after route_auto
########################################################################
if {[regexp $REPORT_PREFIX $ROUTE_AUTO_BLOCK_NAME|$ROUTE_OPT_BLOCK_NAME|$CHIP_FINISH_BLOCK_NAME|$ICV_IN_DESIGN_BLOCK_NAME|$TIMING_ECO_BLOCK_NAME|$FUNCTIONAL_ECO_BLOCK_NAME|$ENDPOINT_OPT_BLOCK_NAME"]} {
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_drc {report_drc}
}

########################################################################
## report_congestion and global route congestion map 
########################################################################
if {$REPORT_QOR_REPORT_CONGESTION && [regexp $REPORT_PREFIX "$COMPILE_BLOCK_NAME|$PLACE_OPT_BLOCK_NAME|$CLOCK_OPT_CTS_BLOCK_NAME|$CLOCK_OPT_OPTO_BLOCK_NAME"]} {
	set_app_options -name route.global.timing_driven -value true	
	if {![regexp $REPORT_PREFIX "$CLOCK_OPT_OPTO_BLOCK_NAME"]} {
		redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_congestion {report_congestion -layers [get_layers -filter "layer_type==interconnect"] -rerun_global_router -nosplit}
	} else {
        	redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_congestion {report_congestion -layers [get_layers -filter "layer_type==interconnect"] -nosplit}
	}
	if {[info exists env(DISPLAY)]} {
		gui_start
		#gui_execute_menu_item -menu "View->Layout View"
		gui_execute_menu_item -menu "View->Map->Global Route Congestion"
		gui_write_window_image -format png -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_congestion.png
		gui_stop
	} else {
		puts "RM-info: env(DISPLAY) is not defined. Global route congestion map snapshot is skipped."
	}
}

####################################
## write_qor_data
####################################
if {$WRITE_QOR_DATA} {

        set QOR_DATA_LABEL $REPORT_PREFIX 

	if {[regexp $REPORT_PREFIX $INIT_DESIGN_BLOCK_NAME]} {
		write_qor_data -report_group unmapped -label $QOR_DATA_LABEL -output $WRITE_QOR_DATA_DIR
	} elseif {[regexp $REPORT_PREFIX $COMPILE_BLOCK_NAME]} {
		if {$UNIFIED_FLOW} {
			write_qor_data -report_group placed -label $QOR_DATA_LABEL -output $WRITE_QOR_DATA_DIR
		} else {
			write_qor_data -report_group mapped -label $QOR_DATA_LABEL -output $WRITE_QOR_DATA_DIR
		}
	} elseif {[regexp $REPORT_PREFIX "$CLOCK_OPT_CTS_BLOCK_NAME|$CLOCK_OPT_OPTO_BLOCK_NAME"]} {
		write_qor_data -report_group cts -label $QOR_DATA_LABEL -output $WRITE_QOR_DATA_DIR
	} else {
		write_qor_data -report_group routed -label $QOR_DATA_LABEL -output $WRITE_QOR_DATA_DIR
	}

	## write_qor_data lite for sequential reporting
	#	write_qor_data -report_list "host_machine report_app_options report_utilization report_design wirelength" -label $QOR_DATA_LABEL -output $WRITE_QOR_DATA_DIR

	compare_qor_data -run_locations $WRITE_QOR_DATA_DIR -force -output $COMPARE_QOR_DATA_DIR

}

########################################################################
## Other reporting commands 
########################################################################
## report_ccd_timing : Reports CCD timing information of a design
## - To Print D slacks and Q slacks of the top 5 critical endpoints
##   (D slack : worst slack of the paths captured by a flop)
##   (Q slack : worst slack of the paths lauched by a flop)
##	report_ccd_timing 
## - To report slacks of timing paths that precede or succeed a critical end point with a specified stage number up/down the chain
##	report_ccd_timing -type stage -pin <pin> -max_stages <integer>
## - To report top 5 timing paths in the fanin(fanout) cone of a critical end point
##	report_ccd_timing -type fanin -pin <pin>

} else {

puts "RM-error: REPORT_PREFIX is not specified. Exiting."

}


