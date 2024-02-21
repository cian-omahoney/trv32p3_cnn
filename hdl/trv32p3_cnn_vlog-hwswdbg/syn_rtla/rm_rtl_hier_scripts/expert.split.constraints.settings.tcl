puts "RM-info : Running script [info script]\n"

#########################################################################################
# Tool: RTL Architect
# Script: expert.split.constraints.settings.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

##########################################################################################
# Expert Split Constraints Configuration
##########################################################################################

#To control the percentage value used during Percentage based IO budgeting :
set_app_options -list {rtl_opt.conditioning.enable_initial_block_budgets percentage} 	;# Default is percentage (Other Values: off, logic_depth)

#To control the feedthrough_percent used during  Percentage / Logic Depth based IO budgeting :
set_app_options -list {rtl_opt.conditioning.feedthrough_percent_block_budgets {50 50}} 	;# Default is {50 50} (% for input ports, % for output ports)

set_app_options -list {rtl_opt.conditioning.initial_percent_block_budgets {30 30}}	;# Default is {30 30} (% for input ports, % for output ports)

#set_app_options -list {rtl_opt.conditioning.ignore_repeaters_for_logic_depth_budgets false} ; #not found in 2020.09 version, Kannan will filed STAR for this to mave it available.
# Default is FALSE (Other Values: true)

puts "RM-info : Completed script [info script]\n"

