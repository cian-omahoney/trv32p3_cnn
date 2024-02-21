##########################################################################################
# Tool: RTL Architect
# # Script: explore_design_example.tcl (template)
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

##########################################################################################
#  Example of using explore_design for sweeping experiments
##########################################################################################

########## Example 1 : Frequency sweep #################################
# Steps to follow:
# step 1 : Decide the clock for which we need to sweep
#
# step 2 : Create the file where you define clock_period as variable for create_clock per mode
#
# step 3 : Define set_explore_design_options for frequency using -user_script and -var_list.
# 	Step 3.1: Specify true for EXPERT_EXPLORE_VARIABLE_MODE variable in rtl_setup.tcl to perform vaiable seeping.
#	Step 3.2: Specify user_script file name for EXPERT_EXPLORE_SETTINGS vaiable; and Specify var_list value for EXPLORE_DESIGN_VARIABLE_LIST variable in rtl_setup.tcl .
#
#################################Example################################
# Step 1 & 2 : Creating a file with content as below where we are varying the frequency of a clock in two mode
# 	     : Uncomment below lines to use same file or create your own file
# FILE NAME : explore_design_example.tcl --> file Name
###
# current_mode / create_mode M1						;# Specify mode or create one
# set target_freq1 $freq1
# set  clk_period   exp [ 1 / $target_freq1 ] 				;# Compute clock period
# create_clock  -name clk  -period  $clk_period  [ get_ports clk ]	;# Create clock with computed clock period for desired clock port
# 
# current_mode / create_mode M2
# set target_freq2 $freq2
# set  clk_period2   exp [ 1 / $target_freq2 ]
# create_clock  -name clk  -period  $clk_period2  [ get_ports clk ]
### 
# 
# Step 3 : Define set_explore_design_options setup variables for frequency sweep.
#
## Specify value for Variables as shown below in rtl_setup.tcl, please do not set these variables here
# set EXPERT_EXPLORE_SETTINGS "explore_design_example.tcl"
# set EXPLORE_DESIGN_VARIABLE_LIST "{ freq1 { 2 2.2 } freq2 { 3 3.3 } }"
#
# The command will look like below when explore_desing.tcl is run.
# set_explore_design_options -user_script freq.tcl -var_list { freq1 { 2 2.2 } freq2 { 3 3.3 } }
#
#
## Note: To run frequency sweep, user should create the user_script and define the variables.
#
##

##########################################################################################
#  Example of using explore_design for sweeping experiments
##########################################################################################
#
#
########## Example 2 : Floorplan sweep #################################
#
# We have several way to do floorplan sweep . But here we are focusing on reshape
# the existing floorplan using an utility . Be careful , it is for exploration only
#
# Here we will use modify_die_area utility to change the floorplan height/width by percentage
#
# Step 1 : Create the file for sourcing the TBC and variable to control the height/width percentage for each experiment 
#
# Step 2 : Define set_explore_design_options and fire the jobs
#
#
# Step 1 : Creating the file
# FILE NAME : explore_design_example.tcl
###
# source ./modify_die_area.tbc  
# Refer to solvnet article "https://solvnetplus.synopsys.com/s/article/Exploring-Die-Area-Reduction-Feasibility-1576148294085" to get the tbc and more information on this utility.
#
# if { $height < 0 && $width < 0 } {
# modify_die_area -height_decrease [ expr abs($height) ] -width_decrease [ expr abs($width) ] -compile 
# }
#  if { $height < 0 && $width >= 0 } {
# modify_die_area -height_decrease [ expr abs($height) ] -width_increase [ expr abs($width) ] -compile 
# }
# if { $height >= 0 && $width < 0 } {
# modify_die_area -height_increase [ expr abs($height) ] -width_decrease [ expr abs($width) ] -compile 
# }
# if { $height >= 0 && $width >= 0 } {
# modify_die_area -height_increase [ expr abs($height) ] -width_increase [ expr abs($width) ] -compile 
# }
###
#
# Step 2 : Define the explore_design setup variables in rtl_setup.tcl, please do not set these varaibles here
# set EXPERT_EXPLORE_SETTINGS "explore_design_example.tcl"
# set EXPLORE_DESIGN_VARIABLE_LIST "{ height { -5 7 0 } width { -5 3 0 } }"
#
# Negative value will decrease and positive value will increase the width/height . Zero will not have no impact
#
# The command will look like below when explore_desing.tcl is run.
# set_explore_design_options -user_script modify_die_area.tcl -var_list { height { -5 7 0 } width { -5 3 0 } }
#
## Explore design results: 
# first set of experiment will shrink the height by 5% and width by 5%
# second set of experiment will expand the height by 7% and width by 3%
# third set of experiment has no impact ( original floorplan )
#
# ## Note: To run floorplan sweep, user should provide the user_script and define the variables.
#
# #

##########################################################################################
#  Example of using explore_design for sweeping experiments
##########################################################################################
#
#
########## Example 3 : App_option/macro placement sweep #################################
#
# Here we are sweeping the different macro placement strategies during macro-placement 
# This provide an example where user can similarly sweep with clock_gating strategies , Lib cell usage ( TLS ) etc
#
# Step 1 :  Create the file where variable control the app_options variance for the flow
#
# Step 2 : Define set_explore_design_options and fire the jobs
#
#
# Step 1 : Creating the file for sweep different macro placement strategies 
# FILE NAME : explore_design_example.tcl
#
###
# switch $macro_placement_style {
#   "DFA_DRIVEN" {
#       puts "Run 1: Setup for $macro_placement_style (tool default)"
#   }
#   "WIRELENGTH_DRIVEN" {
#      puts "Run 5: Setup for $macro_placement_style"
#      set_app_options -list {plan.place.trace_mode normal}
#   }
#   "TIMING_DRIVEN" {
#      puts "Run 6: Setup for $macro_placement_style"
#      set_app_options -list {plan.place.timing_driven_mode macro}
#      set_app_options -list {plan.place.trace_mode normal}
#   }
#   "FF_DFA_DRIVEN" {
#       puts "Run 1: Setup for $macro_placement_style (tool default)"
#       set_app_option -list {plan.macro.style freeform}
#   }
#   "FF_DFA_DRIVEN_and_TIMING_DRIVEN" {
#      puts "Run 2: Setup for $macro_placement_style"
#      set_app_options -list {plan.place.timing_driven_mode macro}
#      set_app_option -list {plan.macro.style freeform}
#   }
#   "FF_WIRELENGTH_DRIVEN" {
#      puts "Run 5: Setup for $macro_placement_style"
#      set_app_options -list {plan.place.trace_mode normal}
#      set_app_option -list {plan.macro.style freeform}
#   }
# } 
###
#
# Step 2 : Define the explore_design setup variables in rtl_setup.tcl, please do not set these varaibles here
# set EXPERT_EXPLORE_SETTINGS "explore_design_example.tcl"
# set EXPLORE_DESIGN_VARIABLE_LIST "{ macro_placement_style { DFA_DRIVEN  WIRELENGTH_DRIVEN  TIMING_DRIVEN FF_DFA_DRIVEN FF_DFA_DRIVEN_and_TIMING_DRIVEN FF_WIRELENGTH_DRIVEN } }"
#
# The command will look like below after substituing values for varaibles in explore_desing.tcl is run.
#    set_explore_design_options -user_script macro_placement.tcl -var_list { macro_placement_style { DFA_DRIVEN  WIRELENGTH_DRIVEN  TIMING_DRIVEN FF_DFA_DRIVEN FF_DFA_DRIVEN_and_TIMING_DRIVEN FF_WIRELENGTH_DRIVEN } }
#
#


