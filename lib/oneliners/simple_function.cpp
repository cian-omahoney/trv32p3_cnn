
// File generated by noodle version U-2022.12#33f3808fcb#221128, Thu Feb 29 15:10:51 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

// File: simple_function.cpp
// Test empty function (return only) and simple function call (without arguments)
// (requires spilling of the link register)

extern "C" {

void empty_function() { }

void simple_function_call()
{
    empty_function();  // nested call
    empty_function();  // tail call (may be replaced by jump)
}

void indirect_function_call(void (*fnptr)())
{
    fnptr();  // nested call
    fnptr();  // tail call (may be replaced by indirect jump)
}


} //extern "C"  (3 functions)
