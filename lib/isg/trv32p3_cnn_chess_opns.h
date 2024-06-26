
// File generated by noodle version U-2022.12#33f3808fcb#221128, Wed Apr 10 19:59:36 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

#ifdef __chess__
#error "generated native file not intended for compilation by chess"
#endif

#ifndef _trv32p3_cnn_chess_opns_h
#define _trv32p3_cnn_chess_opns_h

// Native equivalent of Chess promoted operations

#ifdef __GNUC__
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wparentheses"
#endif
#ifdef _MSC_VER
#pragma warning(push)
#pragma warning(disable : 4554) // C4554: check operator precedence for possible error
#endif

#ifdef CHESS_NATIVE_NAMESPACE
namespace CHESS_NATIVE_NAMESPACE {
#endif


class keep_in_registers_wrapper__slonglong {
    long long val;
public:
    keep_in_registers_wrapper__slonglong(long long v) : val(v) {}
    unsigned value_low() const;
    unsigned value_high() const;
};


class keep_in_registers_wrapper__ulonglong {
    unsigned long long val;
public:
    keep_in_registers_wrapper__ulonglong(unsigned long long v) : val(v) {}
    unsigned value_low() const;
    unsigned value_high() const;
};

int mulh(int, int) chess_property(commutative mulhs);
unsigned mulh(unsigned, unsigned) chess_property(commutative mulhu);
int mulh(int, unsigned);
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint to_dint_se(int);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint to_dint_ze(int);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ int to_int(dint);
} //namespace trv32p3_cnn_primitive
#endif//!
namespace trv32p3_cnn_primitive {
//!unsigned add(unsigned, unsigned) chess_property(commutative duplicate_at_using_opn2);
} //namespace trv32p3_cnn_primitive
namespace trv32p3_cnn_primitive {
//!unsigned sub(unsigned, unsigned) chess_property(duplicate_at_using_opn2);
} //namespace trv32p3_cnn_primitive
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint l_add(dint, dint);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint l_sub(dint, dint);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint l_and(dint, dint);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint l_or(dint, dint);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint l_xor(dint, dint);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint l_complement(dint);
} //namespace trv32p3_cnn_primitive
#endif//!
namespace trv32p3_cnn_primitive {
//!unsigned mulh(int, int) chess_property(commutative);
} //namespace trv32p3_cnn_primitive
namespace trv32p3_cnn_primitive {
//!unsigned mulhu(unsigned, unsigned) chess_property(commutative);
} //namespace trv32p3_cnn_primitive
namespace trv32p3_cnn_primitive {
//!unsigned mul(unsigned, unsigned) chess_property(commutative);
} //namespace trv32p3_cnn_primitive
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint l_mul(dint, dint);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint l_mul(int, int);
} //namespace trv32p3_cnn_primitive
#endif//!
//!long long lmul(int, int);
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ bool l_lts(dint, dint);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ bool l_les(dint, dint);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ bool l_ltu(dint, dint);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ bool l_leu(dint, dint);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ bool l_eq(dint, dint);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ bool l_ne(dint, dint);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint l_lsl(dint, int);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint l_asr(dint, int);
} //namespace trv32p3_cnn_primitive
#endif//!
#if 0//!
namespace trv32p3_cnn_primitive {
    /*inline*/ dint l_lsr(dint, int);
} //namespace trv32p3_cnn_primitive
#endif//!
int slt(int, int);
int slt(unsigned, unsigned);
int seq0(int);
int sne0(int);
namespace trv32p3_cnn_primitive {
    /*inline*/ w32 imac(w32, w32, w32);
} //namespace trv32p3_cnn_primitive
namespace trv32p3_cnn_primitive {
    /*inline*/ w32 iexp(w32);
} //namespace trv32p3_cnn_primitive
namespace trv32p3_cnn_primitive {
    /*inline*/ w32 irelu(w32);
} //namespace trv32p3_cnn_primitive
namespace trv32p3_cnn_primitive {
    /*inline*/ w32 iincmac(w32, w32, w32, w32, w32 &, w32, w32 &);
} //namespace trv32p3_cnn_primitive
int MyMAC(int, int, int);
int exp(int);
int ReLU(int);
int incmac(int, int, int, int, int &, int, int &);


// do_generate[_native] inline functions

    inline int mulh(unsigned a, int b)
    {
     return mulh(b,a);
    }

#if 0//!
extern long long div_called(long long, long long, chess_output long long &) chess_property(functional);
#endif//!

