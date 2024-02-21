puts "RM-info : Running script [info script]\n"

##########################################################################################
# Tool: RTL Architect
# Script: rtl_setup.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Original:
# source -echo ./rm_setup/design_setup.tcl
# Changed to:
if {[info exists env(ASIP_FLOW)]} {
  source -echo $::env(ASIP_SCRIPTS)/asip_setup.tcl
} else {
  source -echo ./rm_setup/design_setup.tcl
}
######### END CHANGED FOR ASIP SCRIPTS ############

##########################################################################################
# 				RTL SETUP
##########################################################################################
set RTL_PATH 				""
set RTL_READ_SCRIPT			""						 ;# RTL read scripts when user define RTL in RTL_READ_SCRIPTS.
                                             						 ;# This script should contain only analyze command; elaborate and set_top_module is not needed.
######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Changing default value:
# - Setting RTL_PATH to the processor directory
# - Setting RTL_READ_SCRIPT for ASIPS (using auro_read)
if {[info exists env(ASIP_FLOW)]} {
  set RTL_READ_SCRIPT			"asip.RTLA.read_design.tcl"
}
######### END CHANGED FOR ASIP SCRIPTS ##############

##########################################################################################
# 				FLOW SETUP
##########################################################################################
set FLOW				"flat" 					 	 ;# Please define flat || hier || explore
set FLOORPLAN_STYLE 			"channel"					 ;# Supported design styles channel, abutted
set DISTRIBUTED 			"true"					  	 ;# Default value is true. Always use distributed compile. User can change to false if do not have sufficient machine resources.
### It is required to include the set_host_options command to enable distributed mode tasks. For example,

set_host_options -max_cores 8 
set_host_options  -name block_script -submit_command sh
#set_host_options -name block_script -submit_command [list qsub -P bnormal -l mem_free=6G,qsc=o -cwd]
set BLOCK_DIST_JOB_FILE            	""     						 ;# File to set block specific resource requests for distributed jobs
# For example:
#   set_host_options -name block_script  -submit_command "bsub -q normal"
#   set_host_options -name large_block   -submit_command "bsub -q huge"
#   set_host_options -name special_block -submit_command "rsh" local_machine
#   set_app_options -block [get_block block4] -list {plan.distributed_run.block_host large_block}
#   set_app_options -block [get_block block5] -list {plan.distributed_run.block_host large_block}
#   set_app_options -block [get_block block2] -list {plan.distributed_run.block_host special_block}
#  
#   All the jobs associated with blocks that do not have the plan.distributed_run.block_host app option specified
#   will run using the block_script host option. The jobs for blocks block4 and block5 will use the large_block 
#   host option. The job form  block2  will  use  the  special_block host option.
set EARLY_DATA_CHECK_POLICY		"lenient" 					;# none|lenient|strict ;RM default is lenient;
											;# lenient and strict trigger corresponding set_early_data_check_policy -policy $EARLY_DATA_CHECK_POLICY command and report_early_data_checks; 
											;# Specify none to disable the set_early_data_check_policy command

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Changing default value:
# - Setting FLOW automatically in ASIP-specific flows
# - Uncommenting a command to enable distributed mode tasks, required when DISTRIBUTED is true (which is by default)
if {[info exists env(ASIP_FLOW)]} {
  set FLOW				$::env(FLOW)
  set EXPLORE_HOST_OPTIONS  explore_block_script
  set EXPLORE_MAX_CORES      8
  set_host_options  -name $EXPLORE_HOST_OPTIONS -max_cores $EXPLORE_MAX_CORES -submit_command sh
  #set_host_options  -name $EXPLORE_HOST_OPTIONS -max_cores $EXPLORE_MAX_CORES -submit_command [sh|rsh|ssh] -alternate_options $ALTERNATE_OPTIONS -allocated_mem $BLOCK_SCRIPT_ALLOC_MEM {hostnames}
}
######### END CHANGED FOR ASIP SCRIPTS ##############

##########################################################################################
#				HIERARCHICAL FLOW VARIABLES
##########################################################################################
set DP_BLOCK_INSTS                   	[list ]						;# Design names for each physical block (including black boxes) in the design;
                                             						;# This includes bottom and mid level blocks in a Multiple Physical Hierarchy (MPH) design
