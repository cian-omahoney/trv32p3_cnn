##########################################################################################
## Functional Safety Setup
##########################################################################################
puts "RM-info: Running script [info script]\n"

# ----------------------------------------------------------
#
# SSF Load
#
# ----------------------------------------------------------

# ----------------------------------------------------------
# Load the SSF File
# ----------------------------------------------------------
suppress_message NDMUI-820
load_ssf $FUSA_SSF_FILE

# ----------------------------------------------------------
# Load physical -updates for  SSF File
# ----------------------------------------------------------
if { $FUSA_SSF_UPDATE_FILE != "" } {
  puts "RM-info: Loading SSF Physical Update file"
  load_ssf $FUSA_SSF_UPDATE_FILE
}

# ----------------------------------------------------------
# Load the Auxilliary SSF from TestMAX FuSa
# ----------------------------------------------------------
if { $FUSA_SSF_AUX_FILE != "" } {
  puts "RM-info: Loading Auxiliary SSF file"
  load_ssf $FUSA_SSF_AUX_FILE
}

## Turning on Advanced Legalizer
if {![get_app_option -name place.legalize.enable_advanced_legalizer]} {
  puts "RM-info: Turning on Advanced Legalizer for FuSa"
  set_app_options -name place.legalize.enable_advanced_legalizer -value true
}


# ----------------------------------------------------------
#
# Safety Register Setup
#
# ----------------------------------------------------------
# ----------------------------------------------------------
# Required app options for Safety Registers and DCLS
# ----------------------------------------------------------
if {[sizeof_collection [get_safety_register_rules -quiet]]} {
  puts "RM-info: Enable split pin marking during tree spltting, will be set default true in later release"
  set_app_options -name report.safety.enable_split_pin_marking -value true

  # ensure TAP cells are placed abutted either side of safety registers, default is false
  set_app_options -name place.legalize.enable_safety_register_groups_dual_taps -value true
}


# ----------------------------------------------------------
#
# DCLS Setup
#
# ----------------------------------------------------------
if {[sizeof_collection [get_safety_core_groups -quiet]]} {

  puts "RM-info: Safety Cores are defined"
  set cores [get_attribute -objects [get_safety_core_groups] -name safety_cores]

  # ----------------------------------------------------------
  # Required placement app options for DCLS FuSa flow
  # ----------------------------------------------------------
  # Improve DCLS core placement separation
  set_app_options -name place.coarse.grp_rep_gbs_use_slow_snaps -value true
  set_app_options -name place.coarse.grp_rep_gbs_start_stronger -value true
  # fix issue where cells of cores were being placed over macros
  set_app_options -name place.coarse.grp_rep_gbs_aware_blockage_shove  -value true
  # new auto bounds feature
  set_app_options -name place.coarse.grp_rep_gbs_add_move_bounds -value true

  # ----------------------------------------------------------
  # Stop DFT port punching through cores
  # ----------------------------------------------------------
  # create separate partion for Safety Cores
  if {$ENABLE_DCLS_SCAN_PROTECTION} {
    puts "RM-info: Enabling DCLS Scan Protection"
    set cores [get_attribute -objects [get_safety_core_groups] -name safety_cores]
    set i 0
    foreach_in_collection core $cores {
      set coreName [get_object_name $core]
      puts "Defining DFT Partition for Safety Core $coreName"
      define_dft_partition partition_${i} -include $coreName
      incr i
    }
  }

  # ----------------------------------------------------------
  # Split the DCLS clock nets
  #   also performs freeze ports on core clocks
  # ----------------------------------------------------------
  if {$ENABLE_DCLS_CLOCK_SPLIT} {
    puts "RM-info: Performing DCLS clock Splitting"
    set splitPins [get_attribute -objects [get_safety_core_groups] -name split_pins]
    insert_redundant_trees \
    -safety_core_groups [get_safety_core_groups] \
    -buffer_lib_cell  $DCLS_CLOCK_SPLIT_BUF \
    -pins $splitPins
  }

  # ----------------------------------------------------------
  # Boundary Protection
  #   Ensure all buffers on core I/O ports are placed inside logical hierarchy for cores
  #   No Transit cells
  # ----------------------------------------------------------
  if {$ENABLE_DCLS_BOUNDARY_PROTECTION} {
    #puts "RM-info: Insert Fanout Threshold Buffers"
    #source insert_dcls_buffers.tcl
    #insert_dcls_buffers -buffer  $DCLS_BOUNDARY_PROTECTION_BUF -max_combinational_fanout 10

    puts "RM-info: Enabling DCLS Boundary Protection"
    insert_safety_core_boundary_protection -safety_core_groups [get_safety_core_groups]
  }
  redirect -file ${REPORTS_DIR}/safety_core_groups.rpt {report_safety_core_groups}
}


# # ----------------------------------------------------------
# #
# # FFSM Setup
# #
# # ----------------------------------------------------------
# if $enableFFSM {
#   # stop the state registers from being optimized away
#   set_size_only <...>/state*
#   set_size_only <...>/state*

#   puts "RM-info: Failsafe FSM's are defined"
#   report_fsm -all -verbose > ${REPORTS_DIR}/report_fsm_pre.rpt
# }


# ----------------------------------------------------------
#
# FuSa Flow Sign In Check
#
# ----------------------------------------------------------
# Temporary to turn of TAP cell errors
set_app_options -name report.safety.enable_taps_db_for_sr -value true




redirect -tee -file ${REPORTS_DIR}/${DESIGN_NAME}.report_safety_status.check_setup {report_safety_status -check_setup}

puts "RM-info: Completed script [info script]\n"

