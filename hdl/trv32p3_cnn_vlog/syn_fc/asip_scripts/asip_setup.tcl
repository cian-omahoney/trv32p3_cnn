##########################################################################################
# Script: design_setup.tcl
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
#
########## CHANGED FOR ASIP SCRIPTS ############
# Note: The original design_setup.tcl script has been split up
#       into a library specific part (asip_lib_setup.tcl) and
#       the design specific part (this file)
#       Variables library specific have been commented out here 
#       w/ "## ASIP-LIB_SPECIFIC ## " to be set only in asip_lib_setup.tcl
#       If a different value is needed, by uncommenting a new value can be set.
puts "INFO: Using ASIP library setup file $::env(ASIP_LIB_SETUP)/asip_lib_setup.tcl"
rm_source -file $::env(ASIP_LIB_SETUP)/asip_lib_setup.tcl

#       Variables design specific have been preceded
#       w/ "## ASIP-DESIGN_SPECIFIC ## "
# Additional variables for ASIP-flows:
set ASIP_SCRIPTS $::env(ASIP_SCRIPTS)
set ADDITIONAL_SEARCH_PATH "${ASIP_SCRIPTS} ${ASIP_SCRIPTS}/mcmm"
set ADDITIONAL_FC_SETUP     $::env(ADDITIONAL_FC_SETUP)  ;# Plug-in for ASIP-flows to overwritte any default configuration
set RTL_SOURCE_DIR			$::env(RTL_SOURCE_DIR)

puts "INFO: Loading model info ${ASIP_SCRIPTS}/model_info.tcl"
source -echo -verbose ${ASIP_SCRIPTS}/model_info.tcl
#################################################
## ASIP-DESIGN_SPECIFIC ##
set DESIGN_NAME 		${MODEL_NAME} ;# Required; name of the design to be worked on; used as the block name for save_block or copy_block operations
				   ;# If you are starting from init_design with verilog or RTL, this is also the top module name

## ASIP-DESIGN_SPECIFIC ##
set LIBRARY_SUFFIX		".nlib" ;# Optional; suffix for the design library name ; default is unspecified  
set DESIGN_LIBRARY 		"${DESIGN_NAME}${LIBRARY_SUFFIX}" ;# Optional; name of the design library; 
				   ;# If you are starting from init_design, no need to change this; it will be populated with values from DESIGN_NAME & LIBRARY_SUFFIX

##########################################################################################
## Variables for design prep which are used by init_design*tcl scripts
## Fill in the variables in 1, 2, 3, and 4 below as needed.
##########################################################################################
set INIT_DESIGN_INPUT 		"RTL"	;# Specify one of the 2 options: RTL | DP_RM_NDM; default is RTL.
 				;# 1.RTL:  For when reading in RTL netlist files before synthesis
			 	;# 2.DP_RM_NDM: if FC-DP-RM is completed, you can take its NDM outputs and skip the design creation steps;
				;#   for PNR flat (DESIGN_STYLE set to flat), script copies the design library from FC-DP-RM release 
				;#   area (specified by RELEASE_DIR_DP) and opens design;    
				;#   for PNR hier flow (DESIGN_STYLE set to hier), script will either copy design library 
				;#   from FC-DP-RM release area or in addition to that, copy design library of the child blocks from PNR
				;#   release area (specified by RELEASE_DIR_PNR), and then open design.    
## ASIP-LIB_SPECIFIC ## set REFERENCE_LIBRARY 		[list ]	;# Required; a list of reference libraries for the design library.
					;#	for library configuration flow (LIBRARY_CONFIGURATION_FLOW set to true below): 
					;#		- specify the list of physical source files to be used for library configuration during create_lib
## ASIP-LIB_SPECIFIC ## set LIBRARY_CONFIGURATION_FLOW	false	;# Optional; set it to true enables library configuration flow which calls the library manager under the hood to generate .nlibs, 
					;# save them to disk, and automatically link them to the design.
					;# Requires LINK_LIBRARY to be specified with .db files and REFERENCE_LIBRARY to be specified with physical
					;# source files for the library configuration flow. Also search_path (in fc_setup.tcl) should include paths 
					;# to these .db and physical source files.

## ASIP-LIB_SPECIFIC ## set LINK_LIBRARY		""	;# Optional; specify .db files;
					;# 	for running VC-LP (vc_lp.tcl) and Formality (fm.tcl): required
					;# 	for FC without LIBRARY_CONFIGURATION_FLOW enabled: not required
					;#	for FC with LIBRARY_CONFIGURATION_FLOW enabled: required; 
					;#      	- the .db files specified will be used for the library configuration under the hood during create_lib

##################################################
### 2. Tech files and setup
##################################################
## ASIP-LIB_SPECIFIC ## set TECH_FILE 			"" 	;# A technology file; TECH_FILE and TECH_LIB are mutually exclusive ways to specify technology information; 
					;# TECH_FILE is recommended, although TECH_LIB is also supported in FC RM. 
## ASIP-LIB_SPECIFIC ## set TECH_LIB			""	;# Specify the reference library to be used as a dedicated technology library;
                        		;# as a best practice, please list it as the first library in the REFERENCE_LIBRARY list 
## ASIP-LIB_SPECIFIC ## set TECH_LIB_INCLUDES_TECH_SETUP_INFO true 
					;# Indicate whether TECH_LIB contains technology setup information such as routing layer direction, offset, 
					;# site default, and site symmetry, etc. TECH_LIB may contain this information if loaded during library prep.
					;# true|false; this variable is associated with TECH_LIB. 
## ASIP-LIB_SPECIFIC ## set TCL_TECH_SETUP_FILE		"init_design.tech_setup.tcl"
					;# Specify a TCL script for setting routing layer direction, offset, site default, and site symmetry list, etc.
					;# init_design.tech_setup.tcl is the default. Use it as a template or provide your own script.
					;# This script will only get sourced if the following conditions are met: 
					;# (1) TECH_FILE is specified (2) TECH_LIB is specified && TECH_LIB_INCLUDES_TECH_SETUP_INFO is false
## ASIP-LIB_SPECIFIC ## set DESIGN_LIBRARY_SCALE_FACTOR	""	;# Optional; Specify the length precision for the library. Length precision for the design
					;# library and its ref libraries must be identical. Tool default is 10000, which implies one unit is one Angstrom or 0.1nm. 
## ASIP-LIB_SPECIFIC ## set ROUTING_LAYER_DIRECTION_OFFSET_LIST "" 
					;# Specify the routing layers as well as their direction and offset in a list of space delimited pairs;
					;# This variable should be defined for all metal routing layers in technology file;
					;# Syntax is "{metal_layer_1 direction offset} {metal_layer_2 direction offset} ...";
					;# It is required to at least specify metal layers and directions. Offsets are optional. 
					;# Example1 is with offsets specified: "{M1 vertical 0.2} {M2 horizontal 0.0} {M3 vertical 0.2}"
					;# Example2 is without offsets specified: "{M1 vertical} {M2 horizontal} {M3 vertical}"
## ASIP-LIB_SPECIFIC ## set MIN_ROUTING_LAYER		""	;# Optional; Min routing layer name; normally should be specified; otherwise tool can use all metal layers
## ASIP-LIB_SPECIFIC ## set MAX_ROUTING_LAYER		""	;# Optional; Max routing layer name; normally should be specified; otherwise tool can use all metal layers

##################################################
### 3. Verilog, dc inputs, upf, mcmm, timing, etc 
##################################################

