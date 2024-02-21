##########################################################################################
# Tool: RTL Architect
# Script: metrics.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
source -echo ./rm_setup/rtl_setup.tcl 

##########################################################################################
# Open Library and Block
##########################################################################################
open_lib   ${WORK_DIR}/${DESIGN_LIBRARY} -ref_libs_for_edit

switch ${FLOW} {
   flat {
    	open_block ${DESIGN_NAME}/${RTL_OPT_LABEL_NAME} 
	puts "RM-info : Open block ${DESIGN_NAME}/${RTL_OPT_LABEL_NAME}\n"
   }
   hier {
    	open_block ${DESIGN_NAME}/${ESTIMATION_LABEL_NAME}
	puts "RM-info : Open block ${DESIGN_NAME}/${ESTIMATION_LABEL_NAME}\n"
   }
      default {
     	puts "RM-Error: Please specify your flow as hier || flat. \n"
   }
}

save_block -hier -force -label ${METRICS_LABEL_NAME}
close_lib  -purge -force -all
open_block ${WORK_DIR}/${DESIGN_LIBRARY}:${DESIGN_NAME}/${METRICS_LABEL_NAME} -ref_libs_for_edit


##########################################################################################
# Pre RTL Metrics Customizations
##########################################################################################
if {[file exists [which $TCL_USER_METRICS_PRE_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_METRICS_PRE_SCRIPT]"
        source $TCL_USER_METRICS_PRE_SCRIPT
} elseif {$TCL_USER_METRICS_PRE_SCRIPT != ""} {
        puts "RM-error : TCL_USER_METRICS_PRE_SCRIPT($TCL_USER_METRICS_PRE_SCRIPT) is invalid. Please correct it."
}


##########################################################################################
# Metrics (Congestion, Timing and Power) - Reports & Queries
##########################################################################################
set_app_options -list {metrics.timing.max_paths 50} 						 ; # Specifies  the  maximum  number of violating paths. Default is 50, increasing it may impact runtime.

set metrics_cmd "compute_metrics -congestion -timing"

if {$DISTRIBUTED} {
         set HOST_OPTIONS "block_script"
      } else {
         set HOST_OPTIONS ""
      }


if {$FLOW == "hier" } {
	lappend metrics_cmd  -hierarchical -all_blocks 
	puts "RM-info : Design run in Hier mode. Compute metrics of $DESIGN_NAME all blocks. \n"
	if {$DISTRIBUTED} {
		lappend metrics_cmd -multi_host_options $HOST_OPTIONS  
	}

}
# Congestion and Timing Metrics Computation 
echo $metrics_cmd
eval $metrics_cmd


set metrics_power_cmd "compute_metrics -power"
if {$PWR_SHELL_PATH != ""} { 
  set metrics_power_analysis_options_cmd "set_rtl_power_analysis_options  -pwr_shell ${PWR_SHELL_PATH}"
  if {[file exists [which $FSDB_FILE]]} {
	if { [info exists metrics_power_analysis_options_cmd] } {
	  lappend metrics_power_analysis_options_cmd  -fsdb ${FSDB_FILE} 
	  if { [info exists FSDB_SOURCE_INSTANCE] && $FSDB_SOURCE_INSTANCE != "" } {
		lappend metrics_power_analysis_options_cmd -strip_path $FSDB_SOURCE_INSTANCE
	  }
	  if { [info exists FSDB_POWER_SCENARIO] && $FSDB_POWER_SCENARIO != "" } {
		lappend metrics_power_analysis_options_cmd -scenario $FSDB_POWER_SCENARIO
	  }

	}
  } elseif {[file exists [which $SAIF_FILE_LIST]] && [llength $SAIF_FILE_LIST] == 1} {
	if {[file exists [which $SAIF_FILE_LIST]]}  {
	  if { [info exists metrics_power_analysis_options_cmd] } {	
######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Enhancement: add option -postcmds to report_switching_activity
# Original:
#		lappend metrics_power_analysis_options_cmd  -saif ${SAIF_FILE_LIST}
# Changed to:
		lappend metrics_power_analysis_options_cmd  -saif [which ${SAIF_FILE_LIST}] \
				-postcmds "report_switching_activity -include_mapping_types > ${REPORTS_DIR}/${DESIGN_NAME}.switching_activity.pp.rpt"
######### END CHANGED FOR ASIP SCRIPTS ##############
        if { [info exists SAIF_FILE_SOURCE_INSTANCE] && $SAIF_FILE_SOURCE_INSTANCE != "" } {
		  lappend metrics_power_analysis_options_cmd -strip_path $SAIF_FILE_SOURCE_INSTANCE
		}
		if { [info exists SAIF_FILE_POWER_SCENARIO] && $SAIF_FILE_POWER_SCENARIO != "" } {
		  lappend metrics_power_analysis_options_cmd -scenario $SAIF_FILE_POWER_SCENARIO
		}
	  }
	} else {
	  puts "RM-error: SAIF_FILE_LIST variable is defined but file does not exist, power metrics will run with default activity. \n"
	}
  } elseif {![file exists [which $SAIF_FILE_LIST]] && ![file exists [which $FSDB_FILE]]} {
	puts "RM-Warning: PWR_SHELL_PATH is defined but FSDB or SAIF not defined, power metrics will run with default activity. \n" 
  }

  echo $metrics_power_analysis_options_cmd
  eval $metrics_power_analysis_options_cmd

  set_ideal_network [get_nets -of_objects [get_clock_tree_pins]]

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Following RTL SAIF Flow for FC/PP:
# setting -essential option for writing out saif-map
  setConf ESSENTIAL_NAMEMAP 1
######### END CHANGED FOR ASIP SCRIPTS ############

  #Power Metrics Computation
  echo $metrics_power_cmd  
  eval $metrics_power_cmd
} else {
  puts "RM-Error: PWR_SHELL_PATH is not specified. Please define PWR_SHELL_PATH to compute power metrics for the design. \n"
  puts "RM-Error: Power Metrics is not executed. \n"
}

#-------------------------------------------------------------------------------------------#
# Congestion Metrics
#-------------------------------------------------------------------------------------------#

# Congestion summary for Top-level hierarchy and all it's descendants (child logical hierarchies) 
report_metrics  -congestion  > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.congestion.summary.rpt

# Congestion metrics report (table format) for each module in the design considering only the cells local to the logic hierarchy and excluding cells that belong to it's child modules
# And, table is sorted based on the contribution of each logical hierarchy in the design to a specific congestion metric. Here, it is sorted based on how many cells of the hierarchy are within congestion hotspots.

if {$SORT_BY_CONGESTION_METRICS != ""} {
    if {[sizeof_collection [get_cells -hierarchical -filter "is_hierarchical && hierarchy_type == normal" -quiet ]] } {
	set congested_cells_metrics [list ]
	foreach_in_collection LH [get_cells -hierarchical -filter "is_hierarchical && hierarchy_type == normal"] {
	    if {[get_attribute [get_cells $LH] $SORT_BY_CONGESTION_METRICS] !=""} {
		lappend congested_cells_metrics "[get_object_name $LH] [get_attribute [get_cells $LH] $SORT_BY_CONGESTION_METRICS]"
	    }
	}
	set congested_cells_metrics [lsort -integer -index 1 -decreasing $congested_cells_metrics]
	set LH_instances [list ]
	foreach LH $congested_cells_metrics {lappend LH_instances [lindex $LH 0]}
	if {[llength $LH_instances] > 0} {
		report_metrics -congestion -cells $LH_instances -table -local > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.congestion.detailed.rpt
	}
    }
}

# Nworst Congested Hierarchies
get_metrics -nworst 10 -metric metrics_cong_number_cells -local > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.congestion.nworst_congested_hierarchies.rpt
# Nworst Logic Congested Hierarchies (Logic-Structure Induced Congestion) 
get_metrics -nworst 10 -metric metrics_cong_number_cells_in_cong_area -local > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.congestion.nworst_logic_congested_hierarchies.rpt
# Nworst Channel Congested Hierarchies (Narrow Channel or Floorplan Congestion) 
get_metrics -nworst 10 -metric metrics_cong_number_cells_in_cong_channel -local > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.congestion.nworst_channel_congested_hierarchies.rpt

# Nworst RTL lines which generates most congested cells
get_metrics -metric metrics_cong_number_cells_in_cong_area -rtl_worst_lines 10  > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.congestion.rtl_worst_lines.rpt 

# To report number of congested cells generated by rtl.v, line 10.
# get_metrics -rtl_line {rtl.v 10} -metrics metrics_cong_number_cells_in_cong_area 

# To list all congested cells generated by rtl.v, line 10.
# get_metrics -rtl_line {rtl.v 10} -metrics metrics_cong_number_cells_in_cong_area  -detail

#-------------------------------------------------------------------------------------------#
# Timing Metrics
#-------------------------------------------------------------------------------------------#

# Timing summary for Top-level hierarchy and all it's descendants (child logical hierarchies) 
report_metrics  -timing      > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.timing.summary.rpt

if {$SORT_BY_TIMING_METRICS != ""} {
    if {[sizeof_collection [get_cells -hierarchical -filter "is_hierarchical && hierarchy_type == normal" -quiet ]] } {
        set timing_cells_metrics [list ]	
        foreach_in_collection LH [get_cells -hierarchical -filter "is_hierarchical && hierarchy_type == normal"] {
            if {[get_attribute [get_cells $LH] $SORT_BY_TIMING_METRICS] !=""} {
                lappend timing_cells_metrics "[get_object_name $LH] [get_attribute [get_cells $LH] $SORT_BY_TIMING_METRICS]"
            }
        }
        set timing_cells_metrics [lsort -integer -index 1 -decreasing $timing_cells_metrics]
        set LH_instances [list ]
        foreach LH $timing_cells_metrics {lappend LH_instances [lindex $LH 0]}
        if {[llength $LH_instances] > 0} {
  	        report_metrics -timing -cells $LH_instances -table -local > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.timing.detailed.rpt
        }
    }
}

# Nworst R2R wns
get_metrics -nworst 10 -metric metrics_tim_wns_r2r -local > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.timing.nworst_tim_wns_r2r.rpt
# Nworst R2R tns
get_metrics -nworst 10 -metric metrics_tim_tns_r2r -local > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.timing.nworst_tim_tns_r2r.rpt
# Nworst R2R nvp
get_metrics -nworst 10 -metric metrics_tim_nvp_r2r -local > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.timing.nworst_tim_nvp_r2r.rpt

#-------------------------------------------------------------------------------------------#
# Power Metrics
#-------------------------------------------------------------------------------------------#
# Power summary for Top-level hierarchy and all it's descendants (child logical hierarchies)
report_metrics  -power -scenario ${SAIF_FILE_POWER_SCENARIO} > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.power.summary.rpt

if {$SORT_BY_POWER_METRICS != ""} {
    if {[sizeof_collection [get_cells -hierarchical -filter "is_hierarchical && hierarchy_type == normal" -quiet ]] } {
	set power_cells_metrics [list ]
	foreach_in_collection LH [get_cells -hierarchical -filter "is_hierarchical && hierarchy_type == normal"] {
	    if {[get_attribute [get_cells $LH] $SORT_BY_POWER_METRICS] !=""} {
		lappend power_cells_metrics "[get_object_name $LH] [get_attribute [get_cells $LH] $SORT_BY_POWER_METRICS]"
	    }
	}
 	set power_cells_metrics [lsort -index 1 -decreasing $power_cells_metrics]
 	set LH_instances [list ]
 	foreach LH $power_cells_metrics {lappend LH_instances [lindex $LH 0]}
	if {[llength $LH_instances] > 0} {
		report_metrics -power -cells $LH_instances -table -local > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.power.detailed.rpt
 	}
    }
}

# Nworst contribute to total power 
get_metrics -nworst 10 -metric total_power  > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.power.nworst_total_power.rpt
# Nworst contribute to internal power 
get_metrics -nworst 10 -metric internal_power  > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.power.nworst_internal_power.rpt
# Nworst contribute to switching power 
get_metrics -nworst 10 -metric switching_power  > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.power.nworst_switching_power.rpt
# Nworst contribute to leakage power 
get_metrics -nworst 10 -metric leakage_power  > ./${REPORTS_DIR}/${DESIGN_NAME}.metrics.power.nworst_leakage_power.rpt


##########################################################################################
# Post RTL Metrics Customizations
##########################################################################################
if {[file exists [which $TCL_USER_METRICS_POST_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_METRICS_POST_SCRIPT]"
        source $TCL_USER_METRICS_POST_SCRIPT
} elseif {$TCL_USER_METRICS_POST_SCRIPT != ""} {
        puts "RM-error : TCL_USER_METRICS_POST_SCRIPT($TCL_USER_METRICS_POST_SCRIPT) is invalid. Please correct it."
}


#########################################################################################
# Advance Reports
###########################################################################################
set DATE [sh date +%F:%H:%M]

# ----------------------------------------
# Basic Reports
# ---------------------------------------
redirect ${REPORTS_DIR}/${DESIGN_NAME}.design.${DATE}.rpt	      { report_design -all}
redirect ${REPORTS_DIR}/${DESIGN_NAME}.check_timing.${DATE}.rpt       { check_timing -all }
redirect ${REPORTS_DIR}/${DESIGN_NAME}.clock.${DATE}.rpt              { report_clock }

if {$COMPILE_ACTIVE_SCENARIO_LIST != ""} {
        set_scenario_status -active false [get_scenarios -filter active]
        set_scenario_status -active true $COMPILE_ACTIVE_SCENARIO_LIST
}
redirect ${REPORTS_DIR}/${DESIGN_NAME}.scenarios.${DATE}.rpt          { report_scenarios }


# ----------------------------------------
# Area
# ----------------------------------------
redirect ${REPORTS_DIR}/${DESIGN_NAME}.area.${DATE}.rpt               { report_area }
redirect -append ${REPORTS_DIR}/${DESIGN_NAME}.area.${DATE}.rpt       { report_reference }
redirect ${REPORTS_DIR}/${DESIGN_NAME}.area_hier.${DATE}.rpt          { report_reference -hierarchical }
redirect ${REPORTS_DIR}/${DESIGN_NAME}.area.hier.${DATE}.rpt          { report_area -hierarchy -nosplit }
redirect ${REPORTS_DIR}/${DESIGN_NAME}.qor_summary.${DATE}.rpt        { report_qor -summary }
redirect ${REPORTS_DIR}/${DESIGN_NAME}.utilization.${DATE}.rpt        { report_utilization }
redirect ${REPORTS_DIR}/${DESIGN_NAME}.congestion.${DATE}.rpt         { report_congestion } 

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
if {[info exists env(ASIP_FLOW)]} {
	redirect ${REPORTS_DIR}/${DESIGN_NAME}.qor.${DATE}.rpt        { report_qor ; report_qor -summary }
}
######### END CHANGED FOR ASIP SCRIPTS ############

# ----------------------------------------
# TIMING REPORTS
# ----------------------------------------
redirect ${REPORTS_DIR}/${DESIGN_NAME}.global_timing.${DATE}.rpt       { report_global_timing }
redirect ${REPORTS_DIR}/${DESIGN_NAME}.timing_per_scenario.${DATE}.rpt { report_metrics -timing -scenario [get_scenarios * -filter "active==true"] -table }
foreach_in_col sc [get_scenarios -f "active==true"] {
redirect ${REPORTS_DIR}/${DESIGN_NAME}.top50_timingpaths.[get_attr $sc name].${DATE}.rpt         { report_timing  -max_paths 50 -nworst 1 -nets -derate -scenario $sc }
}

# ----------------------------------------
# POWER REPORTS
# ----------------------------------------
redirect ${REPORTS_DIR}/${DESIGN_NAME}.power_metrics.${DATE}.rpt     { report_metrics -power }  
redirect ${REPORTS_DIR}/${DESIGN_NAME}.power.${DATE}.rpt             { report_power }
redirect ${REPORTS_DIR}/${DESIGN_NAME}.clock_gating.${DATE}.rpt      { report_clock_gating }
redirect ${REPORTS_DIR}/${DESIGN_NAME}.multibit.${DATE}.rpt          { report_multibit -hierarchical }
redirect ${REPORTS_DIR}/${DESIGN_NAME}.threshold_voltage_groups.${DATE}.rpt       { report_threshold_voltage_groups }


####################################
## FUSA
####################################
if {$ENABLE_FUSA} {
	puts "RM-info: Running FuSa Safety Report...\n"
	redirect -file ${REPORTS_DIR}/${DESIGN_NAME}.report_safety_status {report_safety_status}
	redirect -file ${REPORTS_DIR}/${DESIGN_NAME}.report_fsm {report_fsm -all -verbose}
}

##########################################################################################
# Save and Exit
##########################################################################################
save_lib -all
echo [date] > metrics
exit