set ABS_BLOCK_INSTS			[list ]						;# When this variable is empty, all blocks use design view. User can specify block reference to use abstract view.

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Changing default value: setting DP_BLOCK_INSTS from env variable
if {[info exists env(ASIP_FLOW)]} {
  set DP_BLOCK_INSTS                   	$::env(PARTITION_LIST)
  set ABS_BLOCK_INSTS                   $::env(ABSTRACT_BLOCK_LIST)
}
######### END CHANGED FOR ASIP SCRIPTS ##############

##########################################################################################
# 				TECHNOLOGY NODE
##########################################################################################
set NODE         			""			 			 ;# Specify Technology node to apply technology node specific settings to current design through set_technology command.

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Using $TECH_NODE set in asip_lib_setup.tcl
if {[info exists env(ASIP_FLOW)]} {
  set NODE         			$TECH_NODE			 			 ;#
}
######### END CHANGED FOR ASIP SCRIPTS ##############

##########################################################################################
# 				CONSTRAINTS / UPF INTENT
##########################################################################################
set USER_SETTINGS_MAPPING_FILE          ""			 			 ;# Constraint Mapping File. Default is "split/mapfile"
set ENABLE_PRE_RTL_OPT_NETLIST_CHECKS	"true"		 			 	 ;# Default is TRUE to perform prelude checks to foreseen bad RTL coding error.


##########################################################################################
#				DFT INSERTION 
##########################################################################################
set DEFAULT_DFT_MODE 			"true"						 ;# Default value is true,  DFT will be inserted automatically
set DEFAULT_DFT_SETTINGS 		"default_dft_script.tcl"	 		 ;# Default TCL script for DFT settings. Users should review this default script and change the max_length value & scan_clocks etc. based on their design.
set DFT_FLOW                    	""        					 ;# Specify one dft flow out of pre_compile or in_compile 
set DFT_MODES_LIST              	""        				  	 ;# List of DFT modes defined by the DFT setup

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Changing default value: Disabling insertion of DFT
if {[info exists env(ASIP_FLOW)]} {
  set DEFAULT_DFT_MODE 			"false"
}
######### END CHANGED FOR ASIP SCRIPTS ##############

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
##########################################################################################
#				Functional Safety
##########################################################################################
set ENABLE_FUSA         "false" ;# By default false, enabled, if DCLS is generated for the model.
set ENABLE_DCLS_CLOCK_SPLIT  "false"  ;# if enabled, DCLS_CLOCK_SPLIT_BUF must be set.
set ENABLE_DCLS_BOUNDARY_PROTECTION "false" ;# if enabled, DCLS_BOUNDARY_PROTECTION_BUF must be set.
set ENABLE_DCLS_SCAN_PROTECTION  "false" ;#can be enabled if DFT is inserted

######### END CHANGED FOR ASIP SCRIPTS ##############

##########################################################################################
# 				SPLIT CONSTRAINTS
##########################################################################################
set EXPERT_SPLIT_CONSTRAINTS_MODE	"false"						 ;# Default value is false. User can turn this on to customize the split_constraints (IO budegting) settings.
set EXPERT_SPLIT_CONSTRAINTS_SETTINGS	"expert.split.constraints.settings.tcl"  	 ;# TCL script for expert split_constraints settings.


##########################################################################################
# 				FLOORPLAN CREATIONS/CONFIGURATIONS
##########################################################################################
set ALLOW_FEEDTHROUGH			"true"						 ;# By default, this option is true and new feedthroughs can be created.
set AUTO_FLOORPLAN_UTILIZATION		"0.7"						 ;# User define the target utilization.
set EXPERT_FLOORPLAN_MODE		"false" 					 ;# Default value is false. User can turn this on to customize the autofloorplan settings. 
set EXPERT_FLOORPLAN_SETTINGS 		"expert.floorplan.settings.tcl" 		 ;# TCL script for expert floorplan settings.
set TCL_PHYSICAL_CONSTRAINTS_FILE      	"" 						 ;# TCL script for primary die area creation. If specified, DEF_FLOORPLAN_FILES will be loaded after TCL_PHYSICAL_CONSTRAINTS_FILE


