
// File generated by noodle version U-2022.12#33f3808fcb#221128, Wed Apr 10 19:59:36 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

// File: stack_DMb.cpp
// Stack frame 0 : memory DMb stack pointer SP -- frame alignment 4

// Per equivalence class of types with the same representation (same size and routing)
// only one type is tested by default, the others can be tested by defining `plus_identical'.

#ifndef M // arbitrary value, adapt at will
#define M 17
#endif
#ifndef N // arbitrary value < M, adapt at will
#define N 13
#endif

extern "C" {

// Test stack allocation and address generation (for use in normal pointer operations)
// (Return address will point to deallocated space, but remains valid when not dereferenced)
// (Type of object is irrelevant, but must be allocatable)

void chess_storage(DMb) * stack_address_DMb()
{
    char o[M];
    return &o[N];
}

void chess_storage(DMb) * stack_address_pI_DMb(int i)
{
    char o[M];
    return &o[N+i];
}

void chess_storage(DMb) * stack_address_mI_DMb(int i)
{
    char o[M];
    return &o[N-i];
}

// Test direct stack load/store
// (Without volatile these over-simplified tests would be optimised away:
//  - an uninitialized stack load would result in an undefined value;
//  - a stand-alone stack store would be dead code;
//  - a combined stack store and load would be redundant code.)

//-- signed char                // size=1 alignment=1

signed char stack_load___schar_DMb() { volatile signed char o[M]; return o[N]; }
void stack_store___schar_DMb(signed char a) { volatile signed char o[M]; o[N] = a; }
signed char stack_st_ld___schar_DMb(signed char a) { volatile signed char o[M]; o[N] = a; return o[N]; }

//-- unsigned char              // size=1 alignment=1

unsigned char stack_load___uchar_DMb() { volatile unsigned char o[M]; return o[N]; }
void stack_store___uchar_DMb(unsigned char a) { volatile unsigned char o[M]; o[N] = a; }
unsigned char stack_st_ld___uchar_DMb(unsigned char a) { volatile unsigned char o[M]; o[N] = a; return o[N]; }

//-- short                      // size=2 alignment=2

short stack_load___sshort_DMb() { volatile short o[M]; return o[N]; }
void stack_store___sshort_DMb(short a) { volatile short o[M]; o[N] = a; }
short stack_st_ld___sshort_DMb(short a) { volatile short o[M]; o[N] = a; return o[N]; }

//-- unsigned short             // size=2 alignment=2

unsigned short stack_load___ushort_DMb() { volatile unsigned short o[M]; return o[N]; }
void stack_store___ushort_DMb(unsigned short a) { volatile unsigned short o[M]; o[N] = a; }
unsigned short stack_st_ld___ushort_DMb(unsigned short a) { volatile unsigned short o[M]; o[N] = a; return o[N]; }

//-- int                        // size=4 alignment=4

int stack_load___sint_DMb() { volatile int o[M]; return o[N]; }
void stack_store___sint_DMb(int a) { volatile int o[M]; o[N] = a; }
int stack_st_ld___sint_DMb(int a) { volatile int o[M]; o[N] = a; return o[N]; }

//-- unsigned                   // size=4 alignment=4

#ifdef plus_identical           // behaves identical to `int'

unsigned stack_load___uint_DMb() { volatile unsigned o[M]; return o[N]; }
void stack_store___uint_DMb(unsigned a) { volatile unsigned o[M]; o[N] = a; }
unsigned stack_st_ld___uint_DMb(unsigned a) { volatile unsigned o[M]; o[N] = a; return o[N]; }

#endif /*plus_identical*/

//-- long long                  // size=8 alignment=4

long long stack_load___slonglong_DMb() { volatile long long o[M]; return o[N]; }
void stack_store___slonglong_DMb(long long a) { volatile long long o[M]; o[N] = a; }
long long stack_st_ld___slonglong_DMb(long long a) { volatile long long o[M]; o[N] = a; return o[N]; }

//-- unsigned long long         // size=8 alignment=4

#ifdef plus_identical           // behaves identical to `long long'

unsigned long long stack_load___ulonglong_DMb() { volatile unsigned long long o[M]; return o[N]; }
void stack_store___ulonglong_DMb(unsigned long long a) { volatile unsigned long long o[M]; o[N] = a; }
unsigned long long stack_st_ld___ulonglong_DMb(unsigned long long a) { volatile unsigned long long o[M]; o[N] = a; return o[N]; }

#endif /*plus_identical*/

//-- float                      // size=4 alignment=4

#ifdef plus_identical           // behaves identical to `int'

float stack_load___ffloat_DMb() { volatile float o[M]; return o[N]; }
void stack_store___ffloat_DMb(float a) { volatile float o[M]; o[N] = a; }
float stack_st_ld___ffloat_DMb(float a) { volatile float o[M]; o[N] = a; return o[N]; }

#endif /*plus_identical*/

//-- double                     // size=8 alignment=4

#ifdef plus_identical           // behaves identical to `long long'

double stack_load___fdouble_DMb() { volatile double o[M]; return o[N]; }
void stack_store___fdouble_DMb(double a) { volatile double o[M]; o[N] = a; }
double stack_st_ld___fdouble_DMb(double a) { volatile double o[M]; o[N] = a; return o[N]; }

#endif /*plus_identical*/

//-- void *                     // size=4 alignment=4

#ifdef plus_identical           // behaves identical to `int'

void * stack_load___Pvoid_DMb() { void * volatile o[M]; return o[N]; }
void stack_store___Pvoid_DMb(void * a) { void * volatile o[M]; o[N] = a; }
void * stack_st_ld___Pvoid_DMb(void * a) { void * volatile o[M]; o[N] = a; return o[N]; }

#endif /*plus_identical*/


} //extern "C"  (36 functions, of which 15 identical)