## ASIP-DESIGN_SPECIFIC ##
set RTL_SOURCE_FORMAT		"script" ;# Specify one format out of verilog | sverilog | vhdl | script
                                                 ;# RTL source files when RTL_SOURCE_FORMAT = verilog | sverilog | vhdl

## ASIP-DESIGN_SPECIFIC ##
set RTL_SOURCE_FILES        [lmap FILE $FILENAMES { file join ${RTL_SOURCE_DIR} ${FILE} } ]
       ;# RTL read scripts when RTL_SOURCE_FORMAT = script
## ASIP-DESIGN_SPECIFIC ##
set FC_RTL_READ_SCRIPT		asip.FC.read_design.tcl
set FM_RTL_READ_SCRIPT		${DESIGN_NAME}.FM.read_design.tcl
## ASIP-DESIGN_SPECIFIC ##
set UPF_MODE      		"none" ;# prime | golden | none; Defines the UPF mode. By default the UPF prime mode. Can also select 
                          		;# the golden UPF mode or no UPF.
set UPF_FILE 			""	;# A UPF file
					;# 	for PNR: required if INIT_DESIGN_INPUT is ASCII in fc_setup.tcl; not required for DC_ASCII or DP_RM_NDM
set UPF_SUPPLEMENTAL_FILE	""      ;# The supplemental UPF file. Only needed if you are running golden UPF flow, in which case, you need both UPF_FILE and this.
					;# 	for PNR: required if INIT_DESIGN_INPUT is ASCII in fc_setup.tcl; not required for DC_ASCII or DP_RM_NDM
					;#	    If UPF_SUPPLEMENTAL_FILE is specified, scripts assume golden UPF flow. load_upf and save_upf commands will be different.
set UPF_UPDATE_SUPPLY_SET_FILE	""	;# A UPF file to resolve UPF supply sets
set VERILOG_NETLIST_FILES	""	;# Verilog netlist files;
					;# 	for PNR: required if INIT_DESIGN_INPUT is ASCII in fc_setup.tcl; not required for DC_ASCII or DP_RM_NDM
## ASIP-DESIGN_SPECIFIC ##
set TCL_MCMM_SETUP_FILE		"mcmm.tcl"	;# Specify a Tcl script to create your corners, modes, scenarios and load respective constraints;
					;# two examples are provided : 
					;# examples/TCL_MCMM_SETUP_FILE.explicit.tcl: provide mode, corner, and scenario constraints; create modes, corners, 
					;# and scenarios; source mode, corner, and scenario constraints, respectively 
					;# examples/TCL_MCMM_SETUP_FILE.auto_expanded.tcl: provide constraints for the scenarios; create modes, corners, 
					;# and scenarios; source scenario constraints which are then expanded to associated modes and corners
					;# 	for PNR: required if INIT_DESIGN_INPUT is ASCII in fc_setup.tcl; not required for DC_ASCII or DP_RM_NDM
## ASIP-LIB_SPECIFIC ## set TCL_PARASITIC_SETUP_FILE	"read_parasitic_tech.tcl"	;# Specify a Tcl script to read in your TLU+ files by using the read_parasitic_tech command;
					;# refer to the example in examples/TCL_PARASITIC_SETUP_FILE.tcl
set POCV_CORNER_FILE_MAPPING_LIST 	"" ;# Optional; a list of corner and its associated POCV file in pairs, as POCV is corner dependant;
					;# same corner can have multiple corresponding files;
					;# example: set POCV_CORNER_FILE_MAPPING_LIST "{corner1 file1a} {corner1 file1b} {corner2 file2}";
					;# in the example, file1a and file1b will be loaded for corner1, file2 will be loaded for corner2.
					;# Note: POCV_CORNER_FILE_MAPPING_LIST will take precedence if AOCV_CORNER_TABLE_MAPPING_LIST is also specified
set AOCV_CORNER_TABLE_MAPPING_LIST 	"" ;# Optional; a list of corner and its associated AOCV table in pairs, as AOCV is corner dependant;
					;# same corner can have multiple corresponding tables;
					;# example: set AOCV_CORNER_TABLE_MAPPING_LIST "{corner1 table1a} {corner1 table1b} {corner2 table2}";
					;# in the example, table1a and table1b will be loaded for corner1, table2 will be loaded for corner2.

set FUSA_SSF_FILE "${ASIP_SCRIPTS}/asip.ssf"  ;# Point this for the loading the primary SSF. This is a mandatory file if "ENABLE_FUSA" is true
set FUSA_SSF_UPDATE_FILE ""                   ;# This is an optional SSF file which could be used to update the primary SSF
set FUSA_SSF_AUX_FILE    ""                   ;# This is an optional SSF file which is used to load the SSF from Spyglass/Testmax
set TCL_FUSA_POST_MAP_SETUP_FILE ""           ;# Use this file to edit the the netlist to manually inserting safety register after "initial_map", 
                                              ;# and also load the SSF

##################################################
### 4. DEF, floorplan, placement constraints, etc 
##################################################
set TCL_FLOORPLAN_FILE			"" ;# Optional; Tcl floorplan file written by the write_floorplan command; for example, floorplan/floorplan.tcl;
					;# TCL_FLOORPLAN_FILE and DEF_FLOORPLAN_FILES are mutually exclusive; please specify only one of them;
					;# Not effective if INIT_DESIGN_INPUT = DC_ASCII or DP_RM_NDM.
					;# The write_floorplan command writes a floorplan.tcl Tcl script and a floorplan.def DEF file;
					;# reading floorplan.tcl alone can restore the entire floorplan - refer to write_floorplan man for more details

set DEF_FLOORPLAN_FILES			"" ;# Optional; DEF files which contain the floorplan information; for ex: "1.def 2.def"; not required for DP
					;# 	for PNR: required if INIT_DESIGN_INPUT = ASCII in fc_setup.tcl and neither TCL_FLOORPLAN_FILE or 
					;#		 initialize_floorplan is used; DEF_FLOORPLAN_FILES and TCL_FLOORPLAN_FILE are mutually exclusive;
					;# 	         not required if INIT_DESIGN_INPUT = DC_ASCII or DP_RM_NDM
set DEF_READ_OPTIONS			"-add_def_only_objects all" ;# default is "-add_def_only_objects all"; set it to "" (empty) if you don't need any option
					;# specifies the options used by read_def command
set SITE_SYMMETRY_LIST			"" ;# Optional; Specify a list of site def and its symmetry value;
					;# this is to be used by read_def or initialize_floorplan command to control the site symmetry;
					;# example: set SITE_SYMMETRY_LIST "{unit Y} {unit1 Y}"; this is applied in the init_design.tech_setup.tcl script
set SITE_DEFAULT			"" ;# Optional; Specify the default site name if there are multiple site defs in the technology file;
					;# this is to be used by initialize_floorplan command; example: set SITE_DEFAULT "unit";
					;# this is applied in the init_design.tech_setup.tcl script

set BOUNDARY_CELL_INSERTION		true ;# true|false; sources the boundary cell sidefile if applicable; set it to false to skip
set TAP_CELL_INSERTION			true ;# true|false; sources the tap cell sidefile if applicable; set it to false to skip

set TCL_ADDITIONAL_FLOORPLAN_FILE 	"" ;# a supplementary Tcl constraint file; sourced after DEF_FLOORPLAN_FILE or TCL_FLOORPLAN_FILE is read, 
					;# or initialize_floorplan is done; can be used to cover additional floorplan constructs, 
					;# such as bounds, pin guides, or route guides, etc; not valid if INIT_DESIGN_INPUT = DC_ASCII or DP_RM_NDM.

