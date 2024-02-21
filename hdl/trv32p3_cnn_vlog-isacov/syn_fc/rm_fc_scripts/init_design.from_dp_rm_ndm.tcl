##########################################################################################
# Script: init_design.from_dp_rm_ndm.tcl
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

########################################################################
## Copy designs from FC-DP-RM release area
########################################################################

if {![file exists ./${DESIGN_LIBRARY}]} {
        if {[file exists ${RELEASE_DIR_DP}/${DESIGN_LIBRARY}]} {
                puts "RM-info: Copying ${RELEASE_DIR_DP}/${DESIGN_LIBRARY} to ./"
                file copy ${RELEASE_DIR_DP}/${DESIGN_LIBRARY} ./
        } else {
                puts "RM-error: Copying ${RELEASE_DIR_DP}/${DESIGN_LIBRARY} to ./ but it doesn't exist. Exiting"
        }
} else {
        puts "RM-error: Copying ${DESIGN_LIBRARY} to ./ but it already exists. Please correct it. Exiting"
}

########################################################################
## Open the library and block
########################################################################
	## For totally flat designs, open the design copied from ICC2 DP RM release area
	open_lib ${DESIGN_LIBRARY}
	open_block ${DESIGN_NAME}/${RELEASE_LABEL_NAME_DP}

	if {$EARLY_DATA_CHECK_POLICY != "none"} {
		## Design check manager
		set_early_data_check_policy -policy $EARLY_DATA_CHECK_POLICY -if_not_exist
	}

