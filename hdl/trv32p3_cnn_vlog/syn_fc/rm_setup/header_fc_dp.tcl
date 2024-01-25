##########################################################################################
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

if {[get_app_var synopsys_program_name] == "fc_shell" && [get_app_var synopsys_shell_mode] == "frontend"}  {
   puts "RM-Warning: Using the Fusion Compiler Frontend Shell. Design Planning commands will require a special license in this shell mode. Please use the Unified Fusion Compiler shell."
}

set search_path [list ./rm_setup ./rm_fc_scripts ./rm_fc_dp_scripts ./rm_tech_scripts ./rm_user_plugin_scripts $WORK_DIR]
lappend search_path .

if {$synopsys_program_name == "fc_shell"} {
   set_host_options -max_cores $SET_HOST_OPTIONS_MAX_CORE

   ## The default number of significant digits used to display values in reports
   set_app_options -name shell.common.report_default_significant_digits -value 3 ;# tool default is 2

   ## Enable on-disk operation for copy_block to save block to disk right away
   #  set_app_options -name design.on_disk_operation -value true ;# default false and global-scoped
}

if { [info exists INTERMEDIATE_BLOCK_VIEW] && $INTERMEDIATE_BLOCK_VIEW == "abstract" } {
   set_app_options -name abstract.allow_all_level_abstract -value true  ;# Dafult value is false
}

switch $FLOORPLAN_STYLE {
   channel {set SHAPING_CMD_OPTIONS           "-channels true"} 
   abutted {set SHAPING_CMD_OPTIONS           "-channels false"} 
}

if !{[file exists $WORK_DIR]} {file mkdir $WORK_DIR}

if !{[file exists $REPORTS_DIR]} {file mkdir $REPORTS_DIR}
if !{[file exists $OUTPUTS_DIR]} {file mkdir $OUTPUTS_DIR}
if !{[file exists $REPORTS_DIR_SPLIT_CONSTRAINTS]} {file mkdir $REPORTS_DIR_SPLIT_CONSTRAINTS}
if !{[file exists $REPORTS_DIR_INIT_DP]} {file mkdir $REPORTS_DIR_INIT_DP}
if !{[file exists $REPORTS_DIR_PRE_SHAPING]} {file mkdir $REPORTS_DIR_PRE_SHAPING}
if !{[file exists $REPORTS_DIR_PLACE_IO]} {file mkdir $REPORTS_DIR_PLACE_IO}
if !{[file exists $REPORTS_DIR_SHAPING]} {file mkdir $REPORTS_DIR_SHAPING}
if !{[file exists $REPORTS_DIR_PLACEMENT]} {file mkdir $REPORTS_DIR_PLACEMENT}
if !{[file exists $REPORTS_DIR_CREATE_POWER]} {file mkdir $REPORTS_DIR_CREATE_POWER}
if !{[file exists $REPORTS_DIR_CLOCK_TRUNK_PLANNING]} {file mkdir $REPORTS_DIR_CLOCK_TRUNK_PLANNING}
if !{[file exists $REPORTS_DIR_PLACE_PINS]} {file mkdir $REPORTS_DIR_PLACE_PINS}
if !{[file exists $REPORTS_DIR_PRE_TIMING]} {file mkdir $REPORTS_DIR_PRE_TIMING}
if !{[file exists $REPORTS_DIR_TIMING_ESTIMATION]} {file mkdir $REPORTS_DIR_TIMING_ESTIMATION}
if !{[file exists $REPORTS_DIR_BUDGETING]} {file mkdir $REPORTS_DIR_BUDGETING}
if !{[file exists $REPORTS_DIR_INIT_COMPILE]} {file mkdir $REPORTS_DIR_INIT_COMPILE}
if !{[file exists $REPORTS_DIR_TOP_COMPILE]} {file mkdir $REPORTS_DIR_TOP_COMPILE}
if !{[file exists ./work_dir]} {file mkdir ./work_dir}
if {![file exists ./work_dir/$INIT_COMPILE_LABEL_NAME]} {exec mkdir ./work_dir/$INIT_COMPILE_LABEL_NAME}
if {![file exists ./work_dir/$TOP_COMPILE_LABEL_NAME]} {exec mkdir ./work_dir/$TOP_COMPILE_LABEL_NAME}

if {[info exists env(LOGS_DIR)]} {
   set log_dir $env(LOGS_DIR)
} else {
   set log_dir ../logs_fc 
}

# Block label to be release by write_data
if {$DP_FLOW == "flat"} {
   set WRITE_DATA_LABEL_NAME timing_estimation
} else {
   set WRITE_DATA_LABEL_NAME budgeting
}

########################################################################################## 
## Message handling
##########################################################################################
suppress_message ATTR-11 ;# suppress the information about that design specific attribute values override over library values
## set_message_info -id ATTR-11 -limit 1 ;# limit the message normally printed during report_lib_cells to just 1 occurence
set_message_info -id PVT-012 -limit 1
set_message_info -id PVT-013 -limit 1
puts "RM-info: Hostname: [sh hostname]"; puts "RM-info: Date: [date]"; puts "RM-info: PID: [pid]"; puts "RM-info: PWD: [pwd]"