set TCL_MV_SETUP_FILE			"" ;# Optional; a Tcl script placeholder for your MV setup commands,such as create_voltage_area, 
					;# placement bound, power switch creation and level shifter insertion, etc;
					;# refer to examples/TCL_MV_SETUP_FILE.tcl for sample commands
set DEF_SCAN_FILE			"" ;# Optional; A scan DEF file for scan chain information;
					;# 	for PNR: not required if INIT_DESIGN_INPUT = DC_ASCII or DP_RM_NDM, as SCANDEF is expected to be loaded already   
### TCL_PLACEMENT_CONSTRAINT_FILE_LIST contents 
set TCL_PLACEMENT_CONSTRAINT_FILE_LIST "" ;# Optional; A list of files for your placement spacing labels, spacing rules, or abutment rules
					;# Example : set_placement_spacing_label -name X -side both -lib_cells [get_lib_cells -of [get_cells]]
					;# Example : set_placement_spacing_rule -labels {X SNPS_BOUNDARY} {0 1}
set TCL_PG_CREATION_FILE		"" ;# Optional; a Tcl script placeholder for your power ground network creation commands,
					;# such as create_pg*, set_pg_strategy, compile_pg, etc;
set TCL_USER_CONNECT_PG_NET_SCRIPT ""	;# An optional Tcl file for customized connect_pg_net command and options, such as for bias pins of cells added by opto;
					;# sourced by all the main scripts prior to the save_block command
set TCL_USER_SPARE_CELL_PRE_SCRIPT	"" ;# An optional Tcl file for spare cell insertion to be sourced before place_opt;
					   ;# Example : examples/TCL_USER_SPARE_CELL_PRE_SCRIPT.tcl
set TCL_USER_SPARE_CELL_POST_SCRIPT	"" ;# An optional Tcl file for spare cell insertion to be sourced after place_opt;
					   ;# Example : examples/TCL_USER_SPARE_CELL_POST_SCRIPT.tcl

########################################################################################## 
## Variables for general optimization use
##########################################################################################
set TCL_DFT_PORTS_FILE                  "" ;# create DFT ports
set TCL_DFT_SETUP_FILE                  "" ;# DFT setup
set TCL_DFT_PRE_IN_COMPILE_SETUP_FILE   "" ;# DFT setup file for in_compile DFT flow to specify DFT signal set required before compile_fusion
                                           ;# For instane set_scan_element false and set_wrapper_configuration -reuse_threshold_commands
set TCL_CONSTRAINTS_SETUP_FILE          "" ;# Design constraints such as dont_touch, size_only, clock-gating settings, ...
set REBUILD_FROM_ASCII      		false ;# false | true; Rebuild the design from compile for the place_opt (UNIFIED_FLOW false) step or 
					;# clock_opt_cts (UNIFIED_FLOW true) step, or use the NDM database; Default is NDM.

## ASIP-DESIGN_SPECIFIC ##
set SAIF_FILE_LIST			$::env(ASIP_SAIF_FILE) ;# Specify a SAIF file or a list of SAIF files and options for accurate power computation
					;# Example for single SAIF use : set SAIF_FILE_LIST 1.saif;
					;# Example for multiple SAIF and options : set SAIF_FILE_LIST “{1.saif -scaling_ratio 5 -weight 2} {2.saif -scaling_ratio 5} {3.saif -path xyz}"
					;# sourced at the beginning of compile.tcl
## ASIP-DESIGN_SPECIFIC ##
set SAIF_FILE_POWER_SCENARIO		"func::ss" ;# SAIF_FILE_LIST related; specify a power scenario where the SAIF is to be applied
## ASIP-DESIGN_SPECIFIC ##
set SAIF_FILE_SOURCE_INSTANCE		$::env(ASIP_SAIF_INSTANCE) ;# SAIF_FILE_LIST related; name of the instance of the current design as it appears in SAIF file.
set SAIF_FILE_TARGET_INSTANCE		"" ;# SAIF_FILE_LIST related; name of the target instance on which activity is to be annotated.
set OPTIMIZATION_FREEZE_PORT_LIST 	"" ;# List of cells (for ex, clock gen modules, or customized logics that should not be touched) to which freeze_clock_ports 
					;# and freeze_data_ports attribute will be set to prevent optimization from modifying their port signature; 
					;# especially useful if you do formal verification by modules. 
					;# Sets opt.dft.hier_preservation to true and runs set_freeze_port -all on the specified cells.

## ASIP-LIB_SPECIFIC ## set TCL_LIB_CELL_PURPOSE_FILE 		"set_lib_cell_purpose.tcl" ;# A Tcl file which applies lib cell purpose related restrictions;
					;# You can specify it with your own customized script	
					;# RM default is set_lib_cell_purpose.tcl which includes the following restrictions, each controlled by
					;# an individual variable : dont use cells (TCL_LIB_CELL_DONT_USE_FILE), tie cells (TIE_LIB_CELL_PATTERN_LIST), 
					;# hold fixing (HOLD_FIX_LIB_CELL_PATTERN_LIST), CTS (CTS_LIB_CELL_PATTERN_LIST) and CTS-exclusive cells (CTS_ONLY_LIB_CELL_PATTERN_LIST).
					;# For jumpstart version, these variables are defined within set_lib_cell_purpose.tcl.


set TCL_CTS_NDR_RULE_FILE 		"./examples/cts_ndr.tcl" ;# Specify a script for clock NDR creation and association, to be sourced at place_opt
					;# By default the variable is set to ./examples/cts_ndr.tcl, which is an RM provided example.
					;# All the variables for customizing the clock NDR are defined within the example script.
set PREROUTE_CTS_PRIMARY_CORNER		"" ;# <a corner>; RM default is unspecified; sets cts.compile.primary_corner; optional in RM;
					;# CTS automatically picks a corner with worst delay as the primary corner for its compile stage, 
					;# which inserts buffers to balance clock delays in all modes of the corner; 
					;# this setting allows you to manually specify a corner for the tool to use instead
set TCL_USER_MSCTS_MESH_ROUTING_SCRIPT 	"" ;# An optional Tcl file that can be provided for clock mesh net routing

set TCL_ANTENNA_RULE_FILE		"" ;# Antenna rule file; Example : examples/TCL_ANTENNA_RULE_FILE.txt

## For redundant via insertion
set ENABLE_REDUNDANT_VIA_INSERTION	false ;# false|true; tool default false; optional in RM; enables redundant via insertion in clock_opt_opto.tcl, route_auto.tcl, and route_opt.tcl
set TCL_USER_REDUNDANT_VIA_MAPPING_FILE "" ;# FC via mapping file is required for redundant via insertion; 
					;# Example : examples/TCL_USER_REDUNDANT_VIA_MAPPING_FILE.txt

########################################################################################## 
## Variables for scenario activation and focused scenario
##########################################################################################
set COMPILE_ACTIVE_SCENARIO_LIST	"" ;# A subset of scenarios to be made active during compile step;
					;# once set, the list of active scenarios is saved and carried over to subsequent steps;
					;# include CTS scenarios if you are enabling CTS related features during compile.
set PLACE_OPT_ACTIVE_SCENARIO_LIST	"" ;# A subset of scenarios to be made active during place_opt step;
					;# once set, the list of active scenarios is saved and carried over to subsequent steps;
					;# include CTS scenarios if you are enabling CTS related features during place_opt,
set CLOCK_OPT_CTS_ACTIVE_SCENARIO_LIST  "" ;# A subset of scenarios to be made active during clock_opt_cts step;
					;# once set, the list of active scenarios is saved and carried over to subsequent steps;