##########################################################################################
#				METRICS REPORTING
##########################################################################################
set FSDB_FILE				""						 ;# RTL activity file.
set FSDB_SOURCE_INSTANCE		""						 ;# FSDB_FILE related; name of the instance of the current design as it appears in FSDB file.
set FSDB_POWER_SCENARIO			"" 						 ;# FSDB_FILE related; specify the power scenario name used for RTL power analysis.
set PWR_SHELL_PATH          		"" 						 ;# Specify the  PrimePower binary path for for computing Power Metrics.
set SORT_BY_CONGESTION_METRICS		"metrics_cong_number_cells_in_cong_area_local"	 ;# User may choose ONE from the list to display the detailed congestion report : metrics_cong_number_cells_in_cong_area_local, metrics_cong_percent_cells_in_cong_area_local, metrics_cong_percent_of_cong_area_local, metrics_cong_logic_cong_local, metrics_cong_number_cells_in_cong_channel_local, metrics_cong_number_cells_local, metrics_cong_overflow_local, metrics_cong_local_net_count_local, metrics_cong_global_net_count_local
set SORT_BY_TIMING_METRICS    		"metrics_tim_bottleneck_count" 			 ;# User may choose ONE from the list to display the detailed timing report : metrics_tim_bottleneck_count, metrics_tim_wns_total, metrics_tim_wns_io, metrics_tim_wns_r2r, metrics_tim_tns_total , metrics_tim_tns_io, metrics_tim_tns_r2r, metrics_tim_nvp_total, metrics_tim_nvp_io, metrics_tim_nvp_r2r
set SORT_BY_POWER_METRICS  		"total_power"  				 	 ;# User may choose ONE from the list to display the detailed power report : total_power, internal_power, switching_power, leakage_power

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Changing default value: if pwr_shell is loaded
if {[info exists env(ASIP_FLOW)]} {
  set METRICS_PWR_SCENARIO "func::ss" ;# To be check if this should be given
  if {![catch { exec which pwr_shell}] } {
   set PWR_SHELL_PATH 			[exec which pwr_shell]
  }
}
######### END CHANGED FOR ASIP SCRIPTS ##############

##########################################################################################
# 				EXPLORATION (For explore design)
##########################################################################################
set EXPLORE_UTILIZATION_LIST   		"0.7 0.8" 					 ;# Specify Utilization ratio(s) for exploration.
set EXPLORE_ASPECT_RATIO_LIST  		"1:2 1:4"					 ;# Specify aspect ratio(s) for exploration.
set EXPLORE_MAX_ROUTING_LAYER_LIST	""						 ;# Specify max routing layer(s) for exploration.

set EXPERT_EXPLORE_VARIABLE_MODE  	"false"  					 ;# Specify "true" for using varaible list exploration and set below two varaibles.
											 ;# If true,then specify value for EXPERT_EXPLORE_SETTINGS and EXPLORE_DESIGN_VARIABLE_LIST.

set EXPERT_EXPLORE_SETTINGS	  	"explore_design_example.tcl"  			 ;# Specify a User TCL script. Use it as a template and edit before use or provide your own script. 
											 ;# This user script gets sourced by the explore_design command for each experiment it generates.
											 ;# Refer Template script "explore_design_example.tcl" in rm_rtl_explore_scripts directory for examples on Frequency sweep, Floorplan sweep and App_option/macro placement sweep. Edit this to use.
											 ;# This script will only get sourced if the following conditions are met: 
											 ;# (1) EXPERT_EXPLORE_VARIABLE_MODE is true (2) EXPLORE_DESIGN_VARIABLE_LIST is specified.
											 ;# Floorplan sweep should not run with utilization sweep i.e. EXPLORE_UTILIZATION_LIST
set EXPLORE_DESIGN_VARIABLE_LIST  	"" 						 ;# Specify Variable list. Variables which are used in template script "explore_design_example.tcl"
											 ;# Example: { freq1 { 2 2.2 } freq2 { 3 3.3 } } for frequency sweep.
											 ;# Example: { height { -5 7 0 } width { -5 3 0 } } for floorplan sweep.

