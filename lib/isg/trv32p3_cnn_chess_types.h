
// File generated by noodle version U-2022.12#33f3808fcb#221128, Thu Feb 29 15:10:51 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

#ifdef __chess__
#error "generated native file not intended for compilation by chess"
#endif

// Native C++ types and functions

#ifndef _trv32p3_cnn_chess_types_h
#define _trv32p3_cnn_chess_types_h

#include "chess.h"
#include "vbit.h"

#ifndef VBITzCONSTEXPR /*trouble-shooting hook -- additional isolation layer*/
#define VBITzCONSTEXPR VBIT_CONSTEXPR
#endif

#include "trv32p3_cnn_iss_types.h"

#ifdef __GNUC__
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wparentheses"
#endif
#ifdef _MSC_VER
#pragma warning(push)
#pragma warning(disable : 4554) // C4554: check operator precedence for possible error
#endif

#ifndef __CHAR_BIT__
#define __CHAR_BIT__ 8
#endif

#ifdef CHESS_NATIVE_NAMESPACE
namespace CHESS_NATIVE_NAMESPACE {
#endif


//  Application types (declarations)

//  (none)

//class float;          // property( 32 bit /*sign_magnitude*/ 8 exp_bits /*exp_biased*/ ieee /*msb_implicit_integral*/ );
//class double;         // property( 64 bit /*sign_magnitude*/ 11 exp_bits /*exp_biased*/ ieee /*msb_implicit_integral*/ );
//class long double;    // property( 64 bit /*sign_magnitude*/ 11 exp_bits /*exp_biased*/ ieee /*msb_implicit_integral*/ );


//  Application types (additional) (declaration)

#ifndef do_not_generate_additional_appl_types /*trouble-shooting hook*/

#if 0 //!dont_generate
namespace trv32p3_cnn_primitive {
    struct dint;
}
#endif //!dont_generate

//!typedef float float32_t;

//!typedef double float64_t;

#endif /*do_not_generate_additional_appl_types*/


#include <stdint.h>
#include <string.h>
extern long long dbl2expo(double, int bits, int sign, int expo, int sexp, int layo, int mbit, int zexp);
extern double expo2dbl(long long, int bits, int sign, int expo, int sexp, int layo, int mbit, int zexp);
// fast ieee versions, with NaN support, and avoiding (float)(double)(float) which isn't idempotent for some NaNs
inline int32_t flt2ieee(float   a) { int32_t r; memcpy(&r, &a, sizeof(int32_t)); return r; }
inline int64_t dbl2ieee(double  a) { int64_t r; memcpy(&r, &a, sizeof(int64_t)); return r; }
inline float   ieee2flt(int32_t a) { float   r; memcpy(&r, &a, sizeof(float  )); return r; }
inline double  ieee2dbl(int64_t a) { double  r; memcpy(&r, &a, sizeof(double )); return r; }

//  Built-in type wrappers (bit-true behaviour or used as vector element type)

namespace trv32p3_cnn_BT {

//class BTbool /* std C conforming */

//class BT__schar /* std C conforming */

//class BT__uchar /* std C conforming */

//class BT__sshort /* std C conforming */

//class BT__ushort /* std C conforming */

//class BT__sint /* std C conforming */

//class BT__uint /* std C conforming */

//class BT__slonglong /* std C conforming */

//class BT__ulonglong /* std C conforming */

//class BT__ffloat /* std C conforming */

//class BT__fdouble /* std C conforming */

} //namespace trv32p3_cnn_BT


//  Application types (definitions)

//  Application types (additional) (definition)

#ifndef do_not_generate_additional_appl_types /*trouble-shooting hook*/

#if 0 //!dont_generate
namespace trv32p3_cnn_primitive {
    struct dint {
        unsigned low;
        unsigned high;
        typedef VBit<64, false> BitType;
#ifndef do_not_generate_member_fn_declrs /*trouble-shooting hook*/
#ifdef __cplusplus
        inline dint(unsigned, unsigned);
        dint() = default;
#endif /*__cplusplus*/
#endif
    };
    inline dint::BitType toBitType(const dint& v) {
        return (dint::BitType(VBit<32, false>(v.low)) << 0)
            |  (dint::BitType(VBit<32, false>(v.high)) << 32);
    }
}
#endif //!dont_generate

#endif /*do_not_generate_additional_appl_types*/


//  Conversions

inline int as_int32(float a)            { return flt2ieee(a); }
inline float as_float(int a)            { return ieee2flt(a); }
inline long long as_int64(double a)     { return dbl2ieee(a); }
inline double as_double(long long a)    { return ieee2dbl(a); }

//  Operations

//TBD

//  Default is to output to cout and cerr, override for a specific file or even thread specific

#ifndef chess_report_os
#define chess_report_os std::cout
#endif
#ifndef chess_error_os
#define chess_error_os std::cerr
#endif

//  Chess_message hook for printing text between chess_reports (native only)

#define chess_message(msg) chess_report_os << msg << std::endl


#ifndef do_not_generate_chess_assert /*trouble-shooting hook*/

//  Chess_assert ancillary functions (native emulating ISS)

#define chess_assert(val)  (void)(chess_assert_(val)||chess_assert_msg(__FILE__,__LINE__))

inline int chess_assert_msg(const char* file, int line) {
    chess_report_os.flush();
    chess_error_os << "ERROR Assertion failed in \"" << file << "\", line " << line << ".\n";
    return 0;
}

//  Overloaded chess_assert functions (allow to assert types without operator bool())

inline int chess_assert_(bool a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(char a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(signed char a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(unsigned char a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(short a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(unsigned short a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(int a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(unsigned a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(long a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(unsigned long a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(long long a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(unsigned long long a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(float a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(double a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(long double a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(const volatile void* a) {
  return a != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::w08 a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::w16 a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::w32 a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::u08 a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::addr a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::iword a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::t1u a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::t2u a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::t5u a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::t6u a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::t8u a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::t12s a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::t5unz a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::t13s_s2 a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::t20s_rp12 a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::t21s_s2 a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::t31s_rp1 a) {
  return toVBit(a) != 0 ? 1 : 0;
}
inline int chess_assert_(trv32p3_cnn_primitive::w64 a) {
  return toVBit(a) != 0 ? 1 : 0;
}

#endif /*!do_not_generate_chess_assert*/


#ifndef do_not_generate_chess_report /*trouble-shooting hook*/

//  Chess_report ancillary functions (common to ISS and native)

inline void chess_report_hex(int bits, long long val, std::ostream& os) {
    auto flags(os.flags());
    os << " 0x" << std::hex << std::setfill('0') << std::setw((bits+3)/4) << CHESS_MASKLL(val,bits);
    os.flags(flags);
}
inline void chess_report_signed  (long long  val, std::ostream& os) {
    auto flags(os.flags());
    os << ' ' << std::dec << val;
    os.flags(flags);
}
inline void chess_report_unsigned(unsigned long long val, std::ostream& os) {
    auto flags(os.flags());
    os << ' ' << std::dec << val;
    os.flags(flags);
}
inline void chess_report_expo(int prc, double val, std::ostream& os) {
    auto flags(os.flags());
    os << ' ' << std::scientific << std::setprecision(prc) << val;
    os.flags(flags);
}

//  Overloaded chess_report functions

inline void chess_report(bool a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(bool):";
    chess_report_hex(1, a, os);
    os << " //";
    chess_report_unsigned(a, os);
    os << std::endl;
}
inline void chess_report(char a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(char):";
    chess_report_hex(8, a, os);
    os << " //";
    chess_report_signed(a, os);
    os << std::endl;
}
inline void chess_report(signed char a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(signed char):";
    chess_report_hex(8, a, os);
    os << " //";
    chess_report_signed(a, os);
    os << std::endl;
}
inline void chess_report(unsigned char a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(unsigned char):";
    chess_report_hex(8, a, os);
    os << " //";
    chess_report_unsigned(a, os);
    os << std::endl;
}
inline void chess_report(short a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(short):";
    chess_report_hex(16, a, os);
    os << " //";
    chess_report_signed(a, os);
    os << std::endl;
}
inline void chess_report(unsigned short a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(unsigned short):";
    chess_report_hex(16, a, os);
    os << " //";
    chess_report_unsigned(a, os);
    os << std::endl;
}
inline void chess_report(int a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(int):";
    chess_report_hex(32, a, os);
    os << " //";
    chess_report_signed(a, os);
    os << std::endl;
}
inline void chess_report(unsigned a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(unsigned):";
    chess_report_hex(32, a, os);
    os << " //";
    chess_report_unsigned(a, os);
    os << std::endl;
}
inline void chess_report(long a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(long):";
    chess_report_hex(32, a, os);
    os << " //";
    chess_report_signed(a, os);
    os << std::endl;
}
inline void chess_report(unsigned long a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(unsigned long):";
    chess_report_hex(32, a, os);
    os << " //";
    chess_report_unsigned(a, os);
    os << std::endl;
}
inline void chess_report(long long a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(long long):";
    chess_report_hex(64, a, os);
    os << " //";
    chess_report_signed(a, os);
    os << std::endl;
}
inline void chess_report(unsigned long long a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(unsigned long long):";
    chess_report_hex(64, a, os);
    os << " //";
    chess_report_unsigned(a, os);
    os << std::endl;
}
inline void chess_report(float a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(float):";
    chess_report_hex(32, flt2ieee(a), os);
    os << " //";
    chess_report_expo(7, a, os);
    os << std::endl;
}
inline void chess_report(double a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(double):";
    chess_report_hex(64, dbl2ieee(a), os);
    os << " //";
    chess_report_expo(16, a, os);
    os << std::endl;
}
inline void chess_report(long double a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(long double):";
    chess_report_hex(64, dbl2ieee(a), os);
    os << " //";
    chess_report_expo(16, a, os);
    os << std::endl;
}
inline void chess_report(const volatile void* a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(void*):";
    chess_report_hex(sizeof(void*)*8/*no mask*/, (unsigned long long)a, os);
    os << " //";
    chess_report_unsigned((unsigned long long)a, os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::w08 a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::w08):";
    chess_report_hex(8, toVBit(a).value(), os);
    os << " //";
    chess_report_signed(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::w16 a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::w16):";
    chess_report_hex(16, toVBit(a).value(), os);
    os << " //";
    chess_report_signed(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::w32 a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::w32):";
    chess_report_hex(32, toVBit(a).value(), os);
    os << " //";
    chess_report_signed(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::u08 a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::u08):";
    chess_report_hex(8, toVBit(a).value(), os);
    os << " //";
    chess_report_unsigned(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::addr a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::addr):";
    chess_report_hex(32, toVBit(a).value(), os);
    os << " //";
    chess_report_unsigned(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::iword a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::iword):";
    chess_report_hex(32, toVBit(a).value(), os);
    os << " //";
    chess_report_unsigned(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::t1u a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::t1u):";
    chess_report_hex(1, toVBit(a).value(), os);
    os << " //";
    chess_report_unsigned(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::t2u a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::t2u):";
    chess_report_hex(2, toVBit(a).value(), os);
    os << " //";
    chess_report_unsigned(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::t5u a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::t5u):";
    chess_report_hex(5, toVBit(a).value(), os);
    os << " //";
    chess_report_unsigned(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::t6u a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::t6u):";
    chess_report_hex(6, toVBit(a).value(), os);
    os << " //";
    chess_report_unsigned(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::t8u a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::t8u):";
    chess_report_hex(8, toVBit(a).value(), os);
    os << " //";
    chess_report_unsigned(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::t12s a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::t12s):";
    chess_report_hex(12, toVBit(a).value(), os);
    os << " //";
    chess_report_signed(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::t5unz a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::t5unz):";
    chess_report_hex(5, toVBit(a).value(), os);
    os << " //";
    chess_report_unsigned(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::t13s_s2 a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::t13s_s2):";
    chess_report_hex(13, toVBit(a).value(), os);
    os << " //";
    chess_report_signed(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::t20s_rp12 a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::t20s_rp12):";
    chess_report_hex(20, toVBit(a).value(), os);
    os << " //";
    chess_report_signed(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::t21s_s2 a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::t21s_s2):";
    chess_report_hex(21, toVBit(a).value(), os);
    os << " //";
    chess_report_signed(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::t31s_rp1 a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::t31s_rp1):";
    chess_report_hex(31, toVBit(a).value(), os);
    os << " //";
    chess_report_signed(toVBit(a).value(), os);
    os << std::endl;
}
inline void chess_report(trv32p3_cnn_primitive::w64 a) {
    std::ostream& os = chess_report_os;
    os << "chess_report(trv32p3_cnn_primitive::w64):";
    chess_report_hex(64, toVBit(a).value(), os);
    os << " //";
    chess_report_signed(toVBit(a).value(), os);
    os << std::endl;
}

#endif /*!do_not_generate_chess_report*/


#ifndef do_not_generate_chess_cycle_count /*trouble-shooting hook*/

// stub, but with correct (largest suitable) return type on trv32p3_cnn (may influence C++ overloading)
inline unsigned long long chess_cycle_count() { return 0; }

#endif /*!do_not_generate_chess_cycle_count*/


#ifndef do_not_generate_chess_return_address /*trouble-shooting hook*/

#if defined __GNUC__
#define chess_return_address() ((void*)__builtin_return_address(0))
#elif defined _WIN32
#include <intrin.h>
#pragma intrinsic(_ReturnAddress)
#define chess_return_address() ((void*)_ReturnAddress())
#else /*stub*/
#define chess_return_address() ((void*)0)
#endif

#endif /*!do_not_generate_chess_return_address*/


#ifndef do_not_generate_chess_traitsof /*trouble-shooting hook*/
#ifdef __cplusplus
template <> struct chessTraitsOf<bool> {
    static const unsigned bits = 1;
};
template <> struct chessTraitsOf<char> {
    static const unsigned bits = sizeof(char) * __CHAR_BIT__; // pertinent to host, may differ from target 8;
};
template <> struct chessTraitsOf<signed char> {
    static const unsigned bits = sizeof(signed char) * __CHAR_BIT__; // pertinent to host, may differ from target 8;
};
template <> struct chessTraitsOf<unsigned char> {
    static const unsigned bits = sizeof(unsigned char) * __CHAR_BIT__; // pertinent to host, may differ from target 8;
};
template <> struct chessTraitsOf<short> {
    static const unsigned bits = sizeof(short) * __CHAR_BIT__; // pertinent to host, may differ from target 16;
};
template <> struct chessTraitsOf<unsigned short> {
    static const unsigned bits = sizeof(unsigned short) * __CHAR_BIT__; // pertinent to host, may differ from target 16;
};
template <> struct chessTraitsOf<int> {
    static const unsigned bits = sizeof(int) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
};
template <> struct chessTraitsOf<unsigned> {
    static const unsigned bits = sizeof(unsigned) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
};
template <> struct chessTraitsOf<long> {
    static const unsigned bits = sizeof(long) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
};
template <> struct chessTraitsOf<unsigned long> {
    static const unsigned bits = sizeof(unsigned long) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
};
template <> struct chessTraitsOf<long long> {
    static const unsigned bits = sizeof(long long) * __CHAR_BIT__; // pertinent to host, may differ from target 64;
};
template <> struct chessTraitsOf<unsigned long long> {
    static const unsigned bits = sizeof(unsigned long long) * __CHAR_BIT__; // pertinent to host, may differ from target 64;
};
template <> struct chessTraitsOf<float> {
    static const unsigned bits = sizeof(float) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
};
template <> struct chessTraitsOf<double> {
    static const unsigned bits = sizeof(double) * __CHAR_BIT__; // pertinent to host, may differ from target 64;
};
template <> struct chessTraitsOf<long double> {
    static const unsigned bits = sizeof(long double) * __CHAR_BIT__; // pertinent to host, may differ from target 64;
};
//!template <> struct chessTraitsOf<void *> {
//!    static const unsigned bits = sizeof(void *) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
//!};
//!template <> struct chessTraitsOf<void chess_storage(PMb) *> {
//!    static const unsigned bits = sizeof(void chess_storage(PMb) *) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
//!};
//!template <> struct chessTraitsOf<void chess_storage(PM) *> {
//!    static const unsigned bits = sizeof(void chess_storage(PM) *) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
//!};
//!template <> struct chessTraitsOf<void chess_storage(DMb) *> {
//!    static const unsigned bits = sizeof(void chess_storage(DMb) *) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
//!};
//!template <> struct chessTraitsOf<void chess_storage(DMh) *> {
//!    static const unsigned bits = sizeof(void chess_storage(DMh) *) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
//!};
//!template <> struct chessTraitsOf<void chess_storage(DMw) *> {
//!    static const unsigned bits = sizeof(void chess_storage(DMw) *) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
//!};
//!template <> struct chessTraitsOf<void chess_storage(DMb_stat) *> {
//!    static const unsigned bits = sizeof(void chess_storage(DMb_stat) *) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
//!};
//!template <> struct chessTraitsOf<void chess_storage(DMh_stat) *> {
//!    static const unsigned bits = sizeof(void chess_storage(DMh_stat) *) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
//!};
//!template <> struct chessTraitsOf<void chess_storage(DMw_stat) *> {
//!    static const unsigned bits = sizeof(void chess_storage(DMw_stat) *) * __CHAR_BIT__; // pertinent to host, may differ from target 32;
//!};
#endif /*__cplusplus*/
#endif /*!do_not_generate_chess_traitsof*/

#ifndef do_not_generate_chess_stop_exit /*trouble-shooting hook*/
#include <stdlib.h>
#define chess_stop()  _Exit(0)
#define chess_exit(x) _Exit(x)
#endif /*!do_not_generate_chess_stop_exit*/

#ifndef do_not_generate_chess_dont_care /*trouble-shooting hook*/
#define chess_dont_care(T) chess_dont_care_<T>()
template<typename T>
T chess_dont_care_() { return T(); }
#endif /*!do_not_generate_chess_dont_care*/

#ifndef do_not_generate_chess_error_warning /*trouble-shooting hook*/
#define chess_error(msg)   chess_error_msg(__FILE__,__LINE__,msg)
#define chess_warning(msg) chess_warning_msg(__FILE__,__LINE__,msg)

inline void chess_error_msg(const char* file, int line, const char* msg) {
    chess_report_os.flush();
    chess_error_os << "ERROR in \"" << file << "\", line " << line << ": [chess_error]: " << msg << '\n';
    chess_stop();
}

inline void chess_warning_msg(const char* file, int line, const char* msg) {
    chess_report_os.flush();
    chess_error_os << "WARNING in \"" << file << "\", line " << line << ": [chess_warning]: " << msg << '\n';
}
#endif /*!do_not_generate_chess_error_warning*/

#ifdef CHESS_NATIVE_NAMESPACE
} //namespace CHESS_NATIVE_NAMESPACE
#endif

#ifdef _MSC_VER
#pragma warning(pop)
#endif
#ifdef __GNUC__
#pragma GCC diagnostic pop
#endif


#endif /*_trv32p3_cnn_chess_types_h*/