set ROUTE_OPT_ACTIVE_SCENARIO_LIST 	"" ;# A subset of scenarios to be made active during route_opt step;
					;# once set, the list of active scenarios is saved and carried over to subsequent steps;
set CLOCK_OPT_OPTO_ACTIVE_SCENARIO_LIST "$ROUTE_OPT_ACTIVE_SCENARIO_LIST" ;# A subset of scenarios to be made active during clock_opt_opto step;
					;# once set, the list of active scenarios is saved and carried over to subsequent steps;
					;# with GRE, the same set of scenarios are recommended to be used across clock_opt_opto, route_auto, and route_opt
set ROUTE_AUTO_ACTIVE_SCENARIO_LIST 	"$ROUTE_OPT_ACTIVE_SCENARIO_LIST" ;# A subset of scenarios to be made active during route_auto step;
					;# once set, the list of active scenarios is saved and carried over to subsequent steps;
					;# with GRE, the same set of scenarios are recommended to be used across clock_opt_opto, route_auto, and route_opt
set CHIP_FINISH_ACTIVE_SCENARIO_LIST 	"" ;# A subset of scenarios to be made active during chip_finish step.
					;# once set, the list of active scenarios is saved and carried over to subsequent steps.
set ICV_IN_DESIGN_ACTIVE_SCENARIO_LIST 	"" ;# A subset of scenarios to be made active during icv_in_design step;
					;# once set, the list of active scenarios is saved and carried over to subsequent steps;
set ENDPOINT_OPT_ACTIVE_SCENARIO_LIST 	"" ;# A subset of scenarios to be made active during endpoint_opt step;
					;# once set, the list of active scenarios is saved and carried over to subsequent steps;
set TIMING_ECO_ACTIVE_SCENARIO_LIST 	"" ;# A subset of scenarios to be made active during the timing_eco step;
					;# once set, the list of active scenarios is saved and carried over to subsequent steps;

set ROUTE_FOCUSED_SCENARIO		"" ;# Specify a dominant scenario for timing driven route. Timing driven route assigns layer based on the dominant scenario;
					;# default is not specified and tool will pick it based on timing QoR per scenario.
					;# If specified, script sets route.common.focus_scenario in clock_opt_opto.tcl before GRE. 

##########################################################################################
## Variables for Functional Safety
##########################################################################################
# DCLS
set DCLS_CLOCK_SPLIT_BUF ""
set DCLS_BOUNDARY_PROTECTION_BUF ""

##########################################################################################
## Variables for chip finishing related settings (Used by chip_finish.tcl)
##########################################################################################
## Std cell filler and decap cells used by chip_finish step and post ECO refill in timing_eco step
set CHIP_FINISH_METAL_FILLER_PREFIX 	"RM_filler" ;# A string to specify the prefix for metal filler (decap) cells. Required if running ECO flow.
set CHIP_FINISH_NON_METAL_FILLER_PREFIX $CHIP_FINISH_METAL_FILLER_PREFIX ;# A string to specify the prefix for non-metal fillers.

set CHIP_FINISH_METAL_FILLER_LIB_CELL_LIST "" ;# A list of metal filler (decap) lib cells, including the library name, for ex, 
					   ;# Example: "hvt/DCAP_HVT lvt/DCAP_LVT". Recommended to specify decaps from largest to smallest.
set CHIP_FINISH_NON_METAL_FILLER_LIB_CELL_LIST "" ;# A list of non-metal filler lib cells, including the library name, for ex,
					   ;# Example: hvt/FILL_HVT lvt/FILL_LVT. Recommended to specify them from largest to smallest.

## Signal EM
set CHIP_FINISH_SIGNAL_EM_CONSTRAINT_FORMAT "ITF" ;# Specify signal EM constraint format: ITF | ALF; string is uppercase and ITF is default
set CHIP_FINISH_SIGNAL_EM_CONSTRAINT_FILE "" ;# A constraint file which contains signal electromigration constraints;
					   ;# specify an ITF file if CHIP_FINISH_SIGNAL_EM_CONSTRAINT_FORMAT is set to ITF, and specify an
					   ;# ALF file if CHIP_FINISH_SIGNAL_EM_CONSTRAINT_FORMAT is set to ALF;
					   ;# required for signal EM analysis and fixing to be enabled
set CHIP_FINISH_SIGNAL_EM_SAIF 		"" ;# An optional SAIF file for the signal EM analysis.
set CHIP_FINISH_SIGNAL_EM_SCENARIO 	"" ;# Specify an active scenario which is enabled for setup and hold analysis;
					   ;# Required for signal EM analysis and fixing to proceed.
set CHIP_FINISH_SIGNAL_EM_FIXING 	false ;# Enable signal EM fixing; false | true; false is default

########################################################################################## 
## Variables for ICV in-design related settings (used by icv_in_design.tcl)
##########################################################################################
## signoff_check_drc specific variables
set ICV_IN_DESIGN_DRC_CHECK_RUNSET 		"" ;# The foundry runset for ICV used by signoff_check_drc
set ICV_IN_DESIGN_DRC_CHECK_RUNDIR 		"z_check_drc" 
					   	;# The working directory for the signoff_check_drc before signoff_fix_drc;
					   	;# The directory that contains the initial DRC error database for signoff_fix_drc.

set ICV_IN_DESIGN_DRC_USER_DEFINED_OPTIONS 	"" ;# Specify user defined ICV options for signoff_check_drc.
set ICV_IN_DESIGN_DRC_FILL_VIEW_DATA 		"read" ;# Specify when to read the fill view data. Valid options are read (default) | read_if_uptodate | discard
set ICV_IN_DESIGN_DRC_CELL_VIEWS 		"frame" ;# Specify library cell view to read. Valid options are frame (default) | layout | design;  
						;# See signoff.check_drc.read_layout_views & signoff.check_drc.read_design_views MAN pages for additional details.
set ICV_IN_DESIGN_DRC_EXCLUDED_CELL_TYPES 	"" ;# Specify cell types to exclude from analysis.  Valid options are lib_cell | macro | pad | filler.  
						;# By default, all cell types are checked.  See signoff.check_drc.excluded_cell_types MAN pages for additional details.
set ICV_IN_DESIGN_DRC_IGNORE_CHILD_CELL_ERRORS 	false ;# By default (false), DRC violations inside cell instances are reported.  
						;# Set to “true” to skip reporting of DRC inside cell instances.
set ICV_IN_DESIGN_DRC_SELECT_RULES 		"" ;# Specify design rules to check.  The specified rules will be the only rules evaluated.  By default, all design rules are checked.
set ICV_IN_DESIGN_DRC_UNSELECT_RULES 		"" ;# Specify design rules to omit from checking.  By default, all design rules are checked.
set STREAM_FILES_FOR_MERGE 			"" ;# Specify a list of stream (GDS or OASIS) files to be merged into the current design for signoff_check_drc or signoff_create_metal_fill.

## singoff_fix_drc specific variables
## ASIP-DESIGN_SPECIFIC ## Default: true
set ICV_IN_DESIGN_DRC				false ;# true|false; true enables signoff_check_drc.
set ICV_IN_DESIGN_ADR 				false ;# true|false; true enables signoff_fix_drc in addition to signoff_check_drc; default is false
set ICV_IN_DESIGN_ADR_RUNDIR 			"z_adr"	;# The working directory for signoff_fix_drc; only takes effect if ICV_IN_DESIGN_ADR is true
set ICV_IN_DESIGN_ADR_USER_DEFINED_OPTIONS 	"" ;# Specify user defined ICV options for singoff_fix_drc.

