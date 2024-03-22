
// File generated by noodle version U-2022.12#33f3808fcb#221128, Fri Mar 22 18:53:58 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

// File: register_moves.cpp
// Test register moves
// (Output is written as an in-out reference, so that it cannot be overlayed with the input)

// Per equivalence class of types with the same representation (same size and routing)
// only one type is tested by default, the others can be tested by defining `plus_identical'.

//! Connection analysis may reveal that certain moves are not available, and those tests are elided by default.
//! Note that the connection may be direct or indirect (via another register).
//! However, indirect connections via spill memory are not considered at this time, so some tests may compile after all.
//! Define `plus_unconnected' to test all elided tests too, which may require more entries to be added to the ``oneliners.skip'' file.

#ifdef __chess_clang__
#warning "modifying argument passing via chess_storages is not yet supported in llvm, disabling this file"
#else

extern "C" {

//-- signed char

void move___schar_X_X(signed char& chess_storage(X) r, signed char chess_storage(X) a) { r = a; }

//-- unsigned char

void move___uchar_X_X(unsigned char& chess_storage(X) r, unsigned char chess_storage(X) a) { r = a; }

//-- short

void move___sshort_X_X(short& chess_storage(X) r, short chess_storage(X) a) { r = a; }

//-- unsigned short

void move___ushort_X_X(unsigned short& chess_storage(X) r, unsigned short chess_storage(X) a) { r = a; }

//-- int

void move___sint_X_X(int& chess_storage(X) r, int chess_storage(X) a) { r = a; }

//-- unsigned

#ifdef plus_identical           // behaves identical to `int'

void move___uint_X_X(unsigned& chess_storage(X) r, unsigned chess_storage(X) a) { r = a; }

#endif /*plus_identical*/

//-- long long

//-- unsigned long long

#ifdef plus_identical           // behaves identical to `long long'

#endif /*plus_identical*/

//-- float

#ifdef plus_identical           // behaves identical to `int'

void move___ffloat_X_X(float& chess_storage(X) r, float chess_storage(X) a) { r = a; }

#endif /*plus_identical*/

//-- double

#ifdef plus_identical           // behaves identical to `long long'

#endif /*plus_identical*/

//-- void *

#ifdef plus_identical           // behaves identical to `int'

void move___Pvoid_X_X(void *& chess_storage(X) r, void * chess_storage(X) a) { r = a; }

#endif /*plus_identical*/


} //extern "C"  (8 functions, of which 3 identical)

#endif /*__chess_clang__*/