set EXPLORE_LIBRARY_LIST   		"" 						 ;# Specify the list of library for exploration. Example: { {saed32hvt saed32hvt_pg} { saed32lvt saed32lvt_pg } }.

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Changing default value of exploration parameter list to values in env. varibles
# Adding variable for list of RTL blocks, and list of frequencies
if {[info exists env(ASIP_FLOW)]} {
  set EXPLORE_UTILIZATION_LIST        $::env(UTILIZATION_LIST)            ;# Specify Utilization ratio(s) for exploration.
  set EXPLORE_ASPECT_RATIO_LIST       $::env(ASPECT_RATIO_LIST)           ;# Specify aspect ratio(s) for exploration.
  set EXPLORE_MAX_ROUTING_LAYER_LIST  $::env(MAX_ROUTING_LAYER_LIST)          ;# Specify max routing layer(s) for exploration.
  set EXPLORE_LIBRARY_LIST            $::env(LIBRARY_LIST)
  set EXPLORE_RTL_ID_LIST             $::env(RTL_ID_LIST)
  set EXPLORE_RTL_BLOCKS_LIST         ""                                    ;# Specify rtl block(s) for exploration, based on RTL_ID_LIST (@ explore_pre_script)
  set EXPLORE_RTL_FREQ_LIST           $::env(FREQ_LIST)                     ;# Specify frequency(ies) for exploration, if this is not an empty list, then 
                                                                          ;# EXPLORE_DESIGN_VARIABLE_LIST is defined and EXPERT_EXPLORE_VARIABLE_MODE = true (@ explore_pre_script)
}
######### END CHANGED FOR ASIP SCRIPTS ##############

##########################################################################################
#				SANITY CHECKER
##########################################################################################
# Sanity Checker is a script utility to compare two different versions of your design and design environment. Helps to check consistency between runs or sessions to identify discrepancies in design constraints, settings etc.
# If you want to compare and report the differences or inconsistencies between two runs, please use sanity_check command. For example: sanity_check -report RTP1 -ref_report RTP2"
# You can download the sanity checker utility from Solvnet.
# https://solvnetplus.synopsys.com/s/article/Utility-for-Identifying-Inconsistencies-Between-Design-Compiler-and-IC-Compiler-II-Settings-1576172057839

##########################################################################################
# 				Variables for pre and post plugins 
##########################################################################################
set TCL_USER_INIT_DESIGN_POST_SCRIPT 		""					  ;# An optional Tcl file to be sourced at the end of init_design.tcl before save_block.

set TCL_USER_CONDITIONING_PRE_SCRIPT		"user_conditioning_pre_script.tcl"	  ;# An optional Tcl file for rtl_opt.tcl and conditioning.tcl to be sourced before conditioning. Edit this file to change default app settings for CCD, MBIT, DTDP and Congestion effort.
set TCL_USER_CONDITIONING_POST_SCRIPT		""					  ;# An optional Tcl file for rtl_opt.tcl and conditioning.tcl to be sourced after conditioning.

set TCL_USER_ESTIMATION_PRE_SCRIPT		""					  ;# An optional Tcl file for rtl_opt.tcl and estimation.tcl to be sourced before estimation.
set TCL_USER_ESTIMATION_POST_SCRIPT		""					  ;# An optional Tcl file for rtl_opt.tcl and estimation.tcl to be sourced after estimation.

set TCL_USER_SPLIT_CONSTRAINTS_PRE_SCRIPT	""					  ;# An optional Tcl file for splits.tcl to be sourced before split_constraints.
set TCL_USER_SPLIT_CONSTRAINTS_POST_SCRIPT	""					  ;# An optional Tcl file for splits.tcl to be sourced after split_constraints.
set TCL_USER_COMMIT_PRE_SCRIPT			""					  ;# An optional Tcl file for splits.tcl to be sourced before commit.
set TCL_USER_COMMIT_POST_SCRIPT			""					  ;# An optional Tcl file for splits.tcl to be sourced after commit.

