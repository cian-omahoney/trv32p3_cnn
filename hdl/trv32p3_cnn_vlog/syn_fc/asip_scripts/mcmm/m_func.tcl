# File: m_func.tcl
puts "RM-info (asip) : Running script [info script]\n"

set CLOCK_CYCLE            [expr 1000.0/${CLOCK_FREQ}]
set OCD_CLOCK_CYCLE        [expr 1000.0/${OCD_CLOCK_FREQ}]

set clock_port [get_ports $CLK_NAME]
set reset_port [get_ports $RESET_NAME]

set ALL_INPUTS_EXC_CLK     [remove_from_collection [all_inputs] $clock_port]
set ALL_INPUTS_EXC_CLK_RES [remove_from_collection $ALL_INPUTS_EXC_CLK $reset_port]
set ALL_OUTPUTS_CLK        [all_outputs]

# ----------------------------------------------------------------------
# Clocks & False Paths
# ----------------------------------------------------------------------
create_clock -name $CLK_NAME -period ${CLOCK_CYCLE} $clock_port

# group reg2reg/inputs/outputs/combo paths
set clock_ports [filter_collection [get_attribute [get_clocks] sources] object_class==port]
set input_ports [remove_from_collection [all_inputs] ${clock_ports}]
set output_ports [all_outputs]

group_path -name CLK -to ${CLK_NAME}
group_path -name REGOUT -to ${output_ports}
group_path -name REGIN -from ${input_ports}
group_path -name FEEDTHROUGH -from ${input_ports} -to ${output_ports}


###################################
#### reset input
###################################
# dont buffer reset net
set_ideal_network ${reset_port}

puts "RM-info (asip) : Completed script [info script]\n"

