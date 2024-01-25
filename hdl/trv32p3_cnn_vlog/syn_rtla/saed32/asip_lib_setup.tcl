puts "RM-info : Running script [info script]\n"
##########################################################################################
# File: asip_lib_setup.tcl
# Tool: RTL Architect
# Version: R-2020.09
##########################################################################################
if {[file exists $::env(SAED32_HOME)]} {
    puts "Info: Using SAED32 installation from $::env(SAED32_HOME)\n"
} else {
    puts "Error: $::env(SAED32_HOME) not found.\n"
    exit
}

##########################################################################################
## Required variables
## These variables must be correctly filled in for the flow to run properly
##########################################################################################
set LIB_PATH			"$::env(SAED32_HOME)"

# If the parasitic models have been included in TECH_LIB, then the following
# three variables can be left empty, as well as TCL_PARASITIC_SETUP_FILE in
# section 3, and the correct name of the models must be set accordingly in
# the variables parasitic1 and parasitic2

set G_MAX_TLUPLUS_FILE ${LIB_PATH}/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus
set G_MIN_TLUPLUS_FILE ${LIB_PATH}/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus
set G_TLUPLUS_MAP_FILE ${LIB_PATH}/tech/star_rcxt/saed32nm_tf_itf_tluplus.map

set parasitic1				"max_tluplus" ;# name of parasitic tech model 1
set parasitic2				"min_tluplus" ;# name of parasitic tech model 2

#It's recommended to set at least one, either process number or process label
#Define PVT for Corner1
set C_SS_PROCESS_LABEL    ""
set C_SS_PROCESS_NUM      0.99
set C_SS_VOLTAGE          0.95
set C_SS_TEMPERATURE      125

#Define PVT for Corner2
set C_FF_PROCESS_LABEL    ""
set C_FF_PROCESS_NUM      1.01
set C_FF_VOLTAGE          1.16
set C_FF_TEMPERATURE      -40

set pvt_config_cmd "set_pvt_configuration -voltages \{ [list ${C_FF_VOLTAGE} ${C_SS_VOLTAGE}] \}\
                                          -temperatures \{ [list ${C_FF_TEMPERATURE} ${C_SS_TEMPERATURE}] \} "

if {${C_FF_PROCESS_NUM} != "" && ${C_SS_PROCESS_NUM} != ""} {
  lappend pvt_config_cmd  -process_numbers [list ${C_FF_PROCESS_NUM} ${C_SS_PROCESS_NUM}]
}

if {${C_FF_PROCESS_LABEL} != "" && ${C_SS_PROCESS_LABEL} != ""} {
  lappend pvt_config_cmd  -process_labels [list ${C_FF_PROCESS_LABEL} ${C_SS_PROCESS_LABEL}]
}

# Selective Library Loading: Configure PVTs before creating the design library
echo $pvt_config_cmd
eval $pvt_config_cmd

# Optional
set TECH_NODE			""

##########################################################################################
## 1. Variables for design prep (used by init_design.tcl.* scripts)
##########################################################################################
set REFERENCE_LIBRARY           [list ${LIB_PATH}/lib/stdcell_lvt/ndm/saed32lvt_c.ndm \
                                      ${LIB_PATH}/lib/stdcell_lvt/ndm/saed32lvt_dlvl_v.ndm \
                                      ${LIB_PATH}/lib/stdcell_lvt/ndm/saed32lvt_pg_c.ndm \
                                      ${LIB_PATH}/lib/stdcell_lvt/ndm/saed32lvt_ulvl_v.ndm \
                                      ${LIB_PATH}/lib/stdcell_hvt/ndm/saed32hvt_c.ndm \
                                      ${LIB_PATH}/lib/stdcell_hvt/ndm/saed32hvt_dlvl_v.ndm \
                                      ${LIB_PATH}/lib/stdcell_hvt/ndm/saed32hvt_pg_c.ndm \
                                      ${LIB_PATH}/lib/stdcell_hvt/ndm/saed32hvt_ulvl_v.ndm \
                                      ${LIB_PATH}/lib/stdcell_rvt/ndm/saed32rvt_c.ndm \
                                      ${LIB_PATH}/lib/stdcell_rvt/ndm/saed32rvt_dlvl_v.ndm \
                                      ${LIB_PATH}/lib/stdcell_rvt/ndm/saed32rvt_pg_c.ndm \
                                      ${LIB_PATH}/lib/stdcell_rvt/ndm/saed32rvt_ulvl_v.ndm \
                                      ${LIB_PATH}/lib/sram/ndm/saed32sram_c.ndm ]
                    ;# Required; a list of reference libraries for the design library.
					;#	for library configuration flow (LIBRARY_CONFIGURATION_FLOW set to true below): 
					;#		- specify the list of physical source files to be used for library configuration during create_lib
				       	;# 	for hierarchical designs using bottom-up flows: include subblock design libraries in the list;
					;# 	for hierarchical designs using ETMs: include the ETM library in the list.
					;# 		- If unpack_rm_dirs.pl is used to create dir structures for hierarchical designs, 
					;#		  in order to transition between hierarchical DP and hierarchical PNR flows properly, 
					;#		  absolute paths are a requirement.
set LIBRARY_CONFIGURATION_FLOW	false	;# Optional; set it to true enables library configuration flow which calls the library manager under the hood to generate .nlibs, 
					;# save them to disk, and automatically link them to the design.
					;# Requires LINK_LIBRARY to be specified with .db files and REFERENCE_LIBRARY to be specified with physical
					;# source files for the library configuration flow. Also search_path (in icc2_pnr_setup.tcl) should include paths 
					;# to these .db and physical source files.
