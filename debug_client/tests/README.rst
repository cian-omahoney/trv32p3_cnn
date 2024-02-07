
These tests support 3 simulation modes

 * vcs - the test launches a VCS simulation in the background, then uses the
   debug client to connect to it via Jtalk

 * ext - the test connects to an HDL simulation or prototype hardware via
   Jtalk, using the debug client

 * iss - the test executes in an ISS

VCS is started with the script <project-dir>/bin/ocd/vcs//ocd-stop.vcs.tcl.
The script optionally dumps all signals to a waveform file (inter.fsdb) if you
set the environment variable OCD_VCS_TRACE=1.

You can look at waveforms with Verdi after the simulation finished:

    verdi -dbdir <prjdir>/hdl/trv32p3_cnn_vlog/simv.daidir -ssf inter.fsdb

These projects have 3 run-debug configurations

 * vcs (default)
 * iss
 * ext


Build

    chessmk test


Run

    chessmk test -S


Run on ISS

    chessmk test -S +C iss


Run on external (simulated/emulated/real) hardware

    chessmk test -S +C ext

