
# File generated by Go version U-2022.12#33f3808fcb#221128, Wed Apr 10 20:00:35 2024
# Copyright 2014-2022 Synopsys, Inc. All rights reserved.
# go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



set appdir "."
# read appdir from APPDIR env variable, if exists
catch { set appdir $env(APPDIR) }

set appname "data"
# read appname from APP env variable, if exists
catch { set appname $env(APP) }
puts "** Info: Using appdir='$appdir', appname='$appname'"

# generate appname.cfg
set f_appname [open "appname.cfg" w]
puts $f_appname "$appdir/$appname"
close $f_appname

proc power_toggle {} {
    if {$::on_off} {
        power -enable
        set ::on_off 0
    } else {
        if {!$::power_toggle_first} {
            power -disable
        }
        set ::on_off 1
    }
    set ::power_toggle_first 0
}

#on_off - toggles recording status, 0:off 1:on
set on_off 1
set cycles_run 0
set power_toggle_first 1

# configure activity recording
power -gate_level rtl_on mda
power  test_bench.inst_trv32p3_cnn

# now get recording intervals, if any
set interval_endpoints_list {}
set pi_fname "$appdir/$appname.profile_intervals"
set cc_fname "$appdir/$appname.cycle_count"

if {[file exists $pi_fname] && [file size $pi_fname] > 0} {
    puts "** Info: Reading interval endpoints from '$pi_fname'"
    set f_pi [open $pi_fname r]
    while {[gets $f_pi line] >= 0} {
        lappend interval_endpoints_list $line
    }
    close $f_pi
} elseif { [file exists $cc_fname] && [file size $cc_fname] > 0} {
    puts "** Info: Reading cycle count from file '$cc_fname'"
    set f_cc [open "$cc_fname" r]
    gets $f_cc line
    close $f_cc
    lappend interval_endpoints_list $line
} else {
    puts "** Error: File '$pi_fname', nor $cc_fname was found!"
    finish
}

set on_off [expr {[llength $interval_endpoints_list] == 1}]

foreach i_endpoint $interval_endpoints_list {

    if {$i_endpoint > 2147483647} {
        puts "** Error: cycle value $i_endpoint exceeds integer range!"
        finish
    }
    if {$i_endpoint < $cycles_run} {
        puts "** Error: invalid sequence of cycle value, $i_endpoint < $cycles_run"
        finish
    }
    power_toggle
    if {$i_endpoint > 0} {
        # set stop condition to next endpoint and run until there (max. 1000s):
        force /test_bench/inst_trv32p3_cnn/inst_reg_PC/max_cycles $i_endpoint
        run 1000000000000 ns
        # get number of run cycles:
        set cycles_run [get /test_bench/inst_trv32p3_cnn/inst_reg_PC/cycles]
        puts "** Info: Ran to cycle: $cycles_run with recording status: [expr {$on_off ? "disabled" : "enabled"}]"
    }
}

# disable recording if last iteration was on
if {!$on_off} {
    power -disable
}

# create SAIF file
power -report trv32p3_cnn.saif 1e-12 inst_trv32p3_cnn

# cleanup
file delete "appname.cfg"

finish
