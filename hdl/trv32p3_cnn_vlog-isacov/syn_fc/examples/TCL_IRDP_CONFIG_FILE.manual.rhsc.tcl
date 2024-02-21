########################################################################################
# Script: TCL_IRDP_CONFIG_FILE.manual.rhsc.tcl
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

if {$REDHAWK_SCENARIO != ""} {
        ## Recording current scenario settings
	report_scenarios
	set rm_current_scenario [current_scenario]
	set rm_active_scenarios [get_object_name [get_scenarios -filter active==true]]
	set rm_setup_scenarios [get_object_name [get_scenarios -filter setup==true]]
	set rm_hold_scenarios [get_object_name [get_scenarios -filter hold==true]]

        current_scenario $REDHAWK_SCENARIO
	set_scenario_status $REDHAWK_SCENARIO -active true -setup true -hold false
	puts "RM-info: Set current scenario $REDHAWK_SCENARIO"
}

## The is IRDP Regular flow
## Enable place.coarse.ir_drop_aware for IR Driven Placement before clock_opt
## Disable opt.common.power_integrity streamline flow
set_app_options -name opt.common.power_integrity -value false
set_app_options -name place.coarse.ir_drop_aware -value true
set_app_options -name clock_opt.flow.skip_placement -value false ;# required to be set to false

puts "RM-info: Run RedHawk-SC  "
set_app_options -name rail.enable_redhawk -value false
set_app_options -name rail.enable_redhawk_sc -value true
set_app_options -name rail.tech_file -value $REDHAWK_TECH_FILE
set_app_options -name rail.redhawk_path -value $REDHAWK_SC_DIR

if {$REDHAWK_SC_GRID_FARM == "" } {
        puts "RM-info: Run RHSC on single machine"
	remove_host_options -all
	set_host_options -submit_command {local}  -max_cores 16
} else {
        puts "RM-info: Submit RHSC into GRID farm system "
        set_host_options -submit_command $REDHAWK_SC_GRID_FARM
}

if {![check_license -quiet "SNPS_INDESIGN_RH_RAIL"]} {
        puts "RM-error: Unable to find SNPS_INDESIGN_RH_RAIL license. Exiting...."
        exit 
}

if {![check_license -quiet "SNPS_INDESIGN_RH_RAIL"]} {
        puts "RM-error: Unable to find NDM data search path. Exiting...."
        exit 
}

