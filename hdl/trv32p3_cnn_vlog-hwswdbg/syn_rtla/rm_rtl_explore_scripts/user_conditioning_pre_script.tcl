puts "RM-info : Running script [info script]\n"

#########################################################################################
# Tool: RTL Architect
# Script: user_conditioning_pre_script.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

##########################################################################################
# APP. SETTINGS
##########################################################################################
# CCD
# To disable CCD during rtl_opt
	# set_app_options -name compile.flow.enable_ccd -value false

# MBIT
# To enable Multibit banking in RTLA flow 
	# set_app_options -list {compile.flow.enable_multibit true} 

# RTL banking and RTL de-banking (on-by-default if above master control is enabled) during RTLA FAST synthesis and can be controlled by following application options:
	# set_app_options -list {compile.flow.enable_rtl_multibit_banking true}
	# set_app_options -list {compile.flow.enable_rtl_multibit_debanking true}

# Physical Multi-bit banking and de-banking (on-by-default if above master control compile.flow.enable_multibit is enabled) during RTLA FAST synthesis and can be controlled by following application options:
	# set_app_options -list {compile.flow.enable_physical_multibit_banking true}

# To control Multibit de-banking in RTLA flow 
	# set_app_options -list {compile.flow.enable_multibit_debanking true}

# DTDP
# set_app_options -list {rtl_opt.estimation.enable_dtdp true}

# Auto-ungroup and boundary optimization
# set_app_options -list {rtl_opt.conditioning.disable_boundary_optimization_and_auto_ungrouping true}

#Congestion effort
#set_app_options -list {rtl_opt.estimation.placement_congestion_effort high}

puts "RM-info : Completed script [info script]\n"





