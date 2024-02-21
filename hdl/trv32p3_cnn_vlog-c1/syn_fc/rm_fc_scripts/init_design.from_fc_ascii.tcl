##########################################################################################
# Tool: Fusion Compiler
# Script: init_design.from_fc_ascii.tcl
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

## Read in design output files from FC's write_ascii_files command after compile
if {![rm_source -file ${OUTPUTS_DIR}/${COMPILE_BLOCK_NAME}.ascii_files/${DESIGN_NAME}.fc_script.tcl -print "${OUTPUTS_DIR}/${COMPILE_BLOCK_NAME}.ascii_files/${DESIGN_NAME}.fc_script.tcl"]} {
	exit
}

if {[file exists $DESIGN_LIBRARY]}  {
    puts "RM-info: $DESIGN_LIBRARY already exists. Renaming to ${DESIGN_LIBRARY}.backup"
    move_lib -from $DESIGN_LIBRARY -to ${DESIGN_LIBRARY}.backup -force
}

puts "RM-info: Renaming write_ascii_files generated library ASCII_${DESIGN_NAME} to ${DESIGN_LIBRARY}"
move_lib -from ASCII_${DESIGN_NAME} -to $DESIGN_LIBRARY
current_lib $DESIGN_LIBRARY

if {$UNIFIED_FLOW} {
  puts "RM-info: Copying block $DESIGN_NAME to ${DESIGN_NAME}/${CLOCK_OPT_CTS_BLOCK_NAME}"
  copy_block -from ${DESIGN_NAME} -to ${DESIGN_NAME}/${CLOCK_OPT_CTS_BLOCK_NAME}
  current_block ${DESIGN_NAME}/${CLOCK_OPT_CTS_BLOCK_NAME}
} else {
  puts "RM-info: Copying block $DESIGN_NAME to ${DESIGN_NAME}/${PLACE_OPT_BLOCK_NAME}"
  copy_block -from ${DESIGN_NAME} -to ${DESIGN_NAME}/${PLACE_OPT_BLOCK_NAME}
  current_block ${DESIGN_NAME}/${PLACE_OPT_BLOCK_NAME}
}