if {[which $REDHAWK_SC_DIR] == "" } {
        puts "RM-error: Unable to find RedHawk-SC at \"$REDHAWK_SC_DIR\". Exiting...."
	exit 
} else {
	puts "RM-info: Setting rail.redhawk_path to $REDHAWK_SC_DIR"
	set_app_options -name rail.redhawk_path -value $REDHAWK_SC_DIR
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
        puts "RM-info: Setup current scenario for RHSC "
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

if {$RHSC_PYTHON_SCRIPT_FILE == "" } {
        if {$REDHAWK_SWITCHING_ACTIVITY_FILE == ""} {
		if {($REDHAWK_ANALYSIS == "static" || $REDHAWK_ANALYSIS == "dynamic_vcd" || $REDHAWK_ANALYSIS == "dynamic_vectorless" || $REDHAWK_ANALYSIS == "dynamic" ) && !$REDHAWK_EM_ANALYSIS} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -voltage_drop $REDHAWK_ANALYSIS -extra_gsr_option $REDHAWK_EXTRA_GSR
                } elseif {($REDHAWK_ANALYSIS == "static" || $REDHAWK_ANALYSIS == "dynamic_vcd" || $REDHAWK_ANALYSIS == "dynamic_vectorless" || $REDHAWK_ANALYSIS == "dynamic" ) && $REDHAWK_EM_ANALYSIS} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -voltage_drop $REDHAWK_ANALYSIS -electromigration  -extra_gsr_option $REDHAWK_EXTRA_GSR
                } elseif {$REDHAWK_ANALYSIS == "effective_resistance" } {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -effective_resistance -extra_gsr_option $REDHAWK_EXTRA_GSR
                } elseif {$REDHAWK_ANALYSIS == "min_path_resistance" } {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS  -min_path_resistance -extra_gsr_option $REDHAWK_EXTRA_GSR
                } elseif {$REDHAWK_ANALYSIS == "check_missing_via" && $REDHAWK_MISSING_VIA_POS_THRESHOLD == ""} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -check_missing_via -extra_gsr_option $REDHAWK_EXTRA_GSR
                } elseif {$REDHAWK_ANALYSIS == "check_missing_via" && $REDHAWK_MISSING_VIA_POS_THRESHOLD != ""} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -voltage_drop static -check_missing_via -extra_gsr_option $REDHAWK_EXTRA_GSR
		} else {
                        puts "RM-error: Please enable at least one analysis"
			exit
                }
       } else {
		if {($REDHAWK_ANALYSIS == "static" || $REDHAWK_ANALYSIS == "dynamic_vcd" || $REDHAWK_ANALYSIS == "dynamic_vectorless" || $REDHAWK_ANALYSIS == "dynamic" ) && !$REDHAWK_EM_ANALYSIS} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -voltage_drop $REDHAWK_ANALYSIS -extra_gsr_option $REDHAWK_EXTRA_GSR -switching_activity $REDHAWK_SWITCHING_ACTIVITY_FILE
                } elseif {($REDHAWK_ANALYSIS == "static" || $REDHAWK_ANALYSIS == "dynamic_vcd" || $REDHAWK_ANALYSIS == "dynamic_vectorless" || $REDHAWK_ANALYSIS == "dynamic" ) && $REDHAWK_EM_ANALYSIS} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -voltage_drop $REDHAWK_ANALYSIS -electromigration  -extra_gsr_option $REDHAWK_EXTRA_GSR -switching_activity $REDHAWK_SWITCHING_ACTIVITY_FILE
                } elseif {$REDHAWK_ANALYSIS == "effective_resistance" } {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -effective_resistance -extra_gsr_option $REDHAWK_EXTRA_GSR
                } elseif {$REDHAWK_ANALYSIS == "min_path_resistance" } {
                         analyze_rail -nets $REDHAWK_ANALYSIS_NETS  -min_path_resistance -extra_gsr_option $REDHAWK_EXTRA_GSR
                } elseif {$REDHAWK_ANALYSIS == "check_missing_via" && $REDHAWK_MISSING_VIA_POS_THRESHOLD == ""} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -check_missing_via -extra_gsr_option $REDHAWK_EXTRA_GSR
                } elseif {$REDHAWK_ANALYSIS == "check_missing_via" && $REDHAWK_MISSING_VIA_POS_THRESHOLD != ""} {
			analyze_rail -nets $REDHAWK_ANALYSIS_NETS -voltage_drop static -check_missing_via -extra_gsr_option $REDHAWK_EXTRA_GSR 
		} else {
                        puts "RM-error: Please enable at least one analysis"
			exit
                }
        }
} else {

	if {$RHSC_GENERATE_COLLATERAL != ""} {
		puts "RM-Info : Run analyze_rail -script_only -generate_file $RHSC_GENERATE_COLLATERAL for running cusomized python script"
                analyze_rail -script_only -nets $REDHAWK_ANALYSIS_NETS -voltage_drop $REDHAWK_ANALYSIS -generate_file  $RHSC_GENERATE_COLLATERAL

	} else { 

		puts "RM-Info : To generate latest version of DEF/SPEF/STA/PLOC/LEF, Please modify the \(set RHSC_GENERATE_COLLATERAL  \"TWF LEF DEF SPEF PLOC\"\) in the file ./rm_setup/design_setup.tcl "
                analyze_rail -script_only -nets $REDHAWK_ANALYSIS_NETS -voltage_drop static

                puts "RM-Info : Important Note: Please make sure the  \"design.input_files.py\" have correct path descriptions for generated input files "

	}

        analyze_rail -redhawk_script_file $RHSC_PYTHON_SCRIPT_FILE
}

if {$REDHAWK_SCENARIO != ""} {
	## Restore original scenario settings
	puts "RM-info: Restoring original scneario settings  "
	current_scenario $rm_current_scenario
	if {[info exists rm_active_scenarios] && [llength $rm_active_scenarios] > 0} {
		set_scenario_status -active false [all_scenarios]
		set_scenario_status -active true [get_scenarios $rm_active_scenarios]
	}
	if {[info exists rm_setup_scenarios] && [llength $rm_setup_scenarios] > 0} {
		set_scenario_status -setup false [all_scenarios]
		set_scenario_status -setup true [get_scenarios $rm_setup_scenarios]
	}
	if {[info exists rm_hold_scenarios] && [llength $rm_hold_scenarios] > 0} {
		set_scenario_status -hold false [all_scenarios]
		set_scenario_status -hold true [get_scenarios $rm_hold_scenarios]
	}
	report_scenarios
}


