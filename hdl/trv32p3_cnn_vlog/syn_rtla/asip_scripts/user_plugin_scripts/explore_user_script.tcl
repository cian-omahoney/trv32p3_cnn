puts "RM-info (asip) : Running script [info script]\n"

# To match Flat-Flow configuration in metrics.tcl (before compute_metric -power)
setConf ESSENTIAL_NAMEMAP 1

#If this job is distributed, required environment variables has been saved in this file
if {[file exists [which asip_dist_env]]} {
    source -echo -verbose asip_dist_env
} else {
    set ASIP_LIB_SETUP $::env(ASIP_LIB_SETUP)
    set ASIP_SCRIPTS $::env(ASIP_SCRIPTS)
}
puts "INFO: Using ASIP library setup file $ASIP_LIB_SETUP/asip_lib_setup.tcl"
source -echo -verbose $ASIP_LIB_SETUP/asip_lib_setup.tcl

# Adding set technology also in the exploration flow
set NODE    $TECH_NODE ;#as in rm_setup
set set_technology_cmd "set_technology -node"
if {$NODE != ""} {
              puts "RM-info : Setting technology node. \n"
              lappend set_technology_cmd $NODE
              echo $set_technology_cmd
              eval $set_technology_cmd
}

proc create_clock_w_target_freq {clock_name} {
    current_mode               "func"

    set target_freq            $freq                                       ;# MHz
    set clk_period             [ expr 1000.0 / $target_freq ]              ;# Compute clock period

    create_clock  -name ${clock_name}  -period  $clk_period  [ get_ports ${clock_name} ]
}

if { [info exists freq] && ![info exists rtl_id] } {
    ########## Frequency sweep #################################
    source -echo $ASIP_SCRIPTS/model_info.tcl ;# to know CLK_NAME
    create_clock_w_target_freq $CLK_NAME
}

if { [info exists rtl_id] } {
    puts "RM-info(asip) : Sourcing additional variables for RTL block $rtl_id to set rtl_power_analysis_options"
    source -echo init_design_$rtl_id
    if {![file exists [which $SAIF_FILE_LIST]] && ![file exists [which $FSDB_FILE]]} {
        puts "RM-Warning: FSDB or SAIF not defined, power metrics will run with default activity. \n" 
    } else {
        if {[file exists [which $FSDB_FILE]]} {
            set metrics_power_analysis_options_cmd "set_rtl_power_analysis_options -fsdb ${FSDB_FILE}"
            if { [info exists FSDB_SOURCE_INSTANCE] && $FSDB_SOURCE_INSTANCE != "" } {
                lappend metrics_power_analysis_options_cmd -strip_path $FSDB_SOURCE_INSTANCE
            }
            if { [info exists FSDB_POWER_SCENARIO] && $FSDB_POWER_SCENARIO != "" } {
                lappend metrics_power_analysis_options_cmd -scenario $FSDB_POWER_SCENARIO
            }
        } elseif {[file exists [which $SAIF_FILE_LIST]] && [llength $SAIF_FILE_LIST] == 1} {
            if { ![info exists metrics_power_analysis_options_cmd] } {
                set metrics_power_analysis_options_cmd "set_rtl_power_analysis_options"
            }
            lappend metrics_power_analysis_options_cmd -saif [which $SAIF_FILE_LIST] \
                -postcmds "report_switching_activity -include_mapping_types > ${REPORTS_DIR}/${DESIGN_NAME}_$rtl_id.switching_activity.pp.rpt"
            if { [info exists SAIF_FILE_SOURCE_INSTANCE] && $SAIF_FILE_SOURCE_INSTANCE != "" } {
                lappend metrics_power_analysis_options_cmd -strip_path $SAIF_FILE_SOURCE_INSTANCE
            }
            if { [info exists SAIF_FILE_POWER_SCENARIO] && $SAIF_FILE_POWER_SCENARIO != "" } {
                lappend metrics_power_analysis_options_cmd -scenario $SAIF_FILE_POWER_SCENARIO
            }
        }
        echo $metrics_power_analysis_options_cmd
        eval $metrics_power_analysis_options_cmd
    }
    if { [info exists freq] } {
        # Clock name got from init_design_$rtl_id
        create_clock_w_target_freq $CLK_NAME
    }
}
puts "RM-info (asip) : Completed script [info script]\n"

