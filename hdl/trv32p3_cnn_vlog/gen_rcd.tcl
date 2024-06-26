
# File generated by Go version U-2022.12#33f3808fcb#221128, Wed Apr 10 20:00:35 2024
# Copyright 2014-2022 Synopsys, Inc. All rights reserved.
# go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



set hdlprx trv32p3_cnn_vlog
# read hdlprx from HDLPRX env variable, if exists
catch { set hdlprx $env(HDLPRX) }

set appdir "."
# read appdir from APPDIR env variable, if exists
catch { set appdir $env(APPDIR) }

set appname "data"
# read appname from APP env variable, if exists
catch { set appname $env(APP) }
puts "** Info: Using hdlprx='$hdlprx', appdir='$appdir', appname='$appname'"

# generate appname.cfg
set f_appname [open "appname.cfg" w]
puts $f_appname "$appdir/$appname"
close $f_appname
# generate rcdname.cfg
set f_rcdname [open "rcdname.cfg" w]
puts $f_rcdname "$appdir/$appname.$hdlprx.rcd"
close $f_rcdname
# delete potential existing rcd file
file delete "$appdir/$appname.$hdlprx.rcd"

# now read the cycle count
set num_cycles 0
catch { set num_cycles $env(NUM_CYCLES) }
if {$num_cycles != 0} {
    puts "** Info: cycle_count set from environment to $num_cycles"
} else {
    if {![file exists "$appdir/$appname.cycle_count"]} {
        puts "** Error: File '$appdir/$appname.cycle_count' not found!"
        finish
    }
    puts "** Info: Reading cycle_count from file '$appdir/$appname.cycle_count'"
    set f_cycle_count [open "$appdir/$appname.cycle_count" r]
    gets $f_cycle_count line
    close $f_cycle_count
    set num_cycles [expr $line]
}
if {$num_cycles > 2147483647} {
    puts "** Error: Number of cycles exceeds integer range!"
    finish
}

# set stop conditions
force /test_bench/inst_trv32p3_cnn/inst_reg_PC/max_cycles $num_cycles

# and run:
puts "** Info: Simulating $num_cycles cycles."
run
# run one additional ps to log changes of other regs:
run 1 ps

# cleanup
file delete "appname.cfg"
file delete "rcdname.cfg"

finish
