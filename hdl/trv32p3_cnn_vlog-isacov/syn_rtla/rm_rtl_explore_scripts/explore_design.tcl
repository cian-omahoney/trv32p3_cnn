##########################################################################################
# Tool: RTL Architect
# Script: explore_design.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
source -echo ./rm_setup/rtl_setup.tcl

##########################################################################################
# Open Library and Block
##########################################################################################
open_lib   ${WORK_DIR}/${DESIGN_LIBRARY} -ref_libs_for_edit
open_block ${DESIGN_NAME}/${INIT_DESIGN_LABEL_NAME}
save_block -hier -force -label ${EXPLORE_DESIGN_LABEL_NAME}
close_lib  -purge -force -all
open_block ${WORK_DIR}/${DESIGN_LIBRARY}:${DESIGN_NAME}/${EXPLORE_DESIGN_LABEL_NAME} -ref_libs_for_edit

##########################################################################################
# Pre RTL Explore Design Customizations
##########################################################################################
if {$PWR_SHELL_PATH != ""} { 
  set_rtl_power_analysis_options -pwr_shell $PWR_SHELL_PATH
} else {
  puts "RM-error : PWR_SHELL_PATH is not specified. Please define PWR_SHELL_PATH to compute power metrics. \n"
}


if {[file exists [which $TCL_USER_EXPLORE_PRE_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_EXPLORE_PRE_SCRIPT]"
        source $TCL_USER_EXPLORE_PRE_SCRIPT
} elseif {$TCL_USER_EXPLORE_PRE_SCRIPT != ""} {
        puts "RM-error : TCL_USER_EXPLORE_PRE_SCRIPT($TCL_USER_EXPLORE_PRE_SCRIPT) is invalid. Please correct it."
}

set set_explore_design_options_cmd "set_explore_design_options "

if {$EXPLORE_UTILIZATION_LIST  != ""} { 
  lappend set_explore_design_options_cmd -utilization $EXPLORE_UTILIZATION_LIST
}

if {$EXPLORE_ASPECT_RATIO_LIST != ""} { 
  lappend set_explore_design_options_cmd -aspect_ratio $EXPLORE_ASPECT_RATIO_LIST 
}

if {$EXPLORE_MAX_ROUTING_LAYER_LIST != ""} { 
  lappend set_explore_design_options_cmd -max_routing_layer $EXPLORE_MAX_ROUTING_LAYER_LIST
} elseif {$MAX_ROUTING_LAYER != ""} {
  lappend set_explore_design_options_cmd -max_routing_layer $MAX_ROUTING_LAYER
}

# Refer explore_design_example.tcl and create user script or edit template script, define EXPERT_EXPLORE_SETTINGS and EXPLORE_DESIGN_VARIABLE_LIST accordingly to run sweep experiments.
if {$EXPERT_EXPLORE_VARIABLE_MODE == "true"} {
 if {[info exist EXPERT_EXPLORE_SETTINGS] && [ info exist EXPLORE_DESIGN_VARIABLE_LIST]} { 
######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Adding 'which' command to use file found in search path
# Original:
# 	lappend set_explore_design_options_cmd -user_script $EXPERT_EXPLORE_SETTINGS  -var_list $EXPLORE_DESIGN_VARIABLE_LIST
    lappend set_explore_design_options_cmd -user_script [which $EXPERT_EXPLORE_SETTINGS]  -var_list $EXPLORE_DESIGN_VARIABLE_LIST
######### END CHANGED FOR ASIP SCRIPTS ############
 } else {
	puts " RM-error : Please specify value for EXPERT_EXPLORE_SETTINGS and EXPLORE_DESIGN_VARIABLE_LIST variable in rtl_setup.tcl. \n"
	} 
}

if {$EXPLORE_LIBRARY_LIST != ""} { 
  lappend set_explore_design_options_cmd -library $EXPLORE_LIBRARY_LIST 
}

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Adding support for exploration of RTL blocks and enabling use of switching activity files
if {[info exists env(ASIP_FLOW)] && $EXPLORE_RTL_BLOCKS_LIST != ""} {
  lappend set_explore_design_options_cmd -block_rtl $EXPLORE_RTL_BLOCKS_LIST -include $EXPLORE_INCLUDE_LIST
} elseif { [info exists env(ASIP_FLOW)] } {
  if {![file exists [which $SAIF_FILE_LIST]] && ![file exists [which $FSDB_FILE]]} {
        puts "RM-Warning: FSDB or SAIF not defined, power metrics will run with default activity. \n" 
  } else {
    if {[file exists [which $FSDB_FILE]]} {
        set metrics_power_analysis_options_cmd "set_rtl_power_analysis_options -fsdb ${FSDB_FILE}"
        if { [info exists FSDB_SOURCE_INSTANCE] && $FSDB_SOURCE_INSTANCE != "" } {
            lappend metrics_power_analysis_options_cmd -strip_path $FSDB_SOURCE_INSTANCE
        }
        if { [info exists FSDB_POWER_SCENARIO] && $FSDB_POWER_SCENARIO != "" } {
            lappend metrics_power_analysis_options_cmd -scenario $FSDB_POWER_SCENARIO
        }
    } elseif {[file exists [which $SAIF_FILE_LIST]] && [llength $SAIF_FILE_LIST] == 1} {
        if { ![info exists metrics_power_analysis_options_cmd] } {
            set metrics_power_analysis_options_cmd "set_rtl_power_analysis_options"
        }
        lappend metrics_power_analysis_options_cmd -saif [which $SAIF_FILE_LIST] \
            -postcmds "report_switching_activity -include_mapping_types > [getConf OUTPUT_DIR]/${DESIGN_NAME}.switching_activity.pp.rpt"
        if { [info exists SAIF_FILE_SOURCE_INSTANCE] && $SAIF_FILE_SOURCE_INSTANCE != "" } {
            lappend metrics_power_analysis_options_cmd -strip_path $SAIF_FILE_SOURCE_INSTANCE
        }
        if { [info exists SAIF_FILE_POWER_SCENARIO] && $SAIF_FILE_POWER_SCENARIO != "" } {
            lappend metrics_power_analysis_options_cmd -scenario $SAIF_FILE_POWER_SCENARIO
        }
    }
    echo $metrics_power_analysis_options_cmd
    eval $metrics_power_analysis_options_cmd
  }
}
######### END CHANGED FOR ASIP SCRIPTS ############

echo $set_explore_design_options_cmd
eval $set_explore_design_options_cmd

#Warning: set_explore_design_options cannot set shape, side_ratio, side_length, or aspect_ratio the same time. shape will take effect.

#For reference perpose, three example use model of sweep experiment ( frequency sweep , floorplan sweep  and macro_placement sweep ) is provided under rm_rtl_explore_scripts.

##########################################################################################
# Run RTL Explore Design
##########################################################################################
# Setup host options if running distributed
if {$DISTRIBUTED} {
  ######### BEGIN CHANGED FOR ASIP SCRIPTS ############
  if {[info exists env(ASIP_FLOW)]} {
     set HOST_OPTIONS "-host_options $EXPLORE_HOST_OPTIONS"
  } else {
  #Original:
     set HOST_OPTIONS "-host_options block_script"
  }
  ######### END CHANGED FOR ASIP SCRIPTS ############
} else {
     set HOST_OPTIONS ""
}

explore_design -report_only

eval "explore_design ${HOST_OPTIONS}"

##########################################################################################
# Compatible WebBrowser to open HTML file
##########################################################################################
# Firefox 40+ ( Linux or Windows )
# Firefox 68+ : Browser has restriction to open the file which is under group permission. 
# 	To resolve Type 'about:config' in Firefox URL bar . 
# 	Edit privacy.file_unique_origin property and set its value to false . 
# 	Reopen the firefox and now it would work
# Chrome ( Linux or Windows ) : Latest version
# Microsoft Edge ( Windows ) : New Chromium-based Edge browser available from June 2020 Windows 10 update
# Internet Explorer 11 is not supported

report_explore_design_result -no_web_server

##########################################################################################
# Post RTL Explore Design Customizations
##########################################################################################
if {[file exists [which $TCL_USER_EXPLORE_POST_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_EXPLORE_POST_SCRIPT]"
        source $TCL_USER_EXPLORE_POST_SCRIPT
} elseif {$TCL_USER_EXPLORE_POST_SCRIPT != ""} {
        puts "RM-error : TCL_USER_EXPLORE_POST_SCRIPT($TCL_USER_EXPLORE_POST_SCRIPT) is invalid. Please correct it."
}

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Path to html and logs change if sweep of rtl blocks is executed
if {[info exists env(ASIP_FLOW)] && $EXPLORE_RTL_BLOCKS_LIST != ""} {
  exec ln -s ../work_dir/run_explore_design/block_sweep/report/html ${REPORTS_DIR}/html
  exec ln -s ../work_dir/run_explore_design/block_sweep/report/logs ${REPORTS_DIR}/logs
} else {
# Original: fixed path with ../
exec ln -s ../work_dir/run_explore_design/${DESIGN_NAME}/report/html ${REPORTS_DIR}/.
exec ln -s ../work_dir/run_explore_design/${DESIGN_NAME}/report/logs ${REPORTS_DIR}/.
}
exec ln -s ../${REPORTS_DIR}/html/qorSummary/qorsum/ $COMPARE_QOR_DATA_DIR
######### END CHANGED FOR ASIP SCRIPTS ############

##########################################################################################
# Save and Exit
##########################################################################################
save_lib -all
echo [date] > explore_design

exit

