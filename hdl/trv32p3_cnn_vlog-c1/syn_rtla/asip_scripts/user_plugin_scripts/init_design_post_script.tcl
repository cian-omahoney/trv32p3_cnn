puts "RM-info (asip) : Running script [info script]\n"
#Disabling AutoUngroup
set_app_options -name compile.flow.autoungroup -value false
set_app_options -name compile.flow.boundary_optimization -value false
set_app_options -name compile.flow.constant_and_unloaded_propagation_with_no_boundary_opt -value false

if {[file exists [which $TCL_LIB_CELL_PURPOSE_FILE]]} {
    puts "RM-info (asip) : Sourcing [which $TCL_LIB_CELL_PURPOSE_FILE]"
    source -echo $TCL_LIB_CELL_PURPOSE_FILE
} elseif {$TCL_LIB_CELL_PURPOSE_FILE != ""} {
    puts "RM-error (asip) : TCL_LIB_CELL_PURPOSE_FILE ($TCL_LIB_CELL_PURPOSE_FILE) is invalid. Please correct it."
}

set DATE [sh date +%F:%H:%M]

if { $RTL_ID != "" } {
    redirect -file ${REPORTS_DIR}/${DESIGN_NAME}${RTL_ID}.activity.driver.start.${DATE}.rpt {report_activity -driver}
    echo "#[date]" > init_design${RTL_ID}
    echo "set REPORTS_DIR  \"$REPORTS_DIR\"" >> init_design${RTL_ID}
    echo "set DESIGN_NAME  \"$DESIGN_NAME\"" >> init_design${RTL_ID}
    echo "set FSDB_FILE \"[which $FSDB_FILE]\"" >> init_design${RTL_ID}
    echo "set FSDB_SOURCE_INSTANCE \"[which $FSDB_SOURCE_INSTANCE]\"" >> init_design${RTL_ID}
    echo "set FSDB_POWER_SCENARIO \"[which $FSDB_POWER_SCENARIO]\"" >> init_design${RTL_ID}
    echo "set SAIF_FILE_LIST \"[which $SAIF_FILE_LIST]\"" >> init_design${RTL_ID}
    echo "set SAIF_FILE_SOURCE_INSTANCE \"$SAIF_FILE_SOURCE_INSTANCE\"" >> init_design${RTL_ID}
    echo "set SAIF_FILE_POWER_SCENARIO \"$SAIF_FILE_POWER_SCENARIO\"" >> init_design${RTL_ID}
    echo "set CLK_NAME \"$CLK_NAME\"" >> init_design${RTL_ID}
} else {
    redirect -file ${REPORTS_DIR}/${DESIGN_NAME}.activity.driver.start.${DATE}.rpt {report_activity -driver}
}
puts "RM-info (asip) : Completed script [info script]\n"

