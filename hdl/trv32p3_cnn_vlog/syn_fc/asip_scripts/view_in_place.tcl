##########################################################################################
# Adapted from view_in_place.tcl (RTLA-RM_S-2021.06) for Fusion Compiler Flat Flow
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
source ./rm_utilities/procs_global.tcl > /dev/null
source ./rm_utilities/procs_fc.tcl > /dev/null
rm_source -file ./rm_setup/design_setup.tcl > /dev/null
rm_source -file ./rm_setup/fc_setup.tcl > /dev/null
rm_source -file ./rm_setup/header_fc.tcl > /dev/null
if {$HPC_CORE != ""} {rm_source -file ./inputs/plugin/hpc_vars.tcl > /dev/null}

echo ""

open_lib ${DESIGN_LIBRARY} -read > /dev/null

set READ_RTL_VALUE     ""
set COMPILE_VALUE     ""
set COMPILE_INITIAL_VALUE     ""
set COMPILE_INCREMENTAL_VALUE     ""
set INSERT_DFT_VALUE     ""
set INIT_DESIGN_VALUE     ""
set PLACE_OPT_VALUE     ""
set CLOCK_OPT_CTS_VALUE     ""
set CLOCK_OPT_OPTO_VALUE     ""
set ROUTE_AUTO_VALUE     ""
set ROUTE_OPT_VALUE     ""
set CHIP_FINISH_VALUE     ""
set ICV_IN_DESIGN_VALUE     ""
set WRITE_DATA_VALUE     ""
set ENDPOINT_OPT_VALUE     ""
set TIMING_ECO_VALUE     ""
set FUNCTIONAL_ECO_VALUE     ""
set REDHAWK_IN_DESIGN_VALUE     ""

set stage_list 			""
set i 0
foreach stage "$READ_RTL_BLOCK_NAME $COMPILE_BLOCK_NAME $COMPILE_INITIAL_BLOCK_NAME $COMPILE_INCREMENTAL_BLOCK_NAME
               $INSERT_DFT_BLOCK_NAME $INIT_DESIGN_BLOCK_NAME $PLACE_OPT_BLOCK_NAME $CLOCK_OPT_CTS_BLOCK_NAME
               $CLOCK_OPT_OPTO_BLOCK_NAME $ROUTE_AUTO_BLOCK_NAME $ROUTE_OPT_BLOCK_NAME $CHIP_FINISH_BLOCK_NAME
               $ICV_IN_DESIGN_BLOCK_NAME $WRITE_DATA_BLOCK_NAME $ENDPOINT_OPT_BLOCK_NAME
               $TIMING_ECO_BLOCK_NAME $FUNCTIONAL_ECO_BLOCK_NAME $REDHAWK_IN_DESIGN_BLOCK_NAME" {
   if {[sizeof_collection [get_blocks -quiet -all $DESIGN_LIBRARY:$DESIGN_NAME/$stage.*]]} {
      incr i
      switch $stage \
   $READ_RTL_BLOCK_NAME   { echo "   $i. $READ_RTL_BLOCK_NAME"   ;  set stage_list [lappend stage_list $i]; set READ_RTL_VALUE     $i} \
   $COMPILE_BLOCK_NAME   { echo "   $i. $COMPILE_BLOCK_NAME" ;  set stage_list [lappend stage_list $i]; set COMPILE_VALUE      $i} \
   $COMPILE_INITIAL_BLOCK_NAME   { echo "   $i. $COMPILE_INITIAL_BLOCK_NAME"  ;  set stage_list [lappend stage_list $i]; set COMPILE_INITIAL_VALUE    $i} \
   $COMPILE_INCREMENTAL_BLOCK_NAME   { echo "   $i. $COMPILE_INCREMENTAL_BLOCK_NAME" ;  set stage_list [lappend stage_list $i]; set COMPILE_INCREMENTAL_VALUE      $i} \
   $INSERT_DFT_BLOCK_NAME   { echo "   $i. $INSERT_DFT_BLOCK_NAME" ;  set stage_list [lappend stage_list $i]; set INSERT_DFT_VALUE      $i} \
   $INIT_DESIGN_BLOCK_NAME   { echo "   $i. $INIT_DESIGN_BLOCK_NAME"   ;  set stage_list [lappend stage_list $i]; set INIT_DESIGN_VALUE     $i} \
   $PLACE_OPT_BLOCK_NAME   { echo "   $i. $PLACE_OPT_BLOCK_NAME"  ;  set stage_list [lappend stage_list $i]; set PLACE_OPT_VALUE    $i} \
   $CLOCK_OPT_CTS_BLOCK_NAME   { echo "   $i. $CLOCK_OPT_CTS_BLOCK_NAME" ;  set stage_list [lappend stage_list $i]; set CLOCK_OPT_CTS_VALUE      $i} \
   $CLOCK_OPT_OPTO_BLOCK_NAME   { echo "   $i. $CLOCK_OPT_OPTO_BLOCK_NAME"   ;  set stage_list [lappend stage_list $i]; set CLOCK_OPT_OPTO_VALUE     $i} \
   $ROUTE_AUTO_BLOCK_NAME   { echo "   $i. $ROUTE_AUTO_BLOCK_NAME" ;  set stage_list [lappend stage_list $i]; set ROUTE_AUTO_VALUE      $i} \
   $ROUTE_OPT_BLOCK_NAME   { echo "   $i. $ROUTE_OPT_BLOCK_NAME"  ;  set stage_list [lappend stage_list $i]; set ROUTE_OPT_VALUE    $i} \
   $CHIP_FINISH_BLOCK_NAME   { echo "   $i. $CHIP_FINISH_BLOCK_NAME"   ;  set stage_list [lappend stage_list $i]; set CHIP_FINISH_VALUE     $i} \
   $ICV_IN_DESIGN_BLOCK_NAME   { echo "   $i. $ICV_IN_DESIGN_BLOCK_NAME" ;  set stage_list [lappend stage_list $i]; set ICV_IN_DESIGN_VALUE      $i} \
   $WRITE_DATA_BLOCK_NAME   { echo "   $i. $WRITE_DATA_BLOCK_NAME" ;  set stage_list [lappend stage_list $i]; set WRITE_DATA_VALUE      $i} \
   $ENDPOINT_OPT_BLOCK_NAME   { echo "   $i. $ENDPOINT_OPT_BLOCK_NAME"  ;  set stage_list [lappend stage_list $i]; set ENDPOINT_OPT_VALUE    $i} \
   $TIMING_ECO_BLOCK_NAME   { echo "   $i. $TIMING_ECO_BLOCK_NAME" ;  set stage_list [lappend stage_list $i]; set TIMING_ECO_VALUE      $i} \
   $FUNCTIONAL_ECO_BLOCK_NAME   { echo "   $i. $FUNCTIONAL_ECO_BLOCK_NAME"   ;  set stage_list [lappend stage_list $i]; set FUNCTIONAL_ECO_VALUE     $i} \
   $REDHAWK_IN_DESIGN_BLOCK_NAME   { echo "   $i. $REDHAWK_IN_DESIGN_BLOCK_NAME"   ;  set stage_list [lappend stage_list $i]; set REDHAWK_IN_DESIGN_VALUE     $i} \
    }
}