set TCL_USER_FLOORPLANNING_PRE_SCRIPT		""					  ;# An optional Tcl file for floorplanning.tcl to be sourced before floorplanning. 
set TCL_USER_FLOORPLANNING_POST_SCRIPT		""					  ;# An optional Tcl file for floorplanning.tcl to be sourced after floorplanning.

set TCL_USER_METRICS_PRE_SCRIPT			""					  ;# An optional Tcl file for metrics.tcl to be sourced before metrics.
set TCL_USER_METRICS_POST_SCRIPT		""					  ;# An optional Tcl file for metrics.tcl to be sourced after metrics.

set TCL_USER_EXPLORE_PRE_SCRIPT			""					  ;# An optional Tcl file for explore_design.tcl to be sourced before explore_design.
set TCL_USER_EXPLORE_POST_SCRIPT		""					  ;# An optional Tcl file for explore_design.tcl to be sourced after explore_design.

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Setting the user_plugin_script to use in the ASIP-flows
if {[info exists env(ASIP_FLOW)]} {
  set TCL_USER_INIT_DESIGN_POST_SCRIPT    "init_design_post_script.tcl"
  set TCL_USER_EXPLORE_PRE_SCRIPT         "explore_pre_script.tcl"
  set EXPERT_EXPLORE_SETTINGS             "explore_user_script.tcl"
}
######### END CHANGED FOR ASIP SCRIPTS ##############

##########################################################################################
# 				System Variables (DO NOT CHANGE BELOW ITEMS)
##########################################################################################
set WORK_DIR                       	"./work"
if !{[file exists $WORK_DIR]} {file mkdir $WORK_DIR}

set INIT_DESIGN_LABEL_NAME      	"init_design"
set CONDITIONING_LABEL_NAME     	"conditioning"
set ESTIMATION_LABEL_NAME               "estimation"
set SPLIT_CONSTRAINTS_LABEL_NAME 	"split_constraints"
set COMMIT_LABEL_NAME			"commit"
set BLOCK_CONDITIONING_LABEL_NAME       "block_conditioning"
set TOP_CONDITIONING_LABEL_NAME         "top_conditioning"
set FLOORPLANNING_LABEL_NAME            "floorplanning"
set BLOCK_ESTIMATION_LABEL_NAME         "block_estimation"
set TOP_ESTIMATION_LABEL_NAME           "top_estimation"
set METRICS_LABEL_NAME                  "metrics"
set EXPLORE_DESIGN_LABEL_NAME		"explore_design"
set RTL_OPT_LABEL_NAME			"rtl_opt"
set SPLITS_LABEL_NAME			"splits"

## Directories
set OUTPUTS_DIR	"./outputs_rtl"								;# Directory to write output data files; mainly used by write_data.tcl
set REPORTS_DIR	"./rpts_rtl"								;# Directory to write reports; mainly used by report_qor.tcl
if !{[file exists $REPORTS_DIR]} {file mkdir $REPORTS_DIR}
if !{[file exists $OUTPUTS_DIR]} {file mkdir $OUTPUTS_DIR}


######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Original:
# set search_path [list ./rm_rtl_flat_scripts ./rm_rtl_hier_scripts ./rm_rtl_explore_scripts $WORK_DIR ] 
#
# lappend search_path .
# Changed to:
if {[info exists env(ASIP_FLOW)]} {
  lappend search_path ./rm_rtl_flat_scripts ./rm_rtl_hier_scripts ./rm_rtl_explore_scripts $WORK_DIR
  lappend search_path {*}${ADDITIONAL_SEARCH_PATH}

   ## The default number of significant digits used to display values in reports
   set_app_options -name shell.common.report_default_significant_digits -value 3 ;# tool default is 2/

   if {[file exists [which $ADDITIONAL_RTL_SETUP]]} {
			source -echo $ADDITIONAL_RTL_SETUP
	}

} else {
  set search_path [list ./rm_rtl_flat_scripts ./rm_rtl_hier_scripts ./rm_rtl_explore_scripts $WORK_DIR ]
  lappend search_path .
}
######### END CHANGED FOR ASIP SCRIPTS ############

puts "RM-info : Completed script [info script]\n"

