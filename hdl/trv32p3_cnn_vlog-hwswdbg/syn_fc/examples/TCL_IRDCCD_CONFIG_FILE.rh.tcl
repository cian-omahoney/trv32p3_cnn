########################################################################################
# Script: TCL_IRDCCD_CONFIG_FILE.rh.tcl
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
## A new app_option route_opt.enable_voltage_drop_opt_ccd to enable IRD-CCD
## -- set_app_optin -name route_opt.enable_voltage_drop_opt_ccd -value true
## By default, IRD-CCD will choose ~1000 cells with top dynamic voltage drops
## 
## IRD-CCD with customized setting : Choose either one app option as follows:
## -- ccd.voltage_drop_voltage_threshold: 
## Specifies the threshold ratio for picking cells with that much voltage drop or higher, relative to the supply voltage
## For example: IRD-CCD will deal the cell instances with dynamic voltage drops larger than 1% of ideal supply 
##
## -- ccd.voltage_drop_population_threshold:
## Specifies the threshold ratio for picking cells with the highest voltage drop, relative to the number of cells
## For example: IRD-CCD will deal the cell instances which are 1% top dynamic voltage drops 
## If above two app options are used at the same time, IRD-CCD will choose the one with fewer number of cell-instances automatically
##
#########################################################################################

if {[which $REDHAWK_DIR/redhawk] == "" } {
        puts "RM-error: Unable to find redhawk at \"$REDHAWK_DIR\". Exiting...."
        exit
} else {
        puts "RM-info: Setting rail.redhawk_path to $REDHAWK_DIR"
        set_app_options -name rail.redhawk_path -value $REDHAWK_DIR
}

puts "RM-info: Run RedHawk  "
set_app_options -name rail.enable_redhawk -value true
set_app_options -name rail.enable_redhawk_sc -value false
set_app_options -name rail.tech_file -value $REDHAWK_TECH_FILE
set_app_options -name rail.redhawk_path -value $REDHAWK_DIR

if {![check_license -quiet "SNPS_INDESIGN_RH_RAIL"]} {
        puts "RM-error: Unable to find SNPS_INDESIGN_RH_RAIL license. Exiting...."
        exit 
}

if {[file exists [which $REDHAWK_LAYER_MAP_FILE]]} {
        set_app_options -name rail.layer_map_file -value $REDHAWK_LAYER_MAP_FILE

}

if {[which $REDHAWK_TECH_FILE] == ""} {
        puts "RM-error: Unable to find redhawk tech file at \"$REDHAWK_TECH_FILE\".  Exiting...."
	exit 
} else {
	puts "RM-info: Setting rail.tech_file to $REDHAWK_TECH_FILE"
	set_app_options -name rail.tech_file -value $REDHAWK_TECH_FILE
}

if {$REDHAWK_LIB_FILES == ""} {
        puts "RM-warning: No .lib files are provided.  Make sure your .gsr include the lib otherwise RedHawk will error...."
} elseif {[file exists [which $REDHAWK_LIB_FILES]]   } {
        rm_source -file $REDHAWK_LIB_FILES

} else {
        puts "RM-info: Setting rail.lib_files to $REDHAWK_LIB_FILES"
        set_app_options -name rail.lib_files -value $REDHAWK_LIB_FILES
}

if {$REDHAWK_APL_FILES == "" && ($REDHAWK_ANALYSIS == "dynamic_vectorless" || $REDHAWK_ANALYSIS == "dynamic_vcd" || $REDHAWK_ANALYSIS == "dynamic" )} {
        puts "RM-Warning: No APL files provided for the dynamic analysis.  Run dynamic with .lib "
} else {
        puts "RM-info: Setting rail.apl_files to $REDHAWK_APL_FILES"
        set_app_options -name rail.apl_files -value $REDHAWK_APL_FILES
}

if {[file exists [which $REDHAWK_PAD_FILE_NDM]]} {
          puts "RM-info: Run create_taps with a file that include coordinates and metal layer from NDM "
          create_taps -import $REDHAWK_PAD_FILE_NDM
} elseif { [file exists [ which $REDHAWK_PAD_FILE_PLOC ]] } {
	  puts "RM-info: Pass Redhawk ploc file to RedHawk "
          set_app_options -name rail.pad_files  -value $REDHAWK_PAD_FILE_PLOC
} elseif { [file exists [which $REDHAWK_PAD_CUSTOMIZED_SCRIPT]] }  { 
	  rm_source -file $REDHAWK_PAD_CUSTOMIZED_SCRIPT
} else {
	puts "RM-info: Run create_taps -top_pg "
        create_taps -top_pg
}

if {$REDHAWK_FREQUENCY != ""} {
	puts "RM-info: Setup Frequency for RedHawk "
        set_app_options -name rail.frequency -value $REDHAWK_FREQUENCY
}

if {$REDHAWK_TEMPERATURE != ""} {
        puts "RM-info: Setup TEMPERATURE for RedHawk "
        set_app_options -name rail.temperature -value $REDHAWK_TEMPERATURE
}

#if {$REDHAWK_SCENARIO != ""} {
#        puts "RM-info: Setup current scenario for RH/RHSC "
#        current_scenario $REDHAWK_SCENARIO
#}

if {$REDHAWK_MACROS != ""} {
	puts "RM-info: Setup Macro Model to top design "
        set_app_options -name rail.macro_models -value $REDHAWK_MACROS
}

if {$REDHAWK_SWITCH_MODEL_FILES != ""} {
        set_app_options -name rail.switch_model_files -value $REDHAWK_SWITCH_MODEL_FILES
}

set_missing_via_check_options -exclude_stack_via -threshold -1

set_app_options -name rail.database -value $REDHAWK_RAIL_DATABASE

if {$REDHAWK_MISSING_VIA_POS_THRESHOLD != ""} {

	set_missing_via_check_options -exclude_stack_via -threshold $REDHAWK_MISSING_VIA_POS_THRESHOLD
}

if {$REDHAWK_EXTRA_GSR == ""} {
        exec touch extra.gsr
        set REDHAWK_EXTRA_GSR "extra.gsr"
}

## Enable IRD-CCD
set_app_options -name opt.common.power_integrity -value true
#	set_app_options -name route_opt.flow.enable_voltage_drop_opt_ccd -value true

## Optional to set threshold, Ex. IRDCCD deal the cells with larger IR values than 10% of ideal supply voltage
#	set_app_options –name ccd.voltage_drop_voltage_threshold -value 0.1 # or ccd.voltage_drop_population_threshold 


