########################################################################################
# Script: rhsc_in_design_pnr.tcl
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
rm_source -file ./rm_setup/design_setup.tcl
rm_source -file ./rm_setup/fc_setup.tcl
rm_source -file ./rm_setup/header_fc.tcl
if {$HPC_CORE != ""} {rm_source -file ./inputs/plugin/hpc_vars.tcl}

open_lib $DESIGN_LIBRARY
copy_block -from ${DESIGN_NAME}/${REDHAWK_IN_DESIGN_PNR_FROM_BLOCK_NAME} -to ${DESIGN_NAME}/${REDHAWK_IN_DESIGN_PNR_BLOCK_NAME}
current_block ${DESIGN_NAME}/${REDHAWK_IN_DESIGN_PNR_BLOCK_NAME}
link_block

## Non-persistent settings to be applied in each step (optional)
rm_source -file $TCL_USER_NON_PERSISTENT_SCRIPT -optional -print "TCL_USER_NON_PERSISTENT_SCRIPT"

puts "RM-info: Run RedHawk-SC"
set_app_options -name rail.enable_redhawk -value false
set_app_options -name rail.enable_redhawk_sc -value true

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

if {[which $REDHAWK_SC_DIR] == "" } {
	puts "RM-info: Setting rail.redhawk_path to $REDHAWK_SC_DIR"
	set_app_options -name rail.redhawk_path -value $REDHAWK_SC_DIR
} elseif {[file dirname [exec which redhawk_sc]] != ""} {
	set redhawk_sc_dir_exec [file dirname [exec which redhawk_sc]]
	puts "RM-info: Setting rail.redhawk_sc_path to $redhawk_sc_dir_exec"
	set_app_options -name rail.redhawk_path -value $redhawk_sc_dir_exec
} else {
        puts "RM-error: Unable to find RedHawk-SC binary.  Exiting...."

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
        puts "RM-warning: No .lib files are provided.  Make sure your .gsr include the lib otherwise RedHawk will error...."
} elseif {[file exists [which $REDHAWK_LIB_FILES]]   } {
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
        set extra_gsr_file "extra.gsr"
} else {
	set extra_gsr_file $REDHAWK_EXTRA_GSR
}

if {$RHSC_PYTHON_SCRIPT_FILE == "" } {
        if {$REDHAWK_SWITCHING_ACTIVITY_FILE == ""} {
		if {($REDHAWK_ANALYSIS == "static" || $REDHAWK_ANALYSIS == "dynamic_vcd" || $REDHAWK_ANALYSIS == "dynamic_vectorless" || $REDHAWK_ANALYSIS == "dynamic" ) && !$REDHAWK_EM_ANALYSIS} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -voltage_drop $REDHAWK_ANALYSIS -extra_gsr_option $extra_gsr_file
                } elseif {($REDHAWK_ANALYSIS == "static" || $REDHAWK_ANALYSIS == "dynamic_vcd" || $REDHAWK_ANALYSIS == "dynamic_vectorless" || $REDHAWK_ANALYSIS == "dynamic" ) && $REDHAWK_EM_ANALYSIS} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -voltage_drop $REDHAWK_ANALYSIS -electromigration  -extra_gsr_option $extra_gsr_file
                } elseif {$REDHAWK_ANALYSIS == "effective_resistance" } {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -effective_resistance -extra_gsr_option $extra_gsr_file
                } elseif {$REDHAWK_ANALYSIS == "min_path_resistance" } {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS  -min_path_resistance -extra_gsr_option $extra_gsr_file
                } elseif {$REDHAWK_ANALYSIS == "check_missing_via" && $REDHAWK_MISSING_VIA_POS_THRESHOLD == ""} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -check_missing_via -extra_gsr_option $extra_gsr_file
                } elseif {$REDHAWK_ANALYSIS == "check_missing_via" && $REDHAWK_MISSING_VIA_POS_THRESHOLD != ""} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -voltage_drop static -check_missing_via -extra_gsr_option $extra_gsr_file
		} else {
                        puts "RM-error: Please enable at least one analysis"

			exit

                }
       } else {
		if {($REDHAWK_ANALYSIS == "static" || $REDHAWK_ANALYSIS == "dynamic_vcd" || $REDHAWK_ANALYSIS == "dynamic_vectorless" || $REDHAWK_ANALYSIS == "dynamic" ) && !$REDHAWK_EM_ANALYSIS} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -voltage_drop $REDHAWK_ANALYSIS -extra_gsr_option $extra_gsr_file -switching_activity $REDHAWK_SWITCHING_ACTIVITY_FILE
                } elseif {($REDHAWK_ANALYSIS == "static" || $REDHAWK_ANALYSIS == "dynamic_vcd" || $REDHAWK_ANALYSIS == "dynamic_vectorless" || $REDHAWK_ANALYSIS == "dynamic" ) && $REDHAWK_EM_ANALYSIS} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -voltage_drop $REDHAWK_ANALYSIS -electromigration  -extra_gsr_option $extra_gsr_file -switching_activity $REDHAWK_SWITCHING_ACTIVITY_FILE
                } elseif {$REDHAWK_ANALYSIS == "effective_resistance" } {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -effective_resistance -extra_gsr_option $extra_gsr_file
                } elseif {$REDHAWK_ANALYSIS == "min_path_resistance" } {
                         analyze_rail -nets $REDHAWK_ANALYSIS_NETS  -min_path_resistance -extra_gsr_option $extra_gsr_file
                } elseif {$REDHAWK_ANALYSIS == "check_missing_via" && $REDHAWK_MISSING_VIA_POS_THRESHOLD == ""} {
                        analyze_rail -nets $REDHAWK_ANALYSIS_NETS -check_missing_via -extra_gsr_option $extra_gsr_file
                } elseif {$REDHAWK_ANALYSIS == "check_missing_via" && $REDHAWK_MISSING_VIA_POS_THRESHOLD != ""} {
			analyze_rail -nets $REDHAWK_ANALYSIS_NETS -voltage_drop static -check_missing_via -extra_gsr_option $extra_gsr_file 
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

        puts "RM-Info : Nora-Nora Run RHSC_PYTHON_SCRIPT_FILE $RHSC_PYTHON_SCRIPT_FILE "	
        analyze_rail -redhawk_script_file $RHSC_PYTHON_SCRIPT_FILE
}

