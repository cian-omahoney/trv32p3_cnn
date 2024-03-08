
// File generated by noodle version U-2022.12#33f3808fcb#221128, Fri Mar  8 16:45:52 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

// File: constant_generation.cpp
// Test constant generation

extern "C" {

//-- signed char                // property(  8 bit   signed )

signed char         ctgen___schar_00() { return 0; }
signed char         ctgen___schar_09() { return 9; }
signed char         ctgen___schar_f7() { return -9; }
signed char         ctgen___schar_31() { return 49; }
signed char         ctgen___schar_b1() { return -79; }

//-- unsigned char              // property(  8 bit unsigned )

unsigned char       ctgen___uchar_00() { return 0; }
unsigned char       ctgen___uchar_09() { return 9; }
unsigned char       ctgen___uchar_f7() { return 247U; }
unsigned char       ctgen___uchar_31() { return 49; }
unsigned char       ctgen___uchar_b1() { return 177U; }

//-- short                      // property( 16 bit   signed )

short               ctgen___sshort_0000() { return 0; }
short               ctgen___sshort_0009() { return 9; }
short               ctgen___sshort_fff7() { return -9; }
short               ctgen___sshort_32b1() { return 12977; }
short               ctgen___sshort_b2b1() { return -19791; }

//-- unsigned short             // property( 16 bit unsigned )

unsigned short      ctgen___ushort_0000() { return 0; }
unsigned short      ctgen___ushort_0009() { return 9; }
unsigned short      ctgen___ushort_fff7() { return 65527U; }
unsigned short      ctgen___ushort_32b1() { return 12977; }
unsigned short      ctgen___ushort_b2b1() { return 45745U; }

//-- int                        // property( 32 bit   signed )

int                 ctgen___sint_00000000() { return 0; }
int                 ctgen___sint_00000009() { return 9; }
int                 ctgen___sint_fffffff7() { return -9; }
int                 ctgen___sint_34b3b2b1() { return 884191921; }
int                 ctgen___sint_b4b3b2b1() { return -1263291727; }

//-- unsigned                   // property( 32 bit unsigned )

unsigned            ctgen___uint_00000000() { return 0; }
unsigned            ctgen___uint_00000009() { return 9; }
unsigned            ctgen___uint_fffffff7() { return 4294967287U; }
unsigned            ctgen___uint_34b3b2b1() { return 884191921; }
unsigned            ctgen___uint_b4b3b2b1() { return 3031675569U; }

//-- long long                  // property( 64 bit   signed )

long long           ctgen___slonglong_0000000000000000() { return 0; }
long long           ctgen___slonglong_0000000000000009() { return 9; }
long long           ctgen___slonglong_fffffffffffffff7() { return -9; }
long long           ctgen___slonglong_38b7b6b5b4b3b2b1() { return 4086936078399025841; }
long long           ctgen___slonglong_b8b7b6b5b4b3b2b1() { return -5136435958455749967; }

//-- unsigned long long         // property( 64 bit unsigned )

unsigned long long  ctgen___ulonglong_0000000000000000() { return 0; }
unsigned long long  ctgen___ulonglong_0000000000000009() { return 9; }
unsigned long long  ctgen___ulonglong_fffffffffffffff7() { return 18446744073709551607U; }
unsigned long long  ctgen___ulonglong_38b7b6b5b4b3b2b1() { return 4086936078399025841; }
unsigned long long  ctgen___ulonglong_b8b7b6b5b4b3b2b1() { return 13310308115253801649U; }

//-- float                      // property( 32 bit /*sign_magnitude*/ 8 exp_bits /*exp_biased*/ ieee /*msb_implicit_integral*/ )

float               ctgen___ffloat_00000000() { return 0.0; }
float               ctgen___ffloat_3f800000() { return 1.0; }
float               ctgen___ffloat_bf800000() { return -1.0; }
float               ctgen___ffloat_3f200000() { return 0.625; }
float               ctgen___ffloat_bf200000() { return -0.625; }
float               ctgen___ffloat_3eb6c8b4() { return 0.357; }
float               ctgen___ffloat_beb6c8b4() { return -0.357; }
float               ctgen___ffloat_40200000() { return 2.5; }
float               ctgen___ffloat_c0200000() { return -2.5; }

//-- double                     // property( 64 bit /*sign_magnitude*/ 11 exp_bits /*exp_biased*/ ieee /*msb_implicit_integral*/ )

double              ctgen___fdouble_0000000000000000() { return 0.0; }
double              ctgen___fdouble_3ff0000000000000() { return 1.0; }
double              ctgen___fdouble_bff0000000000000() { return -1.0; }
double              ctgen___fdouble_3fe4000000000000() { return 0.625; }
double              ctgen___fdouble_bfe4000000000000() { return -0.625; }
double              ctgen___fdouble_3fd6d916872b020c() { return 0.357; }
double              ctgen___fdouble_bfd6d916872b020c() { return -0.357; }
double              ctgen___fdouble_4004000000000000() { return 2.5; }
double              ctgen___fdouble_c004000000000000() { return -2.5; }



// Relocatable addresses, range determined by memory
// (Type of object is irrelevant, but must be allocatable)

#ifndef __chess_clang__ /*no allocatable application type found*/
extern trv32p3_cnn_primitive::u08 chess_storage(PMb) o_PMb;
void chess_storage(PMb) * ctptr_PMb() { return &o_PMb; }
#endif /*__chess_clang__*/

extern char chess_storage(DMb) o_DMb;
void chess_storage(DMb) * ctptr_DMb() { return &o_DMb; }

extern char chess_storage(DMb_stat) o_DMb_stat;
void chess_storage(DMb_stat) * ctptr_DMb_stat() { return &o_DMb_stat; }


} //extern "C"  (61 functions)
