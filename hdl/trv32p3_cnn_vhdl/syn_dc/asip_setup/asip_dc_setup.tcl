source -echo -verbose $::env(ASIP_SETUP)/asip_common_setup.tcl
source -echo -verbose rm_setup/dc_setup_filenames.tcl

puts "RM-Info: Running script [info script]\n"

#################################################################################
# Design Compiler Reference Methodology Setup for Top-Down Flow
# Script: dc_setup.tcl
# Version: M-2016.12-SP4 (July 17, 2017)
# Copyright (C) 2007-2017 Synopsys, Inc. All rights reserved.
#################################################################################



#################################################################################
# Setup Variables
#
# Modify settings in this section to customize your Design Compiler Reference 
# Methodology run.
# Portions of dc_setup.tcl may be used by other tools so program name checks
# are performed where necessary.
#################################################################################

  # The following setting removes new variable info messages from the end of the log file
  set_app_var sh_new_variable_message false

if {$synopsys_program_name == "dc_shell" || $synopsys_program_name == "de_shell"}  {

  #################################################################################
  # Design Compiler and  DC Explorer Setup Variables
  #################################################################################

  # Use the set_host_options command to enable multicore optimization to improve runtime.
  # This feature has special usage and license requirements.  Refer to the 
  # "Support for Multicore Technology" section in the Design Compiler User Guide
  # for multicore usage guidelines.
  # Note: This is a DC Ultra feature and is not supported in DC Expert.

  set_host_options -max_cores 4

  if {[shell_is_dcnxt_shell]} {
      set_host_options -max_cores 8
  }


  # Change alib_library_analysis_path to point to a central cache of analyzed libraries
  # to save runtime and disk space.  The following setting only reflects the
  # default value and should be changed to a central location for best results.

  ######### BEGIN CHANGED FOR ASIP SCRIPTS ############
  # Set variable ASIP_ALIB_PATH in asip_lib_setup or
  # as env.variable to point to a different path
  # Original:
  # set_app_var alib_library_analysis_path .
  # Changed to:
  set_app_var alib_library_analysis_path .

  if {[info exists ASIP_ALIB_PATH] && [file isdir $ASIP_ALIB_PATH]} {
    puts "INFO: Setting alib_library_analysis_path to $ASIP_ALIB_PATH"
    set_app_var alib_library_analysis_path $ASIP_ALIB_PATH
  }

  if {[info exists ::env(ASIP_ALIB_PATH)] && [file isdir $::env(ASIP_ALIB_PATH)]} {
    puts "INFO: Setting alib_library_analysis_path to $ASIP_ALIB_PATH"
    set_app_var alib_library_analysis_path $::env(ASIP_ALIB_PATH)
  }
  ######### END CHANGED FOR ASIP SCRIPTS ############

  # Add any additional Design Compiler variables needed here

  ######### BEGIN CHANGED FOR ASIP SCRIPTS ############
  #The default number of significant digits used to display values in reports
  set_app_var report_default_significant_digits 3 ;# tool default is 2/
  ######### END CHANGED FOR ASIP SCRIPTS ############

  #################################################################################
  # DC Explorer Specific Setup Variables
  #################################################################################

  if {[shell_is_in_exploration_mode]} {
    # Uncomment the following setting to use top-level signal ports instead of a  
    # isolation power controller.

    # set_app_var upf_auto_iso_enable_source top_level_port

    # Uncomment the following setting to allow DC Explorer to perform optimization with
    # physical design data. 

    # set_app_var de_enable_physical_flow true 

    # Add any additional DC Explorer variables needed here

  }
}

# Note: When autoread is used ${RTL_SOURCE_FILES} can include a list of
#       both directories and files.