set ICV_IN_DESIGN_POST_ADR_RUNDIR 		"z_post_adr" ;# The working directory for signoff_check_drc after signoff_fix_drc is done; 
					   	;# only takes effect if ICV_IN_DESIGN_ADR is true 

set ICV_IN_DESIGN_ADR_DPT_RULES 		"" ;# Specify your DPT rules for signoff_fix_drc fixing; only takes effect if ICV_IN_DESIGN_ADR is true
set ICV_IN_DESIGN_ADR_DPT_RUNDIR		"z_adr_with_dpt" ;# The working directory for signoff_check_drc with DPT rule fixing;
					   	;# only takes effect if ICV_IN_DESIGN_ADR_DPT_RULES (DPR rules) is specified
set ICV_IN_DESIGN_POST_ADR_DPT_RUNDIR		"z_post_adr_with_dpt" ;# The working directory for signoff_check_drc after DPT rule fixing is done;
					   	;# only takes effect if ICV_IN_DESIGN_ADR_DPT_RULES (DPR rules) is specified

## Metal fill specific variables
set ICV_IN_DESIGN_METAL_FILL 			false ;# Default false; set it to true to enable the metal fill creation feature.
set ICV_IN_DESIGN_METAL_FILL_RUNSET		"" ;# Specify the foundry runset for signoff_create_metal_fill command;
					   	;# required only by non track-based metal fill (ICV_IN_DESIGN_METAL_FILL_TRACK_BASED set to off).
set ICV_IN_DESIGN_METAL_FILL_RUNDIR		"z_icvFill" ;# The working directory for signoff_create_metal_fill. Optional. Default is z_icvFill.

set ICV_IN_DESIGN_METAL_FILL_USER_DEFINED_OPTIONS "" ;# Specify user defined ICV options for signoff_create_metal_fill.
set ICV_IN_DESIGN_METAL_FILL_FIX_DENSITY_ERRORS "false" ;# Specify if density rules will be honored during fill insertion, removal, or addition.  
						;# See signoff.create_metal_fill.fix_density_errors for additional details.
set ICV_IN_DESIGN_METAL_FILL_SELECT_LAYERS 	"" ;# Specify layers on which to insert metal fill.  By default, all routing layers will be filled.

set ICV_IN_DESIGN_METAL_FILL_TIMING_DRIVEN_THRESHOLD "" 
					   	;# Specify the threshold for timing-driven metal fill.
					   	;# If not specified, timing-driven is not enabled.
					   	;# If specified, "-timing_preserve_setup_slack_threshold" option is added.
set ICV_IN_DESIGN_METAL_FILL_TRACK_BASED 	"off" ;# off | <a technology node> | generic; used for -track_fill option of signoff_create_metal_fill
					   	;# for non-track-based : specify off 
					   	;# for track-based : specify either a node (refer to man page) or generic 
set ICV_IN_DESIGN_METAL_FILL_ECO_THRESHOLD 	"" ;# Specify the percent change to perform incremental fill.  If unspecified, the tool default value is used.
set ICV_IN_DESIGN_POST_METAL_FILL_RUNDIR 	"z_MFILL_after" 
					   	;# The working directory for the signoff_check_drc after signoff_create_metal_fill is completed;
					   	;# only takes effect if ICV_IN_DESIGN_METAL_FILL is true
set ICV_IN_DESIGN_METAL_FILL_TRACK_BASED_PARAMETER_FILE "auto" ;# auto | <a parameter file>; default is auto;
					   	;# this variable is only for track-based metal fill;
					   	;# specify auto to use tool auto generated track_fill_params.rh file or your own paramter file.

########################################################################################## 
## Variables for settings related to write data (used by write_data.tcl)
##########################################################################################
## write_gds related
set WRITE_GDS_LAYER_MAP_FILE 		"" ;# A layer map file which provides a mapping between the tool and GDS layers
set WRITE_OASIS_LAYER_MAP_FILE 		"" ;# A layer map file which provides a mapping between the tool and OASIS layers

########################################################################################## 
## Variables for route_opt target endpoint PBA CCD (used by endpoint_opt.tcl) 
##########################################################################################
set ENDPOINT_OPT_MAX_PATHS 		"10000" ;# Required input; an integer; specify number of paths to collect; default 10000
set ENDPOINT_OPT_SLACK_THRESHOLD	"-0.001" ;# Required input; a float with unit in ns; collect paths with slack worse than the specified value for target endpoint to work on; 
					;# default is -0.001 when current timing unit is ns; user specifeid value is based on the timing unit of the current design;
					;# if user specified threshold is less than -1ps, the proc will set it to -0.001ns (i.e. -1ps).
set ENDPOINT_OPT_TARGET_SCENARIOS	"*" ;# Required input; a list of scenarios; collect timing paths from the specified scenarios for target endpoint to work on; 
					;# default is * which means all active setup scenarios will be included
set ENDPOINT_OPT_LOOP			1 ;# Required input; an integer; specify number of loops; default is 1
set ENDPOINT_OPT_PATH_GROUP_FILTER 	"" ;# Optional input; specify a filter to exclude certain path groups from route_opt target endpoint PBA CCD; to be used by get_path_groups -filter  
					;# for example, set ENDPOINT_OPT_PATH_GROUP_FILTER "name!~IN* && name!~OUT* && name!~*default*" -> exlcudes IO and default path groups

########################################################################################## 
## Variables for Redhawk & Redhawk-SC (RHSC) in-design related settings 
## (used by redhawk_in_design_pnr.tcl & rhsc_in_design_pnr.tcl ; SNPS_INDESIGN_RH_RAIL license required)
##########################################################################################
set REDHAWK_SC_DIR                      "" ;# Required; path to RedHawk-SC binary
set REDHAWK_SC_GRID_FARM	        "" ;# Optional; commands to submit RedHawk-SC in GRID FARM

set REDHAWK_DIR				"" ;# Required; path to RedHawk binary

set REDHAWK_PAD_FILE_NDM                "" ;# The file include tap points on NDM. Default is top level pins.
set REDHAWK_PAD_FILE_PLOC               "";
set REDHAWK_PAD_CUSTOMIZED_SCRIPT       "" ;# User script to run command create_taps with different options 
					;# Example : ./examples/REDHAWK_PAD_CUSTOMIZED_SCRIPT.txt

set REDHAWK_FREQUENCY			"" ;# Optional to pass frequency to RedHawk 
set REDHAWK_TEMPERATURE			"" ;# Optional to pass temperature to RedHawk
set REDHAWK_SCENARIO		        "" ;# Optional to specify current scenario for running RedHawk

set REDHAWK_ANALYSIS_NETS 		"" ;# Required. Specify the list of power and ground nets in pairs and in separate lines for the analysis;
					   ;# for example, "VDD1 VSS1 VDD2 VSS2 VDD3 VSS3", where VDD* are power nets and VSS* are ground nets.

set REDHAWK_LAYER_MAP_FILE              "" ;# Optional. The file include process layer name and LEF layer name

set REDHAWK_TECH_FILE 			"" ;# Required. Apache Technology File
set REDHAWK_MACROS 			"" ;# Optional. List of Macro names and macro directories in pairs and in separate lines;
					   ;# for example, "macro1_name macro1_directory 
					   ;#		    macro2_name macro2_directory 
					   ;#		    macro3_name macro3_directory"
