#
# Copyright (c) 2021-2022 Synopsys, Inc. This Synopsys processor model
# captures an ASIP Designer Design Technique. The model and all associated
# documentation are proprietary to Synopsys, Inc. and may only be used
# pursuant to the terms and conditions of a written license agreement with
# Synopsys, Inc.  All other use, reproduction, modification, or distribution
# of the Synopsys processor model or the associated  documentation is
# strictly prohibited.
#

if {[info exists ::env(OCD_VCS_TRACE)] && $::env(OCD_VCS_TRACE) == 1} {
  puts {[INFO] Dumping all signals to inter.fsb}
  puts {[INFO] To look at debug traces after the simulation:}
  puts {[INFO] verdi -dbdir <path>/hdl/trv32p3_cnn_vlog/simv.daidir -ssf inter.fsdb}

  dump -add / -depth 0
}

onbreak {
  puts {[INFO] Encountered stop-point, $stop task or CTRL-C, stopping VCS ...}
  quit
}

onerror {
  puts "ERROR: stopping ..."
  quit
}

onfail {
  puts "ERROR: stopping ..."
  quit
}

set setup_done false

set scope [scope]

while 1 {
  run 10us
  if {[file exists ./.OCD_VCS_stop]} {
    quit
    break
  }
  if {$setup_done == false && [file exists ./.OCD_VCS_extdbgreq]} {
    set setup_done true

    set cndfile [open .OCD_VCS_extdbgcnd]
    set cnd [string trim [read $cndfile]]
    close $cndfile

    puts "Condition: '$cnd'"

    scope $scope
    stop -once -posedge clock -condition $cnd \
         -command {
            puts "Trigger external debug request"
            scope $::scope
            force dbg_ext_break 1
            stop -once -posedge clock -command {
              scope $::scope
              force dbg_ext_break 0
            } -continue
         } \
         -continue
    close [open .OCD_VCS_setupdone w]

    puts "Setup VCS bp: $cnd"
  }
  if {$setup_done == true && ![file exists ./.OCD_VCS_extdbgreq]} {
    set setup_done false
    file delete -force .OCD_VCS_setupdone
  }
}

quit