######### CHANGED FOR ASIP SCRIPTS ############
# Note: With auto_read, either the RTL source directory or a list of RTL source files
#       may be used. We specify both, but use the file list.
#
# Enter the list of source RTL files if reading from RTL
# Use:
#set RTL_SOURCE_FILES  "../../../../trv32p3_cnn_vhdl/trv32p3_cnn"
# Or:
set FILENAMES		"
trv32p3_cnn/data_types.vhd
trv32p3_cnn/controller/cntrl_types.vhd
trv32p3_cnn/controller/controller_ent.vhd
trv32p3_cnn/controller/controller_arch.vhd
trv32p3_cnn/controller/hazards_ent.vhd
trv32p3_cnn/controller/hazards_arch.vhd
trv32p3_cnn/controller/jtag_scan_register_ent.vhd
trv32p3_cnn/controller/jtag_scan_register_arch.vhd
trv32p3_cnn/controller/debug_controller_ent.vhd
trv32p3_cnn/controller/debug_controller_arch.vhd
trv32p3_cnn/controller/jtag_interface_ent.vhd
trv32p3_cnn/controller/jtag_interface_arch.vhd
trv32p3_cnn/controller/jtag_tap_controller_ent.vhd
trv32p3_cnn/controller/jtag_tap_controller_arch.vhd
trv32p3_cnn/controller/decoder_ent.vhd
trv32p3_cnn/controller/decoder_arch.vhd
trv32p3_cnn/mux/mux_pm_addr_ent.vhd
trv32p3_cnn/mux/mux_pm_addr_arch.vhd
trv32p3_cnn/mux/mux_pm_wr_ent.vhd
trv32p3_cnn/mux/mux_pm_wr_arch.vhd
trv32p3_cnn/mux/mux_dm_addr_ent.vhd
trv32p3_cnn/mux/mux_dm_addr_arch.vhd
trv32p3_cnn/mux/mux_dmb_wr_ent.vhd
trv32p3_cnn/mux/mux_dmb_wr_arch.vhd
trv32p3_cnn/mux/mux_x_w1_ent.vhd
trv32p3_cnn/mux/mux_x_w1_arch.vhd
trv32p3_cnn/mux/mux_x_w1_dead_ent.vhd
trv32p3_cnn/mux/mux_x_w1_dead_arch.vhd
trv32p3_cnn/mux/mux_ocd_data_w_ent.vhd
trv32p3_cnn/mux/mux_ocd_data_w_arch.vhd
trv32p3_cnn/mux/mux_ocd_instr_w_ent.vhd
trv32p3_cnn/mux/mux_ocd_instr_w_arch.vhd
trv32p3_cnn/mux/mux_aluA_ent.vhd
trv32p3_cnn/mux/mux_aluA_arch.vhd
trv32p3_cnn/mux/mux_aluB_ent.vhd
trv32p3_cnn/mux/mux_aluB_arch.vhd
trv32p3_cnn/mux/mux_pcaA_ent.vhd
trv32p3_cnn/mux/mux_pcaA_arch.vhd
trv32p3_cnn/mux/mux_pcaB_ent.vhd
trv32p3_cnn/mux/mux_pcaB_arch.vhd
trv32p3_cnn/mux/mux_jmp_tgt_ID_ent.vhd
trv32p3_cnn/mux/mux_jmp_tgt_ID_arch.vhd
trv32p3_cnn/mux/mux_aguB_ent.vhd
trv32p3_cnn/mux/mux_aguB_arch.vhd
trv32p3_cnn/mux/mux_mpyM_ent.vhd
trv32p3_cnn/mux/mux_mpyM_arch.vhd
trv32p3_cnn/mux/mux_ocd_swbreak_ent.vhd
trv32p3_cnn/mux/mux_ocd_swbreak_arch.vhd
trv32p3_cnn/mux/mux_pidTGT_w_ent.vhd
trv32p3_cnn/mux/mux_pidTGT_w_arch.vhd
trv32p3_cnn/mux/mux_X_x_w1_wad_ent.vhd
trv32p3_cnn/mux/mux_X_x_w1_wad_arch.vhd
trv32p3_cnn/pipe/pipe_pidTGT_ent.vhd
trv32p3_cnn/pipe/pipe_pidTGT_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_DMbEX_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_DMbEX_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_DMbS3_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_DMbS3_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_st_DMbEX_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_st_DMbEX_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_st_DMbS3_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_st_DMbS3_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_PMbEX_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_PMbEX_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_PMbS3_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_ld_PMbS3_arch.vhd
trv32p3_cnn/pipe/pipe_ocd_st_PMbEX_ent.vhd
trv32p3_cnn/pipe/pipe_ocd_st_PMbEX_arch.vhd
trv32p3_cnn/reg/reg_PC_ent.vhd
trv32p3_cnn/reg/reg_PC_arch.vhd
trv32p3_cnn/reg/reg_PC_ID_ent.vhd
trv32p3_cnn/reg/reg_PC_ID_arch.vhd
trv32p3_cnn/reg/reg_PC_EX_ent.vhd
trv32p3_cnn/reg/reg_PC_EX_arch.vhd
trv32p3_cnn/reg/reg_X_ent.vhd
trv32p3_cnn/reg/reg_X_arch.vhd
trv32p3_cnn/reg/reg_ocd_addr_ent.vhd
trv32p3_cnn/reg/reg_ocd_addr_arch.vhd
trv32p3_cnn/reg/reg_ocd_data_ent.vhd
trv32p3_cnn/reg/reg_ocd_data_arch.vhd
trv32p3_cnn/reg/reg_ocd_instr_ent.vhd
trv32p3_cnn/reg/reg_ocd_instr_arch.vhd
trv32p3_cnn/mem/dm_merge.vhd
trv32p3_cnn/mem/dm_wbb.vhd
trv32p3_cnn/mem/mem_PMb_ent.vhd
trv32p3_cnn/mem/mem_PMb_arch.vhd
trv32p3_cnn/mem/mem_DMb_ent.vhd
trv32p3_cnn/mem/mem_DMb_arch.vhd
trv32p3_cnn/prim/primitives.vhd
trv32p3_cnn/prim/alu_ent.vhd
trv32p3_cnn/prim/alu_arch.vhd
trv32p3_cnn/prim/pca_ent.vhd
trv32p3_cnn/prim/pca_arch.vhd
trv32p3_cnn/prim/cmp_ent.vhd
trv32p3_cnn/prim/cmp_arch.vhd
trv32p3_cnn/prim/div.vhd
trv32p3_cnn/prim/lx_ent.vhd
trv32p3_cnn/prim/lx_arch.vhd
trv32p3_cnn/prim/agu_ent.vhd
trv32p3_cnn/prim/agu_arch.vhd
trv32p3_cnn/prim/mpy_ent.vhd
trv32p3_cnn/prim/mpy_arch.vhd
trv32p3_cnn/prim/ocd_addr_incr_ent.vhd
trv32p3_cnn/prim/ocd_addr_incr_arch.vhd
trv32p3_cnn/prim/cnn_ent.vhd
trv32p3_cnn/prim/cnn_arch.vhd
trv32p3_cnn/trv32p3_cnn_ent.vhd
trv32p3_cnn/trv32p3_cnn_arch.vhd
trv32p3_cnn/trv32p3_cnn_config.vhd
"
set RTL_SOURCE_FILES        [lmap FILE $FILENAMES { file join $::env(RTL_SOURCE_DIR) ${FILE} } ]
######### CHANGED FOR ASIP SCRIPTS ############

