#!/usr/bin/env tct_tclsh
#
# Copyright (c) 2021 Synopsys, Inc. This Synopsys processor model
# captures an ASIP Designer Design Technique. The model and all associated
# documentation are proprietary to Synopsys, Inc. and may only be used
# pursuant to the terms and conditions of a written license agreement with
# Synopsys, Inc.  All other use, reproduction, modification, or distribution
# of the Synopsys processor model or the associated  documentation is
# strictly prohibited.
#

proc usage {} {
  puts "

On-Chip Debugging Tests
=======================

Optional Arguments:

  --port                JTS Server port; enables 'ext' mode
  --server              JTS Server name; enables 'ext' mode
  --mode                Test mode (vcs, ext)
  --hdl                 HDL project
  --help                This help
  --                    Stop parsing optional arguments

Abbreviated Forms:

  -h                    for --help

Positional Arguments:

  path*                 Select tests (default: all tests)
                        This can be a path (relative/absolute) to a prx file
                        or to a directory that contains a test.prx file.

  Examples:

    ./runtests.tcl 01_dmb

  or

    ./runtests.tcl 01_dmb/test.prx


  If no arguments are specified:

  - If there is a test.prx in the current working directory, the script executes
    that test.

      cd mytest/
      ../runtests.tcl

  - Otherwise, the script executes all tests that it finds relative to its own
    location.


"
}

source [file join [file dirname [info script]] .. .. bin utils.tcl]
namespace import utils::log utils::chessmk utils::log_exec-rc utils::envget? \
        utils::read_port_file

# Defaults
set tests [list]
set db_mode vcs ; # vcs ext

# parse script args
if {[llength $::argv] > 0} {

  proc guess_test {arg} {
    set prx $arg
    if {[file isdir $prx]} {
      set prx [file join $prx test.prx]
    }
    if {[file extension $prx] ne ".prx"} {
      append prx .prx
    }
    if {[file exists $prx] && [file isfile $prx]} {
      upvar tests tests
      lappend tests $prx
    } else {
      log "ERROR: Unknown argument '$arg', expected path to prx file or directory containing a test.prx file"
      exit 1
    }
  }

  for {set i 0} {$i < [llength $::argv]} {incr i} {
    switch -glob -- [lindex $::argv $i] {
      --port {
        set jts_port [lindex $::argv [incr i]]
        set db_mode ext
      }
      --server  {
        set jts_server [lindex $::argv [incr i]]
        set db_mode ext
      }
      --mode {
        set db_mode [lindex $::argv [incr i]]
      }
      --hdl {
        set hdl [lindex $::argv [incr i]]
      }
      --help -
      -h {
        usage
        exit
      }
      -- {
        incr i
        break
      }
      -* {
        log "ERROR: Unknown option [lindex $::argv $i]"
        exit 1
      }
      default {
        guess_test [lindex $::argv $i]
      }
    }
  }
  # process tail after --
  if {$i < [llength $::argv]} {
    for {} {$i < [llength $::argv]} {incr i} {
      guess_test [lindex $::argv $i]
    }
  }
}

if {$db_mode ni "vcs ext"} {
  log "ERROR: unknown mode '$db_mode'"
  exit 1
}

if {$db_mode eq "ext"} {
  if {[info exists jts_port] && $jts_port == 0} {
    set jts_port_number_file [envget? JTS_PORT_NUMBER_FILE ./JTS_PORT_NUMBER]
    set trials 0
    while {![file exists $jts_port_number_file] || [file size $jts_port_number_file] == 0} {
      if {$trials >= 10} {
        log "ERROR: could not read $jts_port_number_file, gave up after $trials seconds ..."
        exit 1
      }
      after 1000
      incr trials
    }
    set jts_port [read_port_file $jts_port_number_file]
  }
}

# no tests specified ...
if {[llength $tests] == 0} {
  if {[file exists test.prx]} {
    # ... fall back to test in working dir
    set tests test.prx
  } else {
    # ... else run all tests relative to this script
    set scrdir [file dirname [info script]]
    set tests [glob [file join $scrdir * test.prx]]
  }
}

# Run test
#  -> Self-checking test, or compare.tcl based?
proc run_test test_prx {
  set dir [file dirname $test_prx]
  set ref [file join $dir reg.ref.dmp]
  if {[file exists $ref]} {
    run_cmp_test $test_prx
  } else {
    run_selfchk_test $test_prx
  }
}
# Run self-checking test
proc run_selfchk_test test_prx {
  build $test_prx
  run_ocd $test_prx
  return 1
}

# Run compare.tcl based test
proc run_cmp_test test_prx {
  build $test_prx
  run_ocd $test_prx
  run_iss $test_prx
  do_compare $test_prx
  return 1
}

# do compare
proc do_compare prx {
  set dir [file dirname $prx]
  set ref [file join $dir reg.ref.dmp]
  set iss [file join $dir reg.iss.dmp]
  set ocd [file join $dir reg.ocd.dmp]
  set dif [file rootname $prx].diff
  if {[compare -ref $ref -iss $iss -ocd $ocd >& $dif]} {
    log "ERROR: compare failed"
    return -level 2 0
  }
  return 1
}

# run test using debug client
proc run_ocd prx {
  set dir [file dirname $prx]
  set scr [list test.tcl -mode $::db_mode]
  if {[info exists ::jts_server]} {
    lappend scr -server $::jts_server
  }
  if {[info exists ::jts_port]} {
    lappend scr -port $::jts_port
  }
  if {[info exists ::hdl]} {
    lappend scr -hdl $::hdl
  }
  set log_ocd [file join $dir ocd.log]
  if {[chessmk $prx -sim-script $scr -S >& $log_ocd]} {
    log "ERROR: OCD simulation failed"
    return -level 2 0
  }
  return 1
}

# build test
proc build prx {
  set dir [file dirname $prx]
  set log_bld [file join $dir build.log]
  if {[chessmk $prx >& $log_bld]} {
    log "ERROR: building $prx failed"
    return -level 2 0
  }
}

# run test on iss
proc run_iss prx {
  set dir [file dirname $prx]
  set log_iss [file join $dir iss.log]
  if {[chessmk $prx +C iss -S >& $log_iss]} {
    log "ERROR: ISS simulation failed"
    return -level 2 0
  }
}

# Wrapper for compare.tcl
proc compare args {
  set scr [file join [file dirname [info script]] scr compare.tcl]
  log_exec-rc $scr {*}$args
}

proc readable_test_name prx {
  set dir [file dirname $prx]
  if {$dir eq "."} {
    set dir [pwd]
  }
  return [file tail $dir]
}

proc main tests {
  set err 0

  foreach test_prx $tests {
    if {[run_test $test_prx]} {
      log "PASSED: [readable_test_name $test_prx]"
    } else {
      log "FAILED: [readable_test_name $test_prx]"
      incr err
    }
  }

  log "------------------------------------------------------"
  log "   --- Total number of tests: [llength $tests]"
  log "   --- Failures: $err"
  if {$err > 0} {
    log "   --- Status: FAILED"
    exit 1
  } else {
    log "   --- Status: PASSED"
  }
}

main $tests
