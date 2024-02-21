
# File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:40 2024
# Copyright 2014-2022 Synopsys, Inc. All rights reserved.
# go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



set hdlprx trv32p3_cnn_vhdl
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

# now get exit addresses
set exit_addr_list {}
set exitfname "$appdir/$appname.exit"
if {![file exists $exitfname]} {
    puts "** Error: File '$exitfname' not found!"
    finish
}
puts "** Info: Reading exit address(es) from '$exitfname'"
set f_exit [open $exitfname r]
while {[gets $f_exit line] >= 0} {
    lappend exit_addr_list $line
}
close $f_exit
if {[llength $exit_addr_list] == 0} {
    puts "** Error: No exit address in file '$exitfname'!"
    finish
}

# set stop conditions
foreach exit_addr $exit_addr_list {
    set i_exit_addr [expr $exit_addr]
    stop -condition " /test_bench/inst_trv32p3_cnn/inst_reg_PC/pcr_out = $i_exit_addr"
    puts "** Info: Breakpoint set at: $i_exit_addr"
}

# and run (max. 1000s):
run 1000000000000 ns
# run to falling edge of clk:
stop -condition { /test_bench/inst_clock_gen/clock_out = '0'}
run 1000 ns
# run one additional ps to log changes of other regs:
run 1 ps

# get final cycle_count:
set cycles_run [get -radix decimal /test_bench/inst_trv32p3_cnn/inst_reg_PC/cycles]
puts "** Info: Run $cycles_run cycles."
# and dump to rtlsim.cycle_count file:
set f_count [open "rtlsim.cycle_count" w]
puts $f_count $cycles_run
close $f_count

# cleanup
file delete "appname.cfg"
file delete "rcdname.cfg"

finish