# The following variables are used by scripts in the rm_dc_scripts folder to direct 
# the location of the output files.

set REPORTS_DIR "reports"
set RESULTS_DIR "results"

file mkdir ${REPORTS_DIR}
file mkdir ${RESULTS_DIR}

#set variable OPTIMIZATION_FLOW from following RM+ flows
#High Performance Low Power (hplp)
#High Connectivity (hc)
#Runtime Exploration (rtm_exp)

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Original:
# set OPTIMIZATION_FLOW  "" ;# Specify one flow out of hplp | hc | rtm_exp
# Changed to:
if {[info exists env(ASIP_OPTIMIZATION_FLOW)]} {
  puts "INFO: Using ASIP_OPTIMIZATION_FLOW $::env(ASIP_OPTIMIZATION_FLOW)"
  set OPTIMIZATION_FLOW  "$::env(ASIP_OPTIMIZATION_FLOW)"
} else {
  set OPTIMIZATION_FLOW  "" ;# Specify one flow out of hplp | hc | rtm_exp
}
######### END CHANGED FOR ASIP SCRIPTS ############


#################################################################################
# Search Path Setup
#
# Set up the search path to find the libraries and design files.
#################################################################################

  set_app_var search_path ". ${ADDITIONAL_SEARCH_PATH} $search_path"

#################################################################################
# Library Setup
#
# This section is designed to work with the settings from common_setup.tcl
# without any additional modification.
#################################################################################

  # Milkyway variable settings

  # Make sure to define the Milkyway library variable
  # mw_design_library, it is needed by write_milkyway command

  set mw_reference_library ${MW_REFERENCE_LIB_DIRS}
  set mw_design_library ${RESULTS_DIR}/${DCRM_MW_LIBRARY_NAME}

  set mw_site_name_mapping { {CORE unit} {Core unit} {core unit} }

# The remainder of the setup below should only be performed in Design Compiler or DC Explorer
if {$synopsys_program_name == "dc_shell" || $synopsys_program_name == "de_shell"}  {

  set_app_var target_library ${TARGET_LIBRARY_FILES}
  set_app_var synthetic_library dw_foundation.sldb


  set_app_var link_library "* $target_library $ADDITIONAL_LINK_LIB_FILES $synthetic_library"

  # Set min libraries if they exist
  foreach {max_library min_library} $MIN_LIBRARY_FILES {
    set_min_library $max_library -min_version $min_library
  }

  if {[shell_is_in_topographical_mode]} {

    # To activate the extended layer mode to support 4095 layers uncomment the extend_mw_layers command 
    # before creating the Milkyway library. The extended layer mode is permanent and cannot be reverted 
    # back to the 255 layer mode once activated.

    # extend_mw_layers

    # Only create new Milkyway design library if it doesn't already exist
    if {![file isdirectory $mw_design_library ]} {
      create_mw_lib   -technology $TECH_FILE \
                      -mw_reference_library $mw_reference_library \
                      $mw_design_library
    } else {
      # If Milkyway design library already exists, ensure that it is consistent with specified Milkyway reference libraries
      set_mw_lib_reference $mw_design_library -mw_reference_library $mw_reference_library
    }

    open_mw_lib     $mw_design_library

    check_library > ${REPORTS_DIR}/${DCRM_CHECK_LIBRARY_REPORT}

    set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE \
                       -min_tluplus $TLUPLUS_MIN_FILE \
                       -tech2itf_map $MAP_FILE

    check_tlu_plus_files
  }

  #################################################################################
  # Library Modifications
  #
  # Apply library modifications after the libraries are loaded.
  #################################################################################

  if {[file exists [which ${LIBRARY_DONT_USE_FILE}]]} {
    puts "RM-Info: Sourcing script file [which ${LIBRARY_DONT_USE_FILE}]\n"
    source -echo -verbose ${LIBRARY_DONT_USE_FILE}
  }
}

puts "RM-Info: Completed script [info script]\n"


