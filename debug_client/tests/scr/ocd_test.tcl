#
# Copyright (c) 2021-2022 Synopsys, Inc. This Synopsys processor model
# captures an ASIP Designer Design Technique. The model and all associated
# documentation are proprietary to Synopsys, Inc. and may only be used
# pursuant to the terms and conditions of a written license agreement with
# Synopsys, Inc.  All other use, reproduction, modification, or distribution
# of the Synopsys processor model or the associated  documentation is
# strictly prohibited.
#
# Tcl procedures used in tests for on chip debugging.
#

set processor [lindex [::iss::processors] 0]

set prjdir [file join [file dirname [info script]] .. .. ..]
set bindir [file join $prjdir bin]

source [file join $bindir ocd jts.tcl]
source [file join $bindir utils.tcl]
namespace import utils::log utils::touch_file utils::envget? utils::read_port_file


# defaults
set sim_mode vcs ; # vcs ext iss
set hdlprx ${processor}_vlog.prx

# parse script args
if {[llength $::iss::tcl_script_args] > 0} {
  log "tcl script args: $::iss::tcl_script_args"

  # positional arguments
  set vargs {
  }
  # arg or {arg set}

  # options
  set vopts {
    { -mode   v sim_mode }
    { -hdl    v hdlprx }
    { -server v server }
    { -port   v port }
  }
  # {-pat* b/v/l var [var_set]} b: boolean, v: variable, l: list

  if {[catch {::tclutils::parse_args $vargs $vopts $::iss::tcl_script_args [info script]} msg]} {
    log "ERROR: $msg"
    exit 1
  }

  if {$sim_mode ni "vcs ext iss"} {
    log "ERROR: unknown sim mode '$sim_mode'"
    exit 1
  }

  if {$sim_mode ne "ext" && ([info exists server] || [info exists port])} {
    log "WARNING: specifying server and port works only for 'ext' mode"
  }
}

set program $::iss::cmdln_program_name

log "mode: $sim_mode"
log "program: $program"

if {$sim_mode eq "vcs"} {

  set hdlprx_arg $hdlprx
  if {[file extension $hdlprx] ne ".prx"} {
    append hdlprx .prx
  }
  set hdldir [file join [file dirname [info script]] .. .. .. hdl]
  set candidates "
      $hdlprx
      [file join $hdldir $hdlprx]
      [file join $hdldir ${processor}_$hdlprx]
  "
  set ok 0
  foreach hdlprx $candidates {
    if {[file isfile $hdlprx]} {
      set ok 1
      break
    }
  }
  if {!$ok} {
    log "ERROR: invalid HDL project '$hdlprx_arg' specified, tried\n\t[join $candidates \n\t]"
    exit 1
  }
  log "INFO: Using HDL project '$hdlprx'"

  source [file join $bindir ocd async.tcl]

} elseif {$sim_mode eq "ext"} {

  if {[info exists port]} {
    if {$port == 0} {
      jts::setup
    } else {
      log "INFO: Set JTS port to $port"
      iss::iss_debug_client_set pdc_port $port
    }
  }

  if {[info exists server]} {
    log "INFO: Set JTS server to $server"
    iss::iss_debug_client_set pdc_server $server
  }
}

if {$sim_mode in "vcs ext"} {
  source [file join [file dirname [info script]] .. .. .. bin ocd vcs rpc.tcl]
} else {
  namespace eval ::rpc {
    proc connect args {}
  }
}

# ------------------------------------------------------------------------------

namespace eval testing {
  namespace export run_tests iss err load_program put_r put_a expect_r expect_a \
    expect_m expect_pc _iss init_X find_symbol find_all_syms get_pc \
    get_all_delay_slots find_all_symadr setup_VCS_bp setup_dump dump testlog

  variable error_count 0
  variable first 1

  variable fwords
  variable syms

  variable bkpt_stage
#  variable stages

  variable lf {}

  proc testlog line {
    variable lf
    puts $lf "### $line"
    log "### $line"
    flush $lf
  }

  proc run_tests body {
    initialize
    try {
      uplevel 1 $body
    } trap {} {msg opts} {
      err "Script execution failed: $msg"
      log [dict get $opts -errorinfo]
    } finally {
      finalize
    }
  }

  proc err msg {
    variable lf
    puts $lf "ERROR: $msg"
    puts stderr "ERROR: $msg"
    flush $lf
    variable error_count
    incr error_count
  }