set REDHAWK_SWITCH_MODEL_FILES 		"" ;# Optional. List of switch model files;
					   ;# for example: "switch_model_file1 
					   ;#               switch_model_file2 
					   ;#		    switch_model_file3"
set REDHAWK_LIB_FILES 			"" ;# Required. List of .lib files in separate lines.
					   ;# for example: "/home/lib_1.lib 
					   ;#               /home/lib_2.lib
					   ;#               /home/lib_3.lib"
set REDHAWK_APL_FILES			"" ;# Required for dynamic analysis.  List of apl files in separate lines.
					   ;# for example: "x.cdev cdev
					   ;#               x.current current
					   ;#               y.cdev cdev
					   ;#               y.current current"
set REDHAWK_EXTRA_GSR 			"" ;# Optional. Provide a file with custom Redhawk settings.
set REDHAWK_ANALYSIS 			"static" ;# Required. Specify of the analyses below:
                                           ;# For Static analysis: "static"
                                           ;# For Vector-based Dynamic analysis: "dynamic_vcd"
                                           ;# For Vectorless Dynamic analysis: "dynamic_vectorless"
                                           ;# For Effective Resistance analysis: "effective_resistance"
                                           ;# For Minimum path resistance analysis: "min_path_resistance"
                                           ;# For Integrity Check: "check_missing_via"
set REDHAWK_OUTPUT_REPORT 		"" ;# Optional. Specify a file name to have the output report produced:
                                           ;# For Static or dynamic analysis: the effective voltage drop is reported
                                           ;# For Effective Resistance analysis: the effective resistance is reported
                                           ;# For Minimum path resistance analysis: the minimum path resistance is reported
                                           ;# For Integrity Check: the missing vias are reported
set REDHAWK_EM_ANALYSIS 	   	false ;# Optional. Set to true if EM analysis to be performed with static or dynamic analysis.
set REDHAWK_EM_REPORT 			"" ;# Optional. Specify a file name to have the EM output report produced.

set REDHAWK_SCRIPT_FILE 		"" ;# Optional. Specify a file as Redhawk standalone run tcl file.
set RHSC_PYTHON_SCRIPT_FILE             "" ;# Optional. Specify a file as RHSC standalone run python script
set RHSC_GENERATE_COLLATERAL	        "" ;# Optional. The command analyze_rail only generate TWF, DEF, SPEF, PLOC files, this work with RHSC_PYTHON_SCRIPT_FILE

set REDHAWK_SWITCHING_ACTIVITY_FILE 	"" ;# Required for vector-based dynamic analysis.  Format is as follows:
                                           ;# {file_format [file_name] [strip_path]}
set REDHAWK_FIX_MISSING_VIAS       	false ;# Optional. Set to true to enable inserting vias to missing via locations after the check_missing_via flow is run.
set REDHAWK_MISSING_VIA_POS_THRESHOLD	"" ;# Optional. Set to positive voltage between two overlapped layers for filtering purpose.  Default is no filtering.
set REDHAWK_RAIL_DATABASE               RAIL_DATABASE  ;# Optional. Set ICC2 Redhawk Fusion output directory.
set REDHAWK_PGA_POWER_NET               "" ; #Required.  Set one power net for PGA.
set REDHAWK_PGA_GROUND_NET              "" ; #Required.  Set one ground net for PGA
set REDHAWK_PGA_NODE                    "" ; #Required. Set the technology node such as tsmc16.
set REDHAWK_PGA_ICV_DIR                 "" ; #Required. Set the path to the ICV binary.  Example: /global/apps/icv_2018.06
set REDHAWK_PGA_CUSTOMIZED_SCRIPT       "" ;# Optional to add customized PGA setting
					;# Example : ./examples/REDHAWK_PGA_CUSTOMIZED_SCRIPT.txt

########################################################################################## 
## Variables for Timing ECO related settings (used by timing_eco.tcl)
##########################################################################################
## The following ECO_OPT* variables are for ECO fusion.  The PT setup is also needed when implementing the user provided PT change file, as PT reporting is run.
set ECO_OPT_PT_PATH			"" ;# Required by eco_opt; specify the path to pt_shell; for example: /u/mgr/bin/pt_shell
					;# if specified, eco_opt
set ECO_OPT_DB_PATH			"" ;# Optional; specify the paths to .db files of the reference libraries for PT (if not already in your search path)
					;# For eco_opt, PT needs to read db. 
set ECO_OPT_TYPE			"" ;# Optional; eco_opt fixing type; timing|setup|hold|drc|leakage_power|dynamic_power|total_power|buffer_removal
					;# if not specified, works on all types
set ECO_OPT_RECIPE_FILE			"" ;# Optional; specify a metric type recipe for one or more eco_opt runs.  
					;# An example file is located in examples/ECO_OPT_RECIPE_FILE.tcl.
set ECO_OPT_PHYSICAL_MODE		"" ;# Specify none, open_site, or occupied_site to guide physical impact.  If not specified, the tool default of "open_site" is run.
set ECO_OPT_WITH_PBA 			false ;# Default false; sets time.pba_optimization_mode to path to enable PBA for eco_opt
set ECO_OPT_EXTRACTION_MODE		"fusion_adv" ;# fusion_adv|in_design|none; default is fusion_adv; sets extract.starrc_mode to corresponding value;
					;# fusion_adv and in_design modes require ECO_OPT_STARRC_CONFIG_FILE to be specified;
					;# refer to ROUTE_OPT_STARRC_CONFIG_FILE.example.txt for sample syntax
set ECO_OPT_STARRC_CONFIG_FILE 		"" ;# Required when using fusion_adv or in_design extraction modes; specify the configuration file
set ECO_OPT_WORK_DIR			"eco_opt_dir" ;# Optional; specify the working directory for eco_opt where PT files and logs are generated;
					;# if not specified, tool will automatically generate one
set ECO_OPT_PRE_LINK_SCRIPT		"" ;# Optional; specify the file that contains custom PT script, which is executed before linking in PrimeTime;
					;# use PT commands that do not require the current design
set ECO_OPT_POST_LINK_SCRIPT		"" ;# Optional; specify the file that contains custom PT script, which is executed after linking in PrimeTime;
					;# use PT commands that require the current design
set ECO_OPT_PT_CORES_PER_SCENARIO	"4" ;# Specify the number of cores per scenario for PT DMSA.
set ECO_OPT_SIGNOFF_SCENARIO_PAIR	"" ;# Optional; Provide scenario constraints file for PT.  Uses a list of {scenario sdc} pairs.
set ECO_OPT_FILLER_CELL_PREFIX 		"$CHIP_FINISH_METAL_FILLER_PREFIX" ;# A string to specify the prefix used to identify filler cells to remove prior to running eco_opt.
					;# The default is set the same as CHIP_FINISH_METAL_FILLER_PREFIX.	
set ECO_OPT_CUSTOM_OPTIONS 		""

## The following variables apply when using a user provided PT change file.
set PT_ECO_CHANGE_FILE 			"" ;# The eco_opt mode (default) is run when not set.  When set, this points to the PT change file to implement.
set PT_ECO_MODE				"default" ;# Specify the preferred flow for the PT-ECO run; default|freeze_silicon
					   ;# default: sources $PT_ECO_CHANGE_FILE and place_eco_cells in MPI mode
					   ;# freeze_silicon: add_spare_cells, place_eco_cells, sources $PT_ECO_CHANGE_FILE, and place_freeze_silicon
set PT_ECO_DISPLACEMENT_THRESHOLD 	"10" ;# A float to specify the maximum displacement threshold value for 
					   ;# place_eco_cells -eco_changed_cells -legalize_mode minimum_physical_impact -displacement_threshold;

