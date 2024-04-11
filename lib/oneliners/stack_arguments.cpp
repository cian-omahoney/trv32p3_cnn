
// File generated by noodle version U-2022.12#33f3808fcb#221128, Wed Apr 10 19:59:36 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

// File: stack_arguments.cpp
// Test stack argument load/store  (requires spilling)

// Per equivalence class of types with the same representation (same size and routing)
// only one type is tested by default, the others can be tested by defining `plus_identical'.
#ifdef __chess_clang__
#warning "modifying argument passing via chess_stack is not yet supported in llvm, disabling this file"
#else

extern "C" {

//-- signed char

signed char stack_arg_load___schar(chess_stack signed char a) { return a; }
void stack_arg_store___schar(chess_stack signed char& r, signed char a) { r = a; }
void stack_arg_ld_st___schar(chess_stack signed char& r, chess_stack signed char a) { r = a; }

//-- unsigned char

unsigned char stack_arg_load___uchar(chess_stack unsigned char a) { return a; }
void stack_arg_store___uchar(chess_stack unsigned char& r, unsigned char a) { r = a; }
void stack_arg_ld_st___uchar(chess_stack unsigned char& r, chess_stack unsigned char a) { r = a; }

//-- short

short stack_arg_load___sshort(chess_stack short a) { return a; }
void stack_arg_store___sshort(chess_stack short& r, short a) { r = a; }
void stack_arg_ld_st___sshort(chess_stack short& r, chess_stack short a) { r = a; }

//-- unsigned short

unsigned short stack_arg_load___ushort(chess_stack unsigned short a) { return a; }
void stack_arg_store___ushort(chess_stack unsigned short& r, unsigned short a) { r = a; }
void stack_arg_ld_st___ushort(chess_stack unsigned short& r, chess_stack unsigned short a) { r = a; }

//-- int

int stack_arg_load___sint(chess_stack int a) { return a; }
void stack_arg_store___sint(chess_stack int& r, int a) { r = a; }
void stack_arg_ld_st___sint(chess_stack int& r, chess_stack int a) { r = a; }

//-- unsigned

#ifdef plus_identical           // behaves identical to `int'

unsigned stack_arg_load___uint(chess_stack unsigned a) { return a; }
void stack_arg_store___uint(chess_stack unsigned& r, unsigned a) { r = a; }
void stack_arg_ld_st___uint(chess_stack unsigned& r, chess_stack unsigned a) { r = a; }

#endif /*plus_identical*/

//-- long long

long long stack_arg_load___slonglong(chess_stack long long a) { return a; }
void stack_arg_store___slonglong(chess_stack long long& r, long long a) { r = a; }
void stack_arg_ld_st___slonglong(chess_stack long long& r, chess_stack long long a) { r = a; }

//-- unsigned long long

#ifdef plus_identical           // behaves identical to `long long'

unsigned long long stack_arg_load___ulonglong(chess_stack unsigned long long a) { return a; }
void stack_arg_store___ulonglong(chess_stack unsigned long long& r, unsigned long long a) { r = a; }
void stack_arg_ld_st___ulonglong(chess_stack unsigned long long& r, chess_stack unsigned long long a) { r = a; }

#endif /*plus_identical*/

//-- float

#ifdef plus_identical           // behaves identical to `int'

float stack_arg_load___ffloat(chess_stack float a) { return a; }
void stack_arg_store___ffloat(chess_stack float& r, float a) { r = a; }
void stack_arg_ld_st___ffloat(chess_stack float& r, chess_stack float a) { r = a; }

#endif /*plus_identical*/

//-- double

#ifdef plus_identical           // behaves identical to `long long'

double stack_arg_load___fdouble(chess_stack double a) { return a; }
void stack_arg_store___fdouble(chess_stack double& r, double a) { r = a; }
void stack_arg_ld_st___fdouble(chess_stack double& r, chess_stack double a) { r = a; }

#endif /*plus_identical*/

//-- void *

#ifdef plus_identical           // behaves identical to `int'

void * stack_arg_load___Pvoid(chess_stack void * a) { return a; }
void stack_arg_store___Pvoid(chess_stack void *& r, void * a) { r = a; }
void stack_arg_ld_st___Pvoid(chess_stack void *& r, chess_stack void * a) { r = a; }

#endif /*plus_identical*/


} //extern "C"  (33 functions, of which 15 identical)

#endif /*__chess_clang__*/