  proc initialize {} {
    log "Setup timeout handler"

    # give up after 5 minutes
    after 300000 {
      log "Timeout: giving up after 5 minutes."
      _finish
      exit 1
    }

    if {$::sim_mode eq "vcs"} {
      clear_VCS_bkpt

      log "Launching HDL simulation in background"
      set args [list $::hdlprx]
      if {[info exists ::ocd_vcs_script]} {
        lappend args /dev/null $::ocd_vcs_script
      }
      vcs::start-async {*}$args
    }

    try {
      ::iss::create $::processor _iss
    } trap {} {msg opts} {
      log "ERROR: Could not create processor instance: $msg"
      _finish
      exit 1
    }

    log "In debug client: [_iss info is_debug_client], sim mode is $::sim_mode"

    # disable 'Cycle count, ... elapsed' messags after every ISS step
    set ::iss::print_messages 0
    set ::iss::time_simulation 0

    set d [_iss info issoptions]
    set d [tclutils::list2dict $::iss::iss_option_keys $d]
    variable bkpt_stage [dict get $d breakpoint_stage]
#    variable stages [dict get $d pipeline_stage_name_list]

    variable lf
    set lf [open test.log w]
  }
  proc finalize {} {
    variable error_count
    report_errors
    _finish
    clear_VCS_bkpt
    exit [expr {$error_count > 0 ? 1 : 0}]
  }

  proc _finish {} {
    if {$::sim_mode eq "vcs"} {
      vcs::stop
      jts::cleanup
    }
    variable lf
    if {$lf ne ""} {
      close $lf
    }
  }

  proc iss args {
    testlog [join [list iss {*}$args]]
    if {[catch {set val [_iss {*}$args]} msg]} {
      err $msg
      finalize
    }
    if {$::sim_mode eq "iss"} {
      lassign $args method
      if {$method eq "step"} {
        # mimicking HW based stepping
        variable bkpt_stage
        while 1 {
          set d [lindex [_iss info pipeline] $bkpt_stage]
          set d [tclutils::list2dict $::iss::instruction_info_keys $d]
          # would the db client stop here?
          # delay_slots -> not stopping
          # ZOL end-of-loop -> not stopping
          # cycles(3|1) not-taken branch -> would stop
          if {[dict get $d is_delay_slot] || ([dict get $d hw_breakpoint_forbidden] && [dict get $d sw_breakpoint_forbidden])} {
            if {[catch {set val [_iss step 1]} msg]} {
              err $msg
              finalize
            }
            continue
          }
          # step over bubbles in breakpoint stage
          lassign [_iss info pchistory] - pipe_valid - pipe_removed
          if {![lindex $pipe_valid $bkpt_stage] || [lindex $pipe_removed $bkpt_stage]} {
            if {[catch {set val [_iss step 1]} msg]} {
              err $msg
              finalize
            }
            continue
          }
          break
        }
      }
    }
    return $val
  }

  proc get_pc {} {
    if {$::sim_mode eq "iss"} {
      # retrieve PC of breakpoint focus stage
      return [iss program query pc -virtual]
    } else {
      return [iss program query pc]
    }
  }

  proc put_r {storage value {radix hex}} {
    testlog "put_r: $storage: $value, $radix"
    iss put -radix $radix $value $storage
  }

  proc put_a {storage address value {radix hex}} {
    testlog "put_a: $storage\[$address\]: $value, $radix"
    iss put -radix $radix $value $storage $address
  }

  # Test if the specified storage contains the expected value.
  proc expect_r {storage expected {radix hex} {format string}} {
    set val [iss get $storage -radix $radix -format $format]
    if { $val == $expected } {
      testlog "expect_r: same, ${storage}: $val, expected $expected"
    } else {
      testlog "expect_r: diff, ${storage}: $val, expected $expected  !!!"
      variable error_count
      incr error_count
    }
  }

  # Test if the specified storage location contains the expected value at
  # the specified address.
  proc expect_a {storage address expected {radix hex} {format string}} {
    set val [iss get $storage $address -radix $radix -format $format]
    if { $val == $expected } {
      testlog "expect_a: same, $storage\[$address\]: $val, expected $expected"
    } else {
      testlog "expect_a: diff, $storage\[$address\]: $val, expected $expected  !!!"
      variable error_count
      incr error_count
    }
  }

  # Test if the program counter contains the expected value.
  proc expect_pc {expected} {
    set val [get_pc]
    if { $val == $expected } {
      testlog "expect_pc: same, pc:$val, expected $expected"
    } else {
      testlog "expect_pc: diff, pc:$val, expected $expected  !!!"
      variable error_count
      incr error_count
    }
  }

