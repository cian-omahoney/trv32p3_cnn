##########################################################################################
# Tool: RTL Architect
# Script: splits.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
source -echo ./rm_setup/rtl_setup.tcl

##########################################################################################
# Open Library and Block
##########################################################################################
open_lib   ${WORK_DIR}/${DESIGN_LIBRARY} -ref_libs_for_edit
open_block ${DESIGN_NAME}/${INIT_DESIGN_LABEL_NAME}
save_block -hier -force -label ${SPLITS_LABEL_NAME}
close_lib  -purge -force -all
open_block ${WORK_DIR}/${DESIGN_LIBRARY}:${DESIGN_NAME}/${SPLITS_LABEL_NAME} -ref_libs_for_edit


##########################################################################################
# Split Constraints
##########################################################################################
# Pre RTL Split Constraints Customizations
##########################################################################################
if {[file exists [which $TCL_USER_SPLIT_CONSTRAINTS_PRE_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_SPLIT_CONSTRAINTS_PRE_SCRIPT]"
        source $TCL_USER_SPLIT_CONSTRAINTS_PRE_SCRIPT
} elseif {$TCL_USER_SPLIT_CONSTRAINTS_PRE_SCRIPT != ""} {
        puts "RM-error : TCL_USER_SPLIT_CONSTRAINTS_PRE_SCRIPT($TCL_USER_SPLIT_CONSTRAINTS_PRE_SCRIPT) is invalid. Please correct it."
}


##########################################################################################
# Run RTL Split Constraints
##########################################################################################
set rtl_opt_cmd "rtl_opt -from split_constraints -to split_constraints  -block_instances \{${DP_BLOCK_INSTS}\} "

if {$EXPERT_SPLIT_CONSTRAINTS_MODE == "true"} {
	source -echo -verbose $EXPERT_SPLIT_CONSTRAINTS_SETTINGS
	puts "RM-info : Expert split_constraints settings from TCL file $EXPERT_SPLIT_CONSTRAINTS_SETTINGS \n"
}

echo $rtl_opt_cmd
eval $rtl_opt_cmd
save_block -hier -force -label ${SPLIT_CONSTRAINTS_LABEL_NAME}


##########################################################################################
# Post RTL  Split Constraints Customizations
##########################################################################################
if {[file exists [which $TCL_USER_SPLIT_CONSTRAINTS_POST_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_SPLIT_CONSTRAINTS_POST_SCRIPT]"
        source $TCL_USER_SPLIT_CONSTRAINTS_POST_SCRIPT
} elseif {$TCL_USER_SPLIT_CONSTRAINTS_POST_SCRIPT != ""} {
        puts "RM-error : TCL_USER_SPLIT_CONSTRAINTS_POST_SCRIPT($TCL_USER_SPLIT_CONSTRAINTS_POST_SCRIPT) is invalid. Please correct it."
}


##########################################################################################
# Commit
##########################################################################################
# Pre RTL Commit Customizations
##########################################################################################
if {[file exists [which $TCL_USER_COMMIT_PRE_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_COMMIT_PRE_SCRIPT]"
        source $TCL_USER_COMMIT_PRE_SCRIPT
} elseif {$TCL_USER_COMMIT_PRE_SCRIPT != ""} {
        puts "RM-error : TCL_USER_COMMIT_PRE_SCRIPT($TCL_USER_COMMIT_PRE_SCRIPT) is invalid. Please correct it."
}


##########################################################################################
# Run RTL Commit
##########################################################################################
rtl_opt -from commit -to commit -block_instances ${DP_BLOCK_INSTS}


##########################################################################################
# Post RTL Commit Customizations
##########################################################################################
if {[file exists [which $TCL_USER_COMMIT_POST_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_COMMIT_POST_SCRIPT]"
        source $TCL_USER_COMMIT_POST_SCRIPT
} elseif {$TCL_USER_COMMIT_POST_SCRIPT != ""} {
        puts "RM-error : TCL_USER_COMMIT_POST_SCRIPT($TCL_USER_COMMIT_POST_SCRIPT) is invalid. Please correct it."
}


##########################################################################################
# Save and Exit
##########################################################################################
save_lib -all
echo [date] > splits
exit


