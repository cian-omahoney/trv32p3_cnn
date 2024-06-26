
// File generated by noodle version U-2022.12#33f3808fcb#221128, Wed Apr 10 19:59:36 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

// File: register_spilling.cpp
// Test spilling of registers to stack
// (Each function is required to save and restore one specific register(file) around the call of `foo'.
//  Note that the connection may be direct or indirect, atomic or complex.
//  If a value is moved through some other register, that need not be spilled itself, as it may be clobbered.)

//! Connection analysis may reveal that certain registers are not spillable, and those tests are elided by default.
//! Note that the connection may be direct or indirect (via another register).
//! Define `plus_unconnected' to test all elided tests too, which may require more entries to be added to the ``oneliners.skip'' file.

// (It is possible that certain component-registers are not (individually) spillable, yet that the structure is.
//  These are then not a problem for, e.g., a full context switch.)

extern "C" {

void foo() property(loop_free);


void spill_X() chess_clobbers_not(X) { foo(); }


} //extern "C"  (1 functions)