  # Test if the memory range contains the expected values.
  proc expect_m { mem values } {
    foreach { v } $values {
      set a [lindex $v 0]
      set v [lindex $v 1]
      expect_a $mem $a $v dec
    }
  }

  proc report_errors {} {
    testlog ""
    variable error_count
    if { $error_count != 0 } {
      testlog "FAILED ($error_count errors) ************"
    } else {
      testlog "PASSED"
    }
    testlog ""
  }

  proc load_program {} {
    variable first
    testlog "Load program"
    iss reset
    iss program load $::program -dwarf -disassemble
    if {$first == 1} {
      set first 0
      variable fwords [_iss program query first_words]
      variable syms [elf_symbols]
      check_syms $syms
    }
    if {$::sim_mode eq "iss"} {
      # mimic db client behavior - run until first instruction is in breakpoint
      # focus stage
      iss src_step step 1
    }
  }

  # use only after instruction is decoded (simulated at least once)
  proc instr_at {pc args} {
    tclutils::list2dict $::iss::instruction_info_keys [lindex [_iss info instruction $pc {*}$args] 0]
  }

  proc elf_symbols args {
    lmap sym [_iss info elf32_symbols {*}$args] {
      tclutils::list2dict $::iss::elf32_symbol_keys $sym
    }
  }

  proc check_syms syms {
    testlog "Checking [llength $syms] symbols for alignment requirements"
    foreach sym $syms {
      set lbl [dict get $sym name]
      if {[regexp {chk_(\d+)m(\d+)} $sym -> off mod]} {
        set adr [dict get $sym value]
        testlog "Check $lbl at $adr for ($adr % $mod) == $off"
        if {![expr {($adr % $mod) == $off}]} {
          err "ERROR: Alignment of symbol $lbl mismatches expectations"
        }
      }
    }
  }

  proc clear_VCS_bkpt {} {
  }

  proc setup_VCS_bp {addr} {

    ::rpc::exec eval [string map [list \
      %COND% "{inst_$::processor/inst_reg_PC/pcr_out = $addr}" ] \
    {
      scope $::initial_scope
      stop -once -posedge clock -condition %COND% \
           -command {
              puts "Trigger external debug request"
              scope $::initial_scope
              force dbg_ext_break 1
             quit
              stop -once -posedge clock -command {
                puts "Remove ext"
                scope $::initial_scope
                force dbg_ext_break 0
              } -continue
           } \
           -continue
    }]
  }

  proc init_X {{val 0}} {
    for {set i 1} {$i < 32} {incr i} {
      put_r x$i $val
    }
  }

  proc find_symbol lbl {
    variable syms
    foreach sym $syms {
      set name [dict get $sym name]
      if {$name eq $lbl} {
        set adr [dict get $sym value]
        break
      }
    }
    if {![info exist adr]} {
      err "Could not find '$lbl'"
      error "Test aborted"
    }
    variable fwords
    return [list $adr [lsearch $fwords $adr]]
  }

  proc find_all_syms pat {
    variable syms
    lmap sym $syms {expr {
      [string match $pat [dict get $sym name]] ? \
        [list [dict get $sym name] [dict get $sym value]] : [continue]
    }}
  }

  proc find_all_symadr pat {
    variable syms
    lmap sym $syms {expr {
      [string match $pat [dict get $sym name]] ? [dict get $sym value] : [continue]
    }}
  }

  proc get_all_delay_slots {} {
    variable fwords
    set ds {}
    foreach adr $fwords {
      set d [tclutils::list2dict $::iss::instruction_info_keys [lindex [_iss info instruction $adr] 0]]
      if {[dict get $d is_delay_slot] == 1} {
        lappend ds $adr
      }
    }
    return $ds
  }

  variable dmp
  proc setup_dump {} {
    variable dmp
    regexp {\D*(\d+)} [lindex [find_all_syms c_reg_min_x*] 0 0] -> r_min
    regexp {\D*(\d+)} [lindex [find_all_syms c_reg_max_x*] 0 0] -> r_max
    testlog "Test changes x$r_min .. x$r_max subranges"

    if {$::sim_mode eq "iss"} {
      set fnm "reg.iss.dmp"
    } else {
      set fnm "reg.ocd.dmp"
    }
    testlog "Dumping register state to $fnm"
    set dmp [_iss fileoutput_range add X $r_min $r_max -file $fnm -format unsigned]
  }

  proc dump {} {
    variable dmp
    _iss fileoutput_range print_header $dmp
    _iss fileoutput_range print $dmp
  }

}