set LINK_LIBRARY		""	;# Optional; specify .db files;
					;# 	for running VC-LP (vc_lp.tcl) and Formality (fm.tcl): required
					;# 	for ICC-II without LIBRARY_CONFIGURATION_FLOW enabled: not required
					;#	for ICC-II with LIBRARY_CONFIGURATION_FLOW enabled: required; 
					;#      	- the .db files specified will be used for the library configuration under the hood during create_lib
##################################################
### 2. Tech files and setup
##################################################
set TECH_FILE 			"${LIB_PATH}/tech/milkyway/saed32nm_1p9m_mw.tf" 	;# A technology file; TECH_FILE and TECH_LIB are mutually exclusive ways to specify technology information; 
					;# TECH_FILE is recommended, although TECH_LIB is also supported in ICC2 RM. 
set TECH_LIB			""	;# Specify the reference library to be used as a dedicated technology library;
                        		;# as a best practice, please list it as the first library in the REFERENCE_LIBRARY list 
set TECH_LIB_INCLUDES_TECH_SETUP_INFO true 
					;# Indicate whether TECH_LIB contains technology setup information such as routing layer direction, offset, 
					;# site default, and site symmetry, etc. TECH_LIB may contain this information if loaded during library prep.
					;# true|false; this variable is associated with TECH_LIB. 
set TCL_TECH_SETUP_FILE		"init_design.tech_setup.tcl"
					;# Specify a TCL script for setting routing layer direction, offset, site default, and site symmetry list, etc.
					;# init_design.tech_setup.tcl is the default. Use it as a template or provide your own script.
					;# This script will only get sourced if the following conditions are met: 
					;# (1) TECH_FILE is specified (2) TECH_LIB is specified && TECH_LIB_INCLUDES_TECH_SETUP_INFO is false
set DESIGN_LIBRARY_SCALE_FACTOR	""	;# Optional; Specify the length precision for the library. Length precision for the design
					;# library and its ref libraries must be identical. Tool default is 10000, which implies one unit is one Angstrom or 0.1nm. 
set ROUTING_LAYER_DIRECTION_OFFSET_LIST "{M1 horizontal 0} {M2 vertical 0} {M3 horizontal 0} {M4 vertical 0} {M5 horizontal 0} {M6 vertical 0} {M7 horizontal 0} {M8 vertical 0} {M9 horizontal 0} {MRDL vertical 0}" 
					;# Specify the routing layers as well as their direction and offset in a list of space delimited pairs;
					;# This variable should be defined for all metal routing layers in technology file;
					;# Syntax is "{metal_layer_1 direction offset} {metal_layer_2 direction offset} ...";
					;# It is required to at least specify metal layers and directions. Offsets are optional. 
					;# Example1 is with offsets specified: "{M1 vertical 0.2} {M2 horizontal 0.0} {M3 vertical 0.2}"
					;# Example2 is without offsets specified: "{M1 vertical} {M2 horizontal} {M3 vertical}"
set MIN_ROUTING_LAYER		""	;# Optional; Min routing layer name; normally should be specified; otherwise tool can use all metal layers
set MAX_ROUTING_LAYER		""	;# Optional; Max routing layer name; normally should be specified; otherwise tool can use all metal layers

##################################################
### 3. Verilog, dc inputs, upf, mcmm, timing, etc 
##################################################
set TCL_PARASITIC_SETUP_FILE	"read_parasitic_tech.tcl"	;# Specify a Tcl script to read in your TLU+ files by using the read_parasitic_tech command;
															;# This can be left empty if the parasitic models are included in TECH_LIB

##########################################################################################
## Variables for general optimization use
##########################################################################################
set TCL_LIB_CELL_PURPOSE_FILE 		"" ;# A Tcl file which applies lib cell purpose related restrictions;
					;# You can specify it with your own customized script
					;# FC-RM default is set_lib_cell_purpose.tcl which includes the following restrictions, each controlled by
					;# an individual variable : dont use cells (TCL_LIB_CELL_DONT_USE_FILE), tie cells (TIE_LIB_CELL_PATTERN_LIST),
					;# hold fixing (HOLD_FIX_LIB_CELL_PATTERN_LIST), CTS (CTS_LIB_CELL_PATTERN_LIST) and CTS-exclusive cells (CTS_ONLY_LIB_CELL_PATTERN_LIST).
					;# For jumpstart version, these variables are defined within set_lib_cell_purpose.tcl.

##########################################################################################
## Standard cells
##########################################################################################
set STD_PORT_LOAD_NAND     "NAND3X0_RVT"
set STD_PORT_LOAD_NAND_PIN "A1"
set STD_DRV_CELL           "SDFFX1_RVT"
set STD_DRV_PIN            "Q"

#For: TCL_LIB_CELL_PURPOSE_FILE ->
#set_attribute [get_lib_cells */TIE*] dont_touch false
#set_attribute [get_lib_cells */TIE*] dont_use false
#set_attribute [get_lib_pins */TIE*/Y] max_fanout 8
#set_attribute [get_lib_cells */ISO*] dont_use false
#set_attribute [get_lib_cells */ISO*] dont_touch false
#set_attribute [get_lib_cells */AOBUFX*] dont_use false
#set_attribute [get_lib_cells */AOBUFX*] dont_touch false
#set_attribute [get_lib_cells */AOINVX*] dont_use false
#set_attribute [get_lib_cells */AOINVX*] dont_touch false
#set_attribute [get_lib_cells */*DFFSSR*] dont_touch true
#set_attribute [get_lib_cells */*DFFSSR*] dont_use true
#set_attribute [get_lib_cells */AOBUF*] dont_touch false
#set_attribute [get_lib_cells */AOBUF*] dont_use false
#set_attribute [get_lib_cells */ISO*] dont_touch false
#set_attribute [get_lib_cells */ISO*] dont_use false

puts "RM-info : Completed script [info script]\n"