echo "\n   0. exit\n"; set stage_list [lappend stage_list 0]

while 1 {
   echo -n "Please enter a number to select an existing design library: "
   set answer [gets stdin]
   if {[lsearch -all $stage_list $answer] >= 0} {
      break
   } else {
      echo "The number you extered does not exist."
   }
}

if {$answer == 0}                               {exit}
if {$answer == $READ_RTL_VALUE } {set BLOCK_NAME $READ_RTL_BLOCK_NAME }
if {$answer == $COMPILE_VALUE } {set BLOCK_NAME $COMPILE_BLOCK_NAME }
if {$answer == $COMPILE_INITIAL_VALUE } {set BLOCK_NAME $COMPILE_INITIAL_BLOCK_NAME }
if {$answer == $COMPILE_INCREMENTAL_VALUE } {set BLOCK_NAME $COMPILE_INCREMENTAL_BLOCK_NAME }
if {$answer == $INSERT_DFT_VALUE } {set BLOCK_NAME $INSERT_DFT_BLOCK_NAME }
if {$answer == $INIT_DESIGN_VALUE } {set BLOCK_NAME $INIT_DESIGN_BLOCK_NAME }
if {$answer == $PLACE_OPT_VALUE } {set BLOCK_NAME $PLACE_OPT_BLOCK_NAME }
if {$answer == $CLOCK_OPT_CTS_VALUE } {set BLOCK_NAME $CLOCK_OPT_CTS_BLOCK_NAME }
if {$answer == $CLOCK_OPT_OPTO_VALUE } {set BLOCK_NAME $CLOCK_OPT_OPTO_BLOCK_NAME }
if {$answer == $ROUTE_AUTO_VALUE } {set BLOCK_NAME $ROUTE_AUTO_BLOCK_NAME }
if {$answer == $ROUTE_OPT_VALUE } {set BLOCK_NAME $ROUTE_OPT_BLOCK_NAME }
if {$answer == $CHIP_FINISH_VALUE } {set BLOCK_NAME $CHIP_FINISH_BLOCK_NAME }
if {$answer == $ICV_IN_DESIGN_VALUE } {set BLOCK_NAME $ICV_IN_DESIGN_BLOCK_NAME }
if {$answer == $WRITE_DATA_VALUE } {set BLOCK_NAME $WRITE_DATA_BLOCK_NAME }
if {$answer == $ENDPOINT_OPT_VALUE } {set BLOCK_NAME $ENDPOINT_OPT_BLOCK_NAME }
if {$answer == $TIMING_ECO_VALUE } {set BLOCK_NAME $TIMING_ECO_BLOCK_NAME }
if {$answer == $FUNCTIONAL_ECO_VALUE } {set BLOCK_NAME $FUNCTIONAL_ECO_BLOCK_NAME }
if {$answer == $REDHAWK_IN_DESIGN_VALUE } {set BLOCK_NAME $REDHAWK_IN_DESIGN_BLOCK_NAME }

if {[sizeof_collection [get_blocks -quiet ${DESIGN_NAME}/${BLOCK_NAME}.design -all]]} {
   puts "RM-info : Opening block ${DESIGN_NAME}/${BLOCK_NAME}.design"
   open_block ${DESIGN_NAME}/${BLOCK_NAME} -ref_libs_for_edit
} else {
   puts "RM-info : Opening block ${DESIGN_NAME}/${BLOCK_NAME}.outline"
   open_block ${DESIGN_NAME}/${BLOCK_NAME}.outline
}

# execute a couple commands to make the GUI work without delay
puts "RM-info : Running link_block"
link_block


