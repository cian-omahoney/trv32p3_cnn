# File: c_ff.tcl
puts "RM-info (asip) : Running script [info script]\n"

set set_parasitics_parameters_cmd "set_parasitics_parameters -corner [current_corner] -late_spec $parasitic2 -early_spec $parasitic2"
if {$TCL_PARASITIC_SETUP_FILE == "" && $TECH_LIB != ""} {
    puts "RM-info : TCL_PARASITIC_SETUP_FILE not specifed, assuming parasitic models are included in TECH_LIB \n"
    lappend set_parasitics_parameters_cmd -library [file rootname $TECH_LIB]
}
echo $set_parasitics_parameters_cmd
eval $set_parasitics_parameters_cmd

report_parasitic_parameters

if {${C_FF_PROCESS_NUM} != "" } {
    set_process_number ${C_FF_PROCESS_NUM}
}

if {${C_FF_PROCESS_LABEL} != "" } {
    set_process_label ${C_FF_PROCESS_LABEL}
}

if {${C_FF_TEMPERATURE} != "" } {
    set_temperature ${C_FF_TEMPERATURE}
}

#Default UPF only creates one power domain:
#VDD/VSS SN (Supply Net), SP (Supply Port) and CSN (connect_supply_net)
if {${C_FF_VOLTAGE} != "" } {
    set_voltage ${C_FF_VOLTAGE} -object_list VDD
}
set_voltage 0.00 -object_list [get_supply_nets VSS*]

#set_timing_derate -late 1.05 -cell_delay -net_delay

# default load: assume 5 x capacity of NAND2-input
set libcell_std_port_load [get_object_name [get_lib_cells */$STD_PORT_LOAD_NAND]]
set std_port_load [ expr 5.0 * [ load_of $libcell_std_port_load/$STD_PORT_LOAD_NAND_PIN ] ]

# set default load for all outputs
set_load ${std_port_load} [all_outputs]
puts "RM-info (asip) : Completed script [info script]\n"

