# File: s_func.ff.tcl
puts "RM-info (asip) : Running script [info script]\n"

set STD_IN_DELAY    [expr ${CLOCK_CYCLE}/3]
set STD_OUT_DELAY   [expr ${CLOCK_CYCLE}/3]
# ----------------------------------------------------------------------
# Clock Behaviour
# ----------------------------------------------------------------------
#set_clock_uncertainty 0.1 [get_clocks ${CLK_NAME}]
#set_clock_latency -early 0.40 [get_clocks ${CLK_NAME}]
#set_clock_latency -late 0.45  [get_clocks ${CLK_NAME}]
#set_clock_latency -min 0.40 [get_clocks ${CLK_NAME}]
#set_clock_latency -max 0.45 [get_clocks ${CLK_NAME}]
#set_clock_transition 0.1 [get_clocks ${CLK_NAME}]

#------------------------------------------------------------------------------
# Input and Output Constraints
#------------------------------------------------------------------------------
set_input_delay  -clock [get_clocks ${CLK_NAME}] ${STD_IN_DELAY}  ${ALL_INPUTS_EXC_CLK_RES}
set_output_delay -clock [get_clocks ${CLK_NAME}] ${STD_OUT_DELAY} ${ALL_OUTPUTS_CLK}

<<<<<<< HEAD
# JTAG interface specific
set_input_delay  ${STD_IN_DELAY}  -clock jtag_clk [get_ports $JTAG_INPUT_PORTS_NO_RST]
set_output_delay ${STD_OUT_DELAY} -clock jtag_clk [get_ports $JTAG_OUTPUT_PORTS]

=======
>>>>>>> 4598ee6aea7e54d7c8d2ee3c7f6dc45be2dcb746
# set default drive for ALL ports
set_driving_cell -lib_cell ${STD_DRV_CELL} -pin ${STD_DRV_PIN} ${input_ports}

#set_max_transition 0.15 -clock_path [get_clocks ${CLK_NAME}]
puts "RM-info (asip) : Completed script [info script]\n"

