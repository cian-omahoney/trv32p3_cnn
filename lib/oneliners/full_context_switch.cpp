
// File generated by noodle version U-2022.12#33f3808fcb#221128, Fri Mar 22 18:45:38 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

// File: full_context_switch.cpp
// Test full context switch  (requires spilling)
// (Unlike other tests, these functions may generate quite a lot of code.
//  More specific tests can be found in file  register_spilling.c .
//  In particular, check for relevant registers reported to be not spillable.)

extern "C" {

void foo() property(loop_free);


void test_save_restore_all_clobbered_registers() chess_clobbers()
{
    // must save all caller-saved registers
    foo();
    // must restore all caller-saved registers
}


} //extern "C"  (1 functions)