########################################################################################## 
## Variables for Functional ECO related settings (used by functional_eco.tcl)
##########################################################################################
set FUNCTIONAL_ECO_ACTIVE_SCENARIO_LIST	"" ;# Optional; a subset of scenarios to be made active during the step;
					   ;# once set, the list of active scenarios is saved and carried over to subsequent steps;
set TCL_USER_FUNCTIONAL_ECO_PRE_SCRIPT	"" ;# An optional Tcl file to be sourced before ECO operations.
set TCL_USER_FUNCTIONAL_ECO_POST_SCRIPT	"" ;# An optional Tcl file to be sourced after route_eco.
set FUNCTIONAL_ECO_DISPLACEMENT_THRESHOLD "10" ;# A float to specify the maximum displacement threshold value for 
					   ;# place_eco_cells -eco_changed_cells -legalize_mode minimum_physical_impact -displacement_threshold;
set FUNCTIONAL_ECO_VERILOG_FILE		"" ;# Required; the verilog file to be used for functional ECO.
set FUNCTIONAL_ECO_MODE			"default" ;# Specify the preferred flow; default|freeze_silicon
					   ;# default: sources $FUNCTIONAL_ECO_CHANGE_FILE and place_eco_cells in MPI mode
					   ;# freeze_silicon: add_spare_cells, place_eco_cells, sources $FUNCTIONAL_ECO_CHANGE_FILE, and place_freeze_silicon

########################################################################################## 
## Variables for pre and post plugins 
#  Placeholder plugin scripts are available in the rm_user_plugin_scripts directory. Use of the placeholder scripts is not required. Path to the plugin scripts can be updated as needed. 
##########################################################################################
set TCL_USER_NON_PERSISTENT_SCRIPT 	"non_persistent_script.tcl" ;# An optional Tcl file to be sourced in each step after opening a block.

set TCL_USER_INIT_DESIGN_PRE_SCRIPT 	"init_design_pre_script.tcl" ;# An optional Tcl file to be sourced at the very beginning of init_design.tcl.
set TCL_USER_INIT_DESIGN_POST_SCRIPT 	"init_design_post_script.tcl" ;# An optional Tcl file to be sourced at the very end of init_design.tcl before save_block.
set TCL_USER_READ_RTL_PRE_SCRIPT 	"read_rtl_pre_script.tcl" ;# An optional Tcl file for init_design.from_rtl.tcl to be sourced before reading RTL
set TCL_USER_READ_RTL_POST_SCRIPT 	"read_rtl_post_script.tcl" ;# An optional Tcl file for init_design.from_rtl.tcl to be sourced after reading RTL
set TCL_USER_COMPILE_PRE_SCRIPT 	"compile_pre_script.tcl" ;# An optional Tcl file for compile.tcl to be sourced before compile_fusion
set TCL_USER_COMPILE_PRE_INITIAL_PLACE_SCRIPT "compile_pre_initial_place_script.tcl" ;# An optional Tcl file for compile.tcl to be sourced after compile_fusion logic_opto before initial_place 
set TCL_USER_COMPILE_PRE_INITIAL_OPTO_SCRIPT "compile_pre_initial_opto_script.tcl" ;# An optional Tcl file for compile.tcl to be sourced after compile_fusion initial_drc before initial_opto
set TCL_USER_COMPILE_PRE_UNIFIED_SCRIPT "compile_pre_unified_script.tcl" ;# An optional Tcl file for compile.tcl to be sourced in the UNIFIED_FLOW before compile_fusion -from final_place
set TCL_USER_COMPILE_POST_SCRIPT 	"compile_post_script.tcl" ;# An optional Tcl file for compile.tcl to be sourced after compile_fusion
set TCL_USER_CREATE_DFT_PORTS_POST_SCRIPT "create_dft_ports_post_script.tcl" ;# An optional Tcl file for init_design.from_rtl.tcl to be sourced after "DFT Ports" but before "Read and commit the UPF" section

set TCL_USER_PLACE_OPT_PRE_SCRIPT 	"place_opt_pre_script.tcl" ;# An optional Tcl file for place_opt.tcl to be sourced before place_opt.
set TCL_USER_PLACE_OPT_SCRIPT 		"" ;# An optional Tcl file for place_opt.tcl to replace pre-existing place_opt commands.
set TCL_USER_PLACE_OPT_POST_SCRIPT 	"place_opt_post_script.tcl" ;# An optional Tcl file for place_opt.tcl to be sourced after place_opt.
set TCL_USER_CLOCK_OPT_CTS_PRE_SCRIPT 	"clock_opt_cts_pre_script.tcl" ;# An optional Tcl file for clock_opt_cts.tcl to be sourced before clock_opt.
set TCL_USER_CLOCK_OPT_CTS_SCRIPT 	"" ;# An optional Tcl file for clock_opt_cts.tcl to replace pre-existing clock_opt commands.
set TCL_USER_CLOCK_OPT_CTS_POST_SCRIPT 	"clock_opt_cts_post_script.tcl" ;# An optional Tcl file for clock_opt_cts.tcl to be sourced after clock_opt.

set TCL_USER_CLOCK_OPT_OPTO_PRE_SCRIPT 	"clock_opt_opto_pre_script.tcl" ;# An optional Tcl file for clock_opt_opto.tcl to be sourced before clock_opt.
set TCL_USER_CLOCK_OPT_OPTO_SCRIPT 	"" ;# An optional Tcl file for clock_opt_opto.tcl to replace pre-existing clock_opt commands.
set TCL_USER_CLOCK_OPT_OPTO_POST_SCRIPT "clock_opt_opto_post_script.tcl" ;# An optional Tcl file for clock_opt_opto.tcl to be sourced after clock_opt.

set TCL_USER_ROUTE_AUTO_PRE_SCRIPT 	"route_auto_pre_script.tcl" ;# An optional Tcl file for route_auto.tcl to be sourced before route_auto.
set TCL_USER_ROUTE_AUTO_SCRIPT 		"" ;# An optional Tcl file for route_auto.tcl to replace pre-existing routing commands.
set TCL_USER_ROUTE_AUTO_POST_SCRIPT 	"route_auto_post_script.tcl" ;# An optional Tcl file for route_auto.tcl to be sourced after route_auto.

set TCL_USER_ROUTE_OPT_PRE_SCRIPT 	"route_opt_pre_script.tcl" ;# An optional Tcl file for route_opt.tcl to be sourced before route_opt.
set TCL_USER_ROUTE_OPT_SCRIPT 		"" ;# An optional Tcl file for route_opt.tcl to replace pre-existing route_opt commands.
set TCL_USER_ROUTE_OPT_1_POST_SCRIPT 	"route_opt_1_post_script.tcl" ;# An optional Tcl file for customizations after first route_opt (for ex, customized secondary PG routing)
set TCL_USER_ROUTE_OPT_2_POST_SCRIPT 	"route_opt_2_post_script.tcl" ;# An optional Tcl file for customizations after second route_opt (for ex, customized secondary PG routing)
set TCL_USER_ROUTE_OPT_POST_SCRIPT 	"route_opt_post_script.tcl" ;# An optional Tcl file for route_opt.tcl to be sourced after route_opt.

set TCL_USER_ENDPOINT_OPT_PRE_SCRIPT 	"endpoint_opt_pre_script.tcl" ;# An optional Tcl file for endpoint_opt.tcl to be sourced before the main command.
set TCL_USER_ENDPOINT_OPT_SCRIPT 	"" ;# An optional Tcl file for endpoint_opt.tcl to replace the pre-existing main commands.
set TCL_USER_ENDPOINT_OPT_POST_SCRIPT 	"endpoint_opt_post_script.tcl" ;# An optional Tcl file for endpoint_opt.tcl to be sourced after the main command.

