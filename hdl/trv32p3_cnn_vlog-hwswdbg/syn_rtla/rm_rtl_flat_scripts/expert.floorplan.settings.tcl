puts "RM-info : Running script [info script]\n"

#########################################################################################
# Tool: RTL Architect
# Script: expert.floorplan.settings.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

##########################################################################################
# Expert Floorplan Configuration
##########################################################################################

# If floorplan is provided, tool will check and increment the incomplete setting while keeping the original input of user.

set_app_options -list {rtl_opt.floorplan.skip_stages {}		}		; # No Default (Allowed Inputs: initialize_fp, shape_blocks, hier_placement, top_level_pin_assignment, block_level_pin_assignment, budgeting)
set_app_options -list {rtl_opt.floorplan.enable_feedthroughs true}		; # Default is true  (Other Values: false)
set_app_options -list {rtl_opt.flow.fully_abutted_style_floorplan true}		; # Default is false (Other Values: true)
set_app_options -list {compile.auto_floorplan.initialize auto}			; # Default is auto  (Other Values: true/false)
set_app_options -list {compile.auto_floorplan.keep_bounds true}			; # Default is true  (Other Values: auto/false)
set_app_options -list {compile.auto_floorplan.place_hard_macros unplaced}	; # Default is unplaced (Other Values: unfixed/all/none)
set_app_options -list {compile.auto_floorplan.place_ios   unplaced}		; # Default is unplaced (Other Values: unfixed/all/none)
set_app_options -list {compile.auto_floorplan.place_pins  unplaced}		; # Default is unplaced (Other Values: unfixed/all/none)
set_app_options -list {compile.auto_floorplan.shape_voltage_areas unshaped}	; # Default is unshaped (Other Values: unfixed/all/none)

#user can control pin placement, Example:
#set_block_pin_constraints -side 1 -self
#set_block_pin_constraints -side 2 -self -allowed_layers M4
report_block_pin_constraints -self		

puts "RM-info : Completed script [info script]\n"