#if 0//!
extern unsigned long long div_called(unsigned long long, unsigned long long, chess_output unsigned long long &) chess_property(functional);
#endif//!

    inline int sle(int a, int b)
    {
     return slt(b,a) ^ 1;
    }

    inline int sle(unsigned a, unsigned b)
    {
     return slt(b,a) ^ 1;
    }

    inline int sge(int a, int b)
    {
     return slt(a,b) ^ 1;
    }

    inline int sge(unsigned a, unsigned b)
    {
     return slt(a,b) ^ 1;
    }

    inline int sgt(int a, int b)
    {
     return slt(b,a);
    }

    inline int sgt(unsigned a, unsigned b)
    {
     return slt(b,a);
    }

    inline int sne(int a, int b)
    {
     return sne0(a - b);
    }

    inline int seq(int a, int b)
    {
     return seq0(a - b);
    }

#if 0//!
extern "C" float ui32_to_f32(unsigned) chess_property(functional);
#endif//!

#if 0//!
extern "C" double ui32_to_f64(unsigned) chess_property(functional);
#endif//!

#if 0//!
extern "C" float i32_to_f32(int) chess_property(functional);
#endif//!

#if 0//!
extern "C" double i32_to_f64(int) chess_property(functional);
#endif//!

#if 0//!
extern "C" float ui64_to_f32(unsigned long long) chess_property(functional);
#endif//!

#if 0//!
extern "C" double ui64_to_f64(unsigned long long) chess_property(functional);
#endif//!

#if 0//!
extern "C" float i64_to_f32(long long) chess_property(functional);
#endif//!

#if 0//!
extern "C" double i64_to_f64(long long) chess_property(functional);
#endif//!

#if 0//!
extern "C" unsigned long f32_to_ui32_r_minMag(float, bool) chess_property(functional);
#endif//!

#if 0//!
extern "C" unsigned long long f32_to_ui64_r_minMag(float, bool) chess_property(functional);
#endif//!

#if 0//!
extern "C" long f32_to_i32_r_minMag(float, bool) chess_property(functional);
#endif//!

#if 0//!
extern "C" long long f32_to_i64_r_minMag(float, bool) chess_property(functional);
#endif//!

#if 0//!
extern "C" double f32_to_f64(float) chess_property(functional);
#endif//!

#if 0//!
extern "C" float f32_roundToInt(float, unsigned long, bool) chess_property(functional);
#endif//!

#if 0//!
extern "C" float f32_add(float, float) chess_property(functional);
#endif//!

#if 0//!
extern "C" float f32_sub(float, float) chess_property(functional);
#endif//!

#if 0//!
extern "C" float f32_mul(float, float) chess_property(functional);
#endif//!

#if 0//!
extern "C" float f32_div(float, float) chess_property(functional);
#endif//!

#if 0//!
extern "C" bool f32_eq(float, float) chess_property(functional);
#endif//!

#if 0//!
extern "C" bool f32_le(float, float) chess_property(functional);
#endif//!

#if 0//!
extern "C" bool f32_lt(float, float) chess_property(functional);
#endif//!

#if 0//!
extern "C" unsigned long f64_to_ui32_r_minMag(double, bool) chess_property(functional);
#endif//!

#if 0//!
extern "C" unsigned long long f64_to_ui64_r_minMag(double, bool) chess_property(functional);
#endif//!

#if 0//!
extern "C" long f64_to_i32_r_minMag(double, bool) chess_property(functional);
#endif//!

#if 0//!
extern "C" long long f64_to_i64_r_minMag(double, bool) chess_property(functional);
#endif//!

#if 0//!
extern "C" float f64_to_f32(double) chess_property(functional);
#endif//!

#if 0//!
extern "C" double f64_roundToInt(double, unsigned long, bool) chess_property(functional);
#endif//!

#if 0//!
extern "C" double f64_add(double, double) chess_property(functional);
#endif//!

#if 0//!
extern "C" double f64_sub(double, double) chess_property(functional);
#endif//!

#if 0//!
extern "C" double f64_mul(double, double) chess_property(functional);
#endif//!

#if 0//!
extern "C" double f64_div(double, double) chess_property(functional);
#endif//!

#if 0//!
extern "C" bool f64_eq(double, double) chess_property(functional);
#endif//!

#if 0//!
extern "C" bool f64_le(double, double) chess_property(functional);
#endif//!

#if 0//!
extern "C" bool f64_lt(double, double) chess_property(functional);
#endif//!

#ifdef tentative_generate_member_fn_defns
    inline trv32p3_cnn_primitive::dint::dint(unsigned l, unsigned h)
    : low(l), high(h)
    {
    }

#endif

#ifdef CHESS_NATIVE_NAMESPACE
} //namespace CHESS_NATIVE_NAMESPACE
#endif

#ifdef _MSC_VER
#pragma warning(pop)
#endif
#ifdef __GNUC__
#pragma GCC diagnostic pop
#endif


#endif /*_trv32p3_cnn_chess_opns_h*/