if {$REDHAWK_FIX_MISSING_VIAS} {
        foreach_in_collection err_file [get_drc_error_data -all *miss_via*] {
                set errdm [open_drc_error_data $err_file]
                set errs [get_drc_errors -error_data $errdm]
                fix_pg_missing_vias -error_data $errdm $errs
        }
}

if {$REDHAWK_ANALYSIS == "static" || $REDHAWK_ANALYSIS == "dynamic_vcd" || $REDHAWK_ANALYSIS == "dynamic_vectorless" || $REDHAWK_ANALYSIS == "dynamic"} {
        report_rail_result -type effective_voltage  -supply_nets $REDHAWK_ANALYSIS_NETS $REDHAWK_OUTPUT_REPORT
}

if {$REDHAWK_EM_ANALYSIS && $REDHAWK_EM_REPORT != ""} {
        set fileName $REDHAWK_EM_REPORT
        set fd [open $fileName w]
        foreach_in_collection em_err_file [get_drc_error_data -all *em*] {
                set dm [open_drc_error_data $em_err_file]
                set all_errs [get_drc_errors -error_data $dm *]
                foreach_in_collection err $all_errs {
                        set info [get_attribute $err error_info];
                        puts $fd $info
                }
        }
        close $fd
}

if {$REDHAWK_ANALYSIS == "min_path_resistance"} {
        report_rail_result -type minimum_path_resistance  -supply_nets $REDHAWK_ANALYSIS_NETS $REDHAWK_OUTPUT_REPORT
}

if {$REDHAWK_ANALYSIS == "effective_resistance"} {
        report_rail_result -type effective_resistance  -supply_nets $REDHAWK_ANALYSIS_NETS $REDHAWK_OUTPUT_REPORT
}

if {$REDHAWK_ANALYSIS == "check_missing_via"} {
        report_rail_result -type missing_vias  -supply_nets $REDHAWK_ANALYSIS_NETS $REDHAWK_OUTPUT_REPORT
}

if {$REDHAWK_PGA_NODE != ""} {
	puts "RM-Info: PGA NODE: $REDHAWK_PGA_NODE"
	if {[which $REDHAWK_PGA_ICV_DIR/bin/LINUX.64/icv] == "" } {
        	puts "RM-error: Unable to find icv at \"$REDHAWK_PGA_ICV_DIR/bin/LINUX.64\". Exiting...."

		exit

	} else {
        	puts "RM-info: Setting ICV binary path"
		setenv ICV_HOME_DIR $REDHAWK_PGA_ICV_DIR
	        setenv ICV_INCLUDES [getenv ICV_HOME_DIR]/include/
        	setenv PATH [getenv ICV_HOME_DIR]/bin/LINUX.64:[getenv PATH]

	}

	# ---------------------------------------------------------------------------
	# QOR Reports Pre PGA
	# ---------------------------------------------------------------------------
	if {$REPORT_QOR} {
		set REPORT_PREFIX pre_pga
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor {report_qor -scenarios [all_scenarios] -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
		redirect -tee -append -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor {report_qor -summary -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
		redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_routes {check_routes}
	}

	# ---------------------------------------------------------------------------
	# Run Power Grid Augmentation
	# ---------------------------------------------------------------------------

	if {$REDHAWK_PGA_GROUND_NET == "" || $REDHAWK_PGA_POWER_NET == ""} {
	        puts "RM-error: Please specify one ground net and one power net for PGA.  Exiting...."

		exit

	} 

	# copy_block -from $REDHAWK_IN_DESIGN_PNR_FROM_BLOCK_NAME -to ${REDHAWK_IN_DESIGN_PNR_FROM_BLOCK_NAME}_pga 
	# current_block $DESIGN_LIBRARY:${REDHAWK_IN_DESIGN_PNR_FROM_BLOCK_NAME}_pga
	# link

	remove_host_options -all
        set_host_options -max_cores 16

	set_app_option -name signoff.create_pg_augmentation.ir_aware -value true ;# enables PGA
	set_app_option -name signoff.create_pg_augmentation.ground_net_name -value $REDHAWK_PGA_GROUND_NET 
	set_app_option -name signoff.create_pg_augmentation.power_net_name -value $REDHAWK_PGA_POWER_NET 
	signoff_create_pg_augmentation -node $REDHAWK_PGA_NODE -mode remove
	signoff_create_pg_augmentation -node $REDHAWK_PGA_NODE -mode add

	rm_source -file $REDHAWK_PGA_CUSTOMIZED_SCRIPT -optional -print "REDHAWK_PGA_CUSTOMIZED_SCRIPT"

	save_lib -all

	# ---------------------------------------------------------------------------
	# QOR Reports Post PGA
	# ---------------------------------------------------------------------------
	if {$REPORT_QOR} {
		set REPORT_PREFIX post_pga
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor {report_qor -scenarios [all_scenarios] -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
		redirect -tee -append -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor {report_qor -summary -pba_mode [get_app_option_value -name time.pba_optimization_mode] -nosplit}
		redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_routes {check_routes}
	}
}

print_message_info -ids * -summary
echo [date] > rhsc_in_design_pnr

exit


