########################################################################################
# Script: TCL_IRDP_CONFIG_FILE.streamlined.rh.tcl
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

## The is IRDP Streamline flow
## Disable place.coarse.ir_drop_aware for IR Driven Placement before clock_opt
## Enable opt.common.power_integrity streamline flow
set_app_options -name opt.common.power_integrity -value true
set_app_options -name place.coarse.ir_drop_aware -value false
set_app_options -name clock_opt.flow.skip_placement -value false ;# required to be set to false

puts "RM-info: Run RedHawk  "
set_app_options -name rail.enable_redhawk -value true
set_app_options -name rail.enable_redhawk_sc -value false
set_app_options -name rail.tech_file -value $REDHAWK_TECH_FILE
set_app_options -name rail.redhawk_path -value $REDHAWK_DIR

if {![check_license -quiet "SNPS_INDESIGN_RH_RAIL"]} {
        puts "RM-error: Unable to find SNPS_INDESIGN_RH_RAIL license. Exiting...."
        exit 
}

if {![check_license -quiet "SNPS_INDESIGN_RH_RAIL"]} {
        puts "RM-error: Unable to find NDM data search path. Exiting...."
        exit 
}

if {[file exists [which $REDHAWK_LAYER_MAP_FILE]]} {
        set_app_options -name rail.layer_map_file -value $REDHAWK_LAYER_MAP_FILE

}

if {[which $REDHAWK_TECH_FILE] == ""} {
        puts "RM-error: Unable to find redhawk tech file at \"$REDHAWK_TECH_FILE\".  Exiting...."
	exit 
} else {
	puts "RM-info: Setting rail.tech_file to $REDHAWK_TECH_FILE"
	set_app_options -name rail.tech_file -value $REDHAWK_TECH_FILE
}

if {$REDHAWK_LIB_FILES == ""} {
        puts "RM-error: No .lib files are provided.  Exiting...."
	exit
} elseif { [file exists [ which $REDHAWK_LIB_FILES  ]] } {
	rm_source -file $REDHAWK_LIB_FILES
} else {
	puts "RM-info: Setting rail.lib_files to $REDHAWK_LIB_FILES"
	set_app_options -name rail.lib_files -value $REDHAWK_LIB_FILES
}

if {$REDHAWK_APL_FILES == "" && ($REDHAWK_ANALYSIS == "dynamic_vectorless" || $REDHAWK_ANALYSIS == "dynamic_vcd" || $REDHAWK_ANALYSIS == "dynamic" )} {
        puts "RM-Warning: No APL files provided for the dynamic analysis.  Run dynamic with .lib "
} else {
        puts "RM-info: Setting rail.apl_files to $REDHAWK_APL_FILES"
        set_app_options -name rail.apl_files -value $REDHAWK_APL_FILES
}

if {[file exists [which $REDHAWK_PAD_FILE_NDM]]} {
          puts "RM-info: Run create_taps with a file that include coordinates and metal layer from NDM "
          create_taps -import $REDHAWK_PAD_FILE_NDM
} elseif { [file exists [ which $REDHAWK_PAD_FILE_PLOC ]] } {
	  puts "RM-info: Pass Redhawk ploc file to RedHawk "
          set_app_options -name rail.pad_files  -value $REDHAWK_PAD_FILE_PLOC
} elseif { [file exists [which $REDHAWK_PAD_CUSTOMIZED_SCRIPT]] }  { 
	  rm_source -file $REDHAWK_PAD_CUSTOMIZED_SCRIPT
} else {
	puts "RM-info: Run create_taps -top_pg "
        create_taps -top_pg
}

if {$REDHAWK_FREQUENCY != ""} {
	puts "RM-info: Setup Frequency for RedHawk "
        set_app_options -name rail.frequency -value $REDHAWK_FREQUENCY
}

if {$REDHAWK_TEMPERATURE != ""} {
        puts "RM-info: Setup TEMPERATURE for RedHawk "
        set_app_options -name rail.temperature -value $REDHAWK_TEMPERATURE
}

if {$REDHAWK_SCENARIO != ""} {
        ## Recording current scenario settings
	report_scenarios
	set rm_current_scenario [current_scenario]
	set rm_active_scenarios [get_object_name [get_scenarios -filter active==true]]

        puts "RM-info: Set current scenario $REDHAWK_SCENARIO"
        current_scenario $REDHAWK_SCENARIO
	set_scenario_status $REDHAWK_SCENARIO -active true
}

if {$REDHAWK_MACROS != ""} {
	puts "RM-info: Setup Macro Model to top design "
        set_app_options -name rail.macro_models -value $REDHAWK_MACROS
}

if {$REDHAWK_SWITCH_MODEL_FILES != ""} {
        set_app_options -name rail.switch_model_files -value $REDHAWK_SWITCH_MODEL_FILES
}

set_missing_via_check_options -exclude_stack_via -threshold -1

set_app_options -name rail.database -value $REDHAWK_RAIL_DATABASE

if {$REDHAWK_MISSING_VIA_POS_THRESHOLD != ""} {

	set_missing_via_check_options -exclude_stack_via -threshold $REDHAWK_MISSING_VIA_POS_THRESHOLD
}

if {$REDHAWK_EXTRA_GSR == ""} {
        exec touch extra.gsr
        set REDHAWK_EXTRA_GSR "extra.gsr"
}

if {$REDHAWK_SCENARIO != ""} {
	## Restore original scenario settings
	puts "RM-info: Restoring original scneario settings  "
	current_scenario $rm_current_scenario
	if {[info exists rm_active_scenarios] && [llength $rm_active_scenarios] > 0} {
		set_scenario_status -active false [all_scenarios]
		set_scenario_status -active true [get_scenarios $rm_active_scenarios]
	}
	report_scenarios
}