set TCL_USER_TIMING_ECO_PRE_SCRIPT 	"timing_eco_pre_script.tcl" ;# An optional Tcl file to be sourced before ECO operations.
set TCL_USER_TIMING_ECO_POST_SCRIPT 	"timing_eco_post_script.tcl" ;# An optional Tcl file to be sourced after ECO operations.

set TCL_USER_CHIP_FINISH_PRE_SCRIPT 	"chip_finish_pre_script.tcl" ;# An optional Tcl file for chip_finish.tcl to be sourced before filler cell insertion.
set TCL_USER_CHIP_FINISH_POST_SCRIPT 	"chip_finish_post_script.tcl" ;# An optional Tcl file for chip_finish.tcl to be sourced after metal fill insertion.

set TCL_USER_ICV_IN_DESIGN_PRE_SCRIPT 	"icv_in_design_pre_script.tcl" ;# An optional Tcl file for chip_finish.tcl to be sourced before signoff_check_drc.
set TCL_USER_ICV_IN_DESIGN_POST_SCRIPT 	"icv_in_design_post_script.tcl" ;# An optional Tcl file for chip_finish.tcl to be sourced after second signoff_check_drc.

##########################################################################################
## Label names ($DESIGN_NAME is the block name) : there's no need to change these
##########################################################################################
set READ_RTL_BLOCK_NAME                 "elaborated"                    ;# Label name to be used when saving a block in init_design.tcl
set COMPILE_BLOCK_NAME                  "compile"                       ;# Label name to be used when saving a block in compile.tcl
set COMPILE_INITIAL_BLOCK_NAME          "initial"                       ;# Label name to be used when saving a block in compile.tcl
set COMPILE_INCREMENTAL_BLOCK_NAME      "incremental"                   ;# Label name to be used when saving a block in compile.tcl
set INSERT_DFT_BLOCK_NAME               "insert_dft"                    ;# Label name to be used when saving a block in compile.tcl
set READ_DATA_BLOCK_NAME                $COMPILE_BLOCK_NAME             ;# Label name to be used for input to fm.fc.tcl
set INIT_DESIGN_BLOCK_NAME		"init_design"			;# Label name to be used when saving a block in init_design.tcl
set PLACE_OPT_BLOCK_NAME 		"place_opt" 			;# Label name to be used when saving a block in place_opt.tcl
set CLOCK_OPT_CTS_BLOCK_NAME 		"clock_opt_cts" 		;# Label name to be used when saving a block in clock_opt_cts.tcl
set CLOCK_OPT_OPTO_BLOCK_NAME 		"clock_opt_opto" 		;# Label name to be used when saving a block in clock_opt_opto.tcl
set ROUTE_AUTO_BLOCK_NAME 		"route_auto" 			;# Label name to be used when saving a block in route_auto.tcl
set ROUTE_OPT_BLOCK_NAME 		"route_opt" 			;# Label name to be used when saving a block in route_opt.tcl

set CHIP_FINISH_BLOCK_NAME 		"chip_finish" 			;# Label name to be used when saving a block in chip_finish.tcl
set ICV_IN_DESIGN_FROM_BLOCK_NAME	"chip_finish" 			;# Label name of the input block in icv_in_design.tcl
set ICV_IN_DESIGN_BLOCK_NAME		"icv_in_design" 		;# Label name to be used when saving a block in icv_in_design.tcl

set WRITE_DATA_FROM_BLOCK_NAME 		$ICV_IN_DESIGN_BLOCK_NAME 	;# Label name of the source block in write_data.tcl;
set WRITE_DATA_BLOCK_NAME 		"write_data" 			;# Label name to be used when saving a block in write_data.tcl
									;# default is ICV_IN_DESIGN_BLOCK_NAME

set ENDPOINT_OPT_BLOCK_NAME		"endpoint_opt"			;# Label name to be used when saving a block in endpoint_opt.tcl
set TIMING_ECO_FROM_BLOCK_NAME		"icv_in_design"			;# Label name of the input block in timing_eco.tcl
set TIMING_ECO_BLOCK_NAME		"timing_eco" 			;# Label name to be used when saving a block in timing_eco.tcl
set FUNCTIONAL_ECO_FROM_BLOCK_NAME	"icv_in_design" 		;# Label name of the input block in functional_eco.tcl;
set FUNCTIONAL_ECO_BLOCK_NAME		"functional_eco"		;# Label name to be used when saving a block in functional_eco.tcl

set REDHAWK_IN_DESIGN_PNR_FROM_BLOCK_NAME $ROUTE_OPT_BLOCK_NAME		;# Label name of the starting block for redhawk_in_design_pnr.tcl and rhsc_in_design_pnr.tcl;
set REDHAWK_IN_DESIGN_BLOCK_NAME 	"redhawk_in_design"		;# Label name of the starting block for redhawk_in_design_pnr.tcl and rhsc_in_design_pnr.tcl;

##########################################################################################
## Reporting
##########################################################################################
set OUTPUTS_DIR				"./outputs_fc" ;# Directory to write output data files; mainly used by write_data.tcl
set REPORTS_DIR				"./rpts_fc" ;# Directory to write reports; mainly used by report_qor.tcl
set LOGS_DIR				"./logs_fc" ;# Directory to logs; mainly used by Makefile*

set REPORT_QOR				true ;# true|false; RM default true; runs various reporting commands at end of each step;
					;# reporting commands vary by stage; set it to false to skip reporting
set REPORT_QOR_REPORT_CONGESTION	true ;# true|false; RM default reports congestion with "route_global -congestion_map_only true"
					;# at the end of preroute steps; set it to false to skip.

set REPORT_QOR_REPORT_POWER		true ;# true|false; RM default true;
					;# set it to false to skip report_power and report_clock_qor -type power during reporting
set REPORT_POWER_SAIF_FILE		"" ;# (optional) specify a SAIF file for report_power
set REPORT_POWER_SAIF_MAP		"${OUTPUTS_DIR}/${COMPILE_BLOCK_NAME}.saif.fc.map" ;# (optional) specify a SAIF map for report_power if REPORT_POWER_SAIF_FILE is also provided

set WRITE_QOR_DATA			true ;# true|false; report_qor.tcl also runs compare_qor_data command to generate QoR HTML file
set WRITE_QOR_DATA_DIR			"./qor_data"
set COMPARE_QOR_DATA_DIR		"./compare_qor_data"
set REPORT_PARALLEL_SUBMIT_COMMAND 	"" ;# for parallel reporting; if specified, script uses job submission for report_qor.tcl
					;# Note : if specified, enables parallel reporting; if not specified (default) runs sequential reporting
					;# Example parallel submit command : qsub -cwd -P di -pe mt 4 -m n
set REPORT_PARALLEL_MAX_CORES 		4 ;# specify core limit for parallel reporting
set SET_HOST_OPTIONS_MAX_CORE		8 ;# specify core limit for set_host_options -max_cores

set RELEASE_DIR_DP		"" 	;# Specify the release directory of DP RM; 
					;# this is where init_design.tcl of PNR flow gets DP RM released libraries;
set RELEASE_LABEL_NAME_DP 	"for_pnr"	
					;# Specify the label name of the block in the DP RM released library;
					;# this is the label name which init_design.tcl of PNR flow will open. 



