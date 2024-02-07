
// File generated by noodle version U-2022.12#33f3808fcb#221128, Wed Feb  7 12:33:48 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

// File: standalone_intrinsics.cpp
// Test standalone intrinsics  (in global namespace)
// (Outputs that cannot be returned as function parameters are discarded)

extern "C" {

int intrc___sint_mulh___sint___sint(int a0, int a1)
    { return mulh(a0, a1); }

unsigned intrc___uint_mulh___uint___uint(unsigned a0, unsigned a1)
    { return mulh(a0, a1); }

int intrc___sint_mulh___sint___uint(int a0, unsigned a1)
    { return mulh(a0, a1); }

int intrc___sint_mulh___uint___sint(unsigned a0, int a1)
    { return mulh(a0, a1); }

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
long long intrc___slonglong_lmul___sint___sint(int a0, int a1)
    { return lmul(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
long long intrc___slonglong_div_called____slonglong___slonglong___slonglong(long long a0, long long a1, long long & a2)
    { return div_called_(a0, a1, a2); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
unsigned long long intrc___ulonglong_div_called____ulonglong___ulonglong___ulonglong(unsigned long long a0, unsigned long long a1, unsigned long long & a2)
    { return div_called_(a0, a1, a2); }
#endif
#endif

int intrc___sint_slt___sint___sint(int a0, int a1)
    { return slt(a0, a1); }

int intrc___sint_slt___uint___uint(unsigned a0, unsigned a1)
    { return slt(a0, a1); }

int intrc___sint_seq0___sint(int a0)
    { return seq0(a0); }

int intrc___sint_sne0___sint(int a0)
    { return sne0(a0); }

int intrc___sint_sle___sint___sint(int a0, int a1)
    { return sle(a0, a1); }

int intrc___sint_sle___uint___uint(unsigned a0, unsigned a1)
    { return sle(a0, a1); }

int intrc___sint_sge___sint___sint(int a0, int a1)
    { return sge(a0, a1); }

int intrc___sint_sge___uint___uint(unsigned a0, unsigned a1)
    { return sge(a0, a1); }

int intrc___sint_sgt___sint___sint(int a0, int a1)
    { return sgt(a0, a1); }

int intrc___sint_sgt___uint___uint(unsigned a0, unsigned a1)
    { return sgt(a0, a1); }

int intrc___sint_sne___sint___sint(int a0, int a1)
    { return sne(a0, a1); }

int intrc___sint_seq___sint___sint(int a0, int a1)
    { return seq(a0, a1); }

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
//@void intrc_void_char_memory_copy___P__cchar___P__cchar___uint(volatile char * a0, const volatile char * a1, const unsigned a2)
//@    { char_memory_copy(a0, a1, a2); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
//@void intrc_void_short_memory_copy___P__sshort___P__sshort___uint(volatile short * a0, const volatile short * a1, const unsigned a2)
//@    { short_memory_copy(a0, a1, a2); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
//@void intrc_void_int_memory_copy___P__sint___P__sint___uint(volatile int * a0, const volatile int * a1, const unsigned a2)
//@    { int_memory_copy(a0, a1, a2); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
int intrc___sint_wrap_f32_to_i32___ffloat(float32_t a0)
    { return wrap_f32_to_i32(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
unsigned intrc___uint_wrap_f32_to_ui32___ffloat(float32_t a0)
    { return wrap_f32_to_ui32(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float32_t intrc___ffloat_wrap_i32_to_f32___sint(int a0)
    { return wrap_i32_to_f32(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float32_t intrc___ffloat_wrap_ui32_to_f32___uint(unsigned a0)
    { return wrap_ui32_to_f32(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
long long intrc___slonglong_wrap_f32_to_i64___ffloat(float32_t a0)
    { return wrap_f32_to_i64(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
unsigned long long intrc___ulonglong_wrap_f32_to_ui64___ffloat(float32_t a0)
    { return wrap_f32_to_ui64(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float32_t intrc___ffloat_wrap_i64_to_f32___slonglong(long long a0)
    { return wrap_i64_to_f32(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float32_t intrc___ffloat_wrap_ui64_to_f32___ulonglong(unsigned long long a0)
    { return wrap_ui64_to_f32(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float32_t intrc___ffloat_wrap_f32_add___ffloat___ffloat(float32_t a0, float32_t a1)
    { return wrap_f32_add(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float32_t intrc___ffloat_wrap_f32_sub___ffloat___ffloat(float32_t a0, float32_t a1)
    { return wrap_f32_sub(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float32_t intrc___ffloat_wrap_f32_mul___ffloat___ffloat(float32_t a0, float32_t a1)
    { return wrap_f32_mul(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float32_t intrc___ffloat_wrap_f32_div___ffloat___ffloat(float32_t a0, float32_t a1)
    { return wrap_f32_div(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
int intrc_bool_wrap_f32_lt___ffloat___ffloat(float32_t a0, float32_t a1)
    { return wrap_f32_lt(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
int intrc_bool_wrap_f32_le___ffloat___ffloat(float32_t a0, float32_t a1)
    { return wrap_f32_le(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
int intrc_bool_wrap_f32_eq___ffloat___ffloat(float32_t a0, float32_t a1)
    { return wrap_f32_eq(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float64_t intrc___fdouble_wrap_f64_add___fdouble___fdouble(float64_t a0, float64_t a1)
    { return wrap_f64_add(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float64_t intrc___fdouble_wrap_f64_sub___fdouble___fdouble(float64_t a0, float64_t a1)
    { return wrap_f64_sub(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float64_t intrc___fdouble_wrap_f64_mul___fdouble___fdouble(float64_t a0, float64_t a1)
    { return wrap_f64_mul(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float64_t intrc___fdouble_wrap_f64_div___fdouble___fdouble(float64_t a0, float64_t a1)
    { return wrap_f64_div(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
int intrc_bool_wrap_f64_lt___fdouble___fdouble(float64_t a0, float64_t a1)
    { return wrap_f64_lt(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
int intrc_bool_wrap_f64_le___fdouble___fdouble(float64_t a0, float64_t a1)
    { return wrap_f64_le(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
int intrc_bool_wrap_f64_eq___fdouble___fdouble(float64_t a0, float64_t a1)
    { return wrap_f64_eq(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float64_t intrc___fdouble_wrap_f32_to_f64___ffloat(float32_t a0)
    { return wrap_f32_to_f64(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float32_t intrc___ffloat_wrap_f64_to_f32___fdouble(float64_t a0)
    { return wrap_f64_to_f32(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
int intrc___sint_wrap_f64_to_i32___fdouble(float64_t a0)
    { return wrap_f64_to_i32(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
unsigned intrc___uint_wrap_f64_to_ui32___fdouble(float64_t a0)
    { return wrap_f64_to_ui32(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float64_t intrc___fdouble_wrap_i32_to_f64___sint(int a0)
    { return wrap_i32_to_f64(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float64_t intrc___fdouble_wrap_ui32_to_f64___uint(unsigned a0)
    { return wrap_ui32_to_f64(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
long long intrc___slonglong_wrap_f64_to_i64___fdouble(float64_t a0)
    { return wrap_f64_to_i64(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
unsigned long long intrc___ulonglong_wrap_f64_to_ui64___fdouble(float64_t a0)
    { return wrap_f64_to_ui64(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float64_t intrc___fdouble_wrap_i64_to_f64___slonglong(long long a0)
    { return wrap_i64_to_f64(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
float64_t intrc___fdouble_wrap_ui64_to_f64___ulonglong(unsigned long long a0)
    { return wrap_ui64_to_f64(a0); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
//@@ Only for compile-time constants
//@int intrc___sint_sdiv_by_ct1___sint___sint(int a0, const int a1)
//@    { return sdiv_by_ct1(a0, a1); }
#endif
#endif

#ifdef __chess__  //! property(dont_generate_native)
#ifndef __chess_clang__  //! property(dont_generate_llvm)
//@@ Only for compile-time constants
//@unsigned intrc___uint_udiv_by_ct1___uint___uint(unsigned a0, const unsigned a1)
//@    { return udiv_by_ct1(a0, a1); }
#endif
#endif

int intrc___sint_MyMAC___sint___sint___sint(int a0, int a1, int a2)
    { return MyMAC(a0, a1, a2); }


} //extern "C"  (57 functions of which 5 skipped)
