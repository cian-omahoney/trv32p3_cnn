
// File generated by noodle version U-2022.12#33f3808fcb#221128, Fri Mar 15 19:34:14 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -ps -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__checkers__ trv32p3_cnn

#ifdef __chess__
#error "generated native file not intended for compilation by chess"
#endif

// Primitive types and functions
// used in Checkers ISS and PDG (and possibly native)

#ifndef _trv32p3_cnn_iss_types_h
#define _trv32p3_cnn_iss_types_h

#include "chess.h"
#include "vbit.h"

#ifndef VBITzCONSTEXPR /*trouble-shooting hook -- additional isolation layer*/
#define VBITzCONSTEXPR VBIT_CONSTEXPR
#endif

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

namespace trv32p3_cnn_primitive {

//  Primitive types (declarations)

class w08;              // property(  8 bit   signed );
class w16;              // property( 16 bit   signed );
class w32;              // property( 32 bit   signed );
class u08;              // property(  8 bit unsigned );
class addr;             // property( 32 bit unsigned );
class iword;            // property( 32 bit unsigned );
class t1u;              // property(  1 bit unsigned );
class t2u;              // property(  2 bit unsigned );
class t5u;              // property(  5 bit unsigned );
class t6u;              // property(  6 bit unsigned );
class t8u;              // property(  8 bit unsigned );
class t12s;             // property( 12 bit   signed );
class t5unz;            // property(  5 bit unsigned min=1 );
class t13s_s2;          // property( 13 bit   signed step=2 max=4094 );
class t20s_rp12;        // property( 20 bit   signed );
class t21s_s2;          // property( 21 bit   signed step=2 max=1048574 );
class t31s_rp1;         // property( 31 bit   signed );
class w64;              // property( 64 bit   signed );
class v22w32;           // property( vector w32[22] );


//  Primitive types (definitions)

class w08
{
public:
    typedef VBit<8, true> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    w08() = default;
    VBIT_CONSTEXPR w08(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR w08(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR w08(const VBit<B, S>& a) : val(a) {}
    w08(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> w08(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR w08(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const w08& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, w08& x) { is >> x.val; return is; }
public:
    VBITzCONSTEXPR w08(w32);
};
inline const w08::BitType& toBitType(const w08& v) { return v.val; }

class w16
{
public:
    typedef VBit<16, true> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    w16() = default;
    VBIT_CONSTEXPR w16(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR w16(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR w16(const VBit<B, S>& a) : val(a) {}
    w16(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> w16(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR w16(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const w16& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, w16& x) { is >> x.val; return is; }
public:
    VBITzCONSTEXPR w16(w32);
};
inline const w16::BitType& toBitType(const w16& v) { return v.val; }

class w32
{
public:
    typedef VBit<32, true> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    w32() = default;
    VBIT_CONSTEXPR w32(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR w32(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR w32(const VBit<B, S>& a) : val(a) {}
    w32(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> w32(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR w32(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const w32& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, w32& x) { is >> x.val; return is; }
public:
    VBITzCONSTEXPR w32(t5u);
    VBITzCONSTEXPR w32(t12s);
    VBITzCONSTEXPR w32(t20s_rp12);
    VBITzCONSTEXPR w32(addr);
    VBITzCONSTEXPR w32(t21s_s2);
    VBITzCONSTEXPR w32(t13s_s2);
    VBITzCONSTEXPR w32(t31s_rp1);
};
inline const w32::BitType& toBitType(const w32& v) { return v.val; }

class u08
{
public:
    typedef VBit<8, false> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    u08() = default;
    VBIT_CONSTEXPR u08(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR u08(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR u08(const VBit<B, S>& a) : val(a) {}
    u08(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> u08(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR u08(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const u08& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, u08& x) { is >> x.val; return is; }
public:
};
inline const u08::BitType& toBitType(const u08& v) { return v.val; }

class addr
{
public:
    typedef VBit<32, false> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    addr() = default;
    VBIT_CONSTEXPR addr(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR addr(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR addr(const VBit<B, S>& a) : val(a) {}
    addr(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> addr(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR addr(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const addr& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, addr& x) { is >> x.val; return is; }
public:
    VBITzCONSTEXPR addr(w32);
};
inline const addr::BitType& toBitType(const addr& v) { return v.val; }

class iword
{
public:
    typedef VBit<32, false> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    iword() = default;
    VBIT_CONSTEXPR iword(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR iword(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR iword(const VBit<B, S>& a) : val(a) {}
    iword(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> iword(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR iword(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const iword& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, iword& x) { is >> x.val; return is; }
public:
};
inline const iword::BitType& toBitType(const iword& v) { return v.val; }

class t1u
{
public:
    typedef VBit<1, false> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    t1u() = default;
    VBIT_CONSTEXPR t1u(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR t1u(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR t1u(const VBit<B, S>& a) : val(a) {}
    t1u(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> t1u(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR t1u(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const t1u& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, t1u& x) { is >> x.val; return is; }
public:
};
inline const t1u::BitType& toBitType(const t1u& v) { return v.val; }

class t2u
{
public:
    typedef VBit<2, false> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    t2u() = default;
    VBIT_CONSTEXPR t2u(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR t2u(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR t2u(const VBit<B, S>& a) : val(a) {}
    t2u(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> t2u(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR t2u(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const t2u& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, t2u& x) { is >> x.val; return is; }
public:
};
inline const t2u::BitType& toBitType(const t2u& v) { return v.val; }

class t5u
{
public:
    typedef VBit<5, false> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    t5u() = default;
    VBIT_CONSTEXPR t5u(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR t5u(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR t5u(const VBit<B, S>& a) : val(a) {}
    t5u(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> t5u(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR t5u(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const t5u& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, t5u& x) { is >> x.val; return is; }
public:
};
inline const t5u::BitType& toBitType(const t5u& v) { return v.val; }

class t6u
{
public:
    typedef VBit<6, false> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    t6u() = default;
    VBIT_CONSTEXPR t6u(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR t6u(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR t6u(const VBit<B, S>& a) : val(a) {}
    t6u(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> t6u(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR t6u(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const t6u& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, t6u& x) { is >> x.val; return is; }
public:
};
inline const t6u::BitType& toBitType(const t6u& v) { return v.val; }

class t8u
{
public:
    typedef VBit<8, false> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    t8u() = default;
    VBIT_CONSTEXPR t8u(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR t8u(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR t8u(const VBit<B, S>& a) : val(a) {}
    t8u(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> t8u(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR t8u(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const t8u& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, t8u& x) { is >> x.val; return is; }
public:
};
inline const t8u::BitType& toBitType(const t8u& v) { return v.val; }

class t12s
{
public:
    typedef VBit<12, true> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    t12s() = default;
    VBIT_CONSTEXPR t12s(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR t12s(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR t12s(const VBit<B, S>& a) : val(a) {}
    t12s(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> t12s(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR t12s(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const t12s& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, t12s& x) { is >> x.val; return is; }
public:
};
inline const t12s::BitType& toBitType(const t12s& v) { return v.val; }

class t5unz
{
public:
    typedef VBit<5, false> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    t5unz() = default;
    VBIT_CONSTEXPR t5unz(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR t5unz(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR t5unz(const VBit<B, S>& a) : val(a) {}
    t5unz(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> t5unz(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR t5unz(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const t5unz& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, t5unz& x) { is >> x.val; return is; }
public:
};
inline const t5unz::BitType& toBitType(const t5unz& v) { return v.val; }

class t13s_s2
{
public:
    typedef VBit<13, true> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    t13s_s2() = default;
    VBIT_CONSTEXPR t13s_s2(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR t13s_s2(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR t13s_s2(const VBit<B, S>& a) : val(a) {}
    t13s_s2(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> t13s_s2(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR t13s_s2(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const t13s_s2& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, t13s_s2& x) { is >> x.val; return is; }
public:
};
inline const t13s_s2::BitType& toBitType(const t13s_s2& v) { return v.val; }

class t20s_rp12
{
public:
    typedef VBit<20, true> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    t20s_rp12() = default;
    VBIT_CONSTEXPR t20s_rp12(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR t20s_rp12(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR t20s_rp12(const VBit<B, S>& a) : val(a) {}
    t20s_rp12(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> t20s_rp12(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR t20s_rp12(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const t20s_rp12& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, t20s_rp12& x) { is >> x.val; return is; }
public:
};
inline const t20s_rp12::BitType& toBitType(const t20s_rp12& v) { return v.val; }

class t21s_s2
{
public:
    typedef VBit<21, true> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    t21s_s2() = default;
    VBIT_CONSTEXPR t21s_s2(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR t21s_s2(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR t21s_s2(const VBit<B, S>& a) : val(a) {}
    t21s_s2(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> t21s_s2(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR t21s_s2(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const t21s_s2& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, t21s_s2& x) { is >> x.val; return is; }
public:
};
inline const t21s_s2::BitType& toBitType(const t21s_s2& v) { return v.val; }

class t31s_rp1
{
public:
    typedef VBit<31, true> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    t31s_rp1() = default;
    VBIT_CONSTEXPR t31s_rp1(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR t31s_rp1(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR t31s_rp1(const VBit<B, S>& a) : val(a) {}
    t31s_rp1(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> t31s_rp1(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR t31s_rp1(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const t31s_rp1& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, t31s_rp1& x) { is >> x.val; return is; }
public:
    VBITzCONSTEXPR t31s_rp1(w32);
};
inline const t31s_rp1::BitType& toBitType(const t31s_rp1& v) { return v.val; }

class w64
{
public:
    typedef VBit<64, true> BitType;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    w64() = default;
    VBIT_CONSTEXPR w64(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR w64(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <int B, bool S> VBIT_CONSTEXPR w64(const VBit<B, S>& a) : val(a) {}
    w64(const VBitWrapper& a) : val(a) {}
    template <typename DataType, int E> w64(const VBitVector<DataType, E>& a) : val(a) {}
public:
    // backwards compatibility api
    VBIT_CONSTEXPR w64(BitType::ValueType a) : val(a) {}
    BitType::ValueType& value(){ return val.value(); }
    const BitType::ValueType& value() const{ return val.value(); }
    void value(const BitType::ValueType& v){ val.value(v); }
    BitType::UBaseType to_unsigned() const{ return val.to_unsigned(); }
    BitType::SBaseType to_signed() const{ return val.to_signed(); }
    friend std::ostream& operator<<(std::ostream& os, const w64& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, w64& x) { is >> x.val; return is; }
public:
};
inline const w64::BitType& toBitType(const w64& v) { return v.val; }

class v22w32
{
public:
    typedef VBitVector<w32, 22> BitType;
    typedef BitType::handle handle;
    static const int bits = BitType::bits;
    static const bool isSigned = BitType::isSigned;
    BitType val;
public:
    v22w32() = default;
    VBIT_CONSTEXPR v22w32(VBitInitializeTag tg) : val(tg) {} // Deprecated, prefer VBitZeroInitializeTag
    VBIT_CONSTEXPR v22w32(VBitZeroInitializeTag tg) : val(tg) {}
    void initialize() { val.initialize(); }
    template <typename DataType, int E> v22w32(const VBitVector<DataType, E>& a) : val(a) {}
    v22w32(const VBitWrapper& a) : val(a) {}
    template <int B, bool S> v22w32(const VBit<B, S>& a) : val(a) {}
    // backwards compatibility api
    w32& elem(int i) { return val.elem(i); }
    const w32& elem(int i) const { return val.elem(i); }
    void elem(int i, const w32& a) { val.elem(i, a); }
    handle value() { return val.value(); }
    handle value() const { return val.value(); }
    //v22w32(const unsigned long long* a) : val(a) {}
    //v22w32(const long long* a) : val(a) {}
    //void value(const unsigned long long* a) { val.value(a); }
    //void value(const long long* a) { val.value(a); }
    void to_unsigned(unsigned long long* dst) const { val.to_unsigned(dst); }
    void to_signed(long long* dst) const { val.to_signed(dst); }
    friend std::ostream& operator<<(std::ostream& os, const v22w32& x) { os << x.val; return os; }
    friend std::istream& operator>>(std::istream& is, v22w32& x) { is >> x.val; return is; }
    w32& getElement(int i) { return elem(i); }
    const w32& getElement(int i) const { return elem(i); }
    void putElement(const w32& a, int i) { elem(i, a); }
public:
};
inline const v22w32::BitType& toBitType(const v22w32& v) { return v.val; }


//  Conversions

inline VBITzCONSTEXPR w08::w08(w32 a)   : val(toVBit(a)) {}

inline VBITzCONSTEXPR w16::w16(w32 a)   : val(toVBit(a)) {}

inline VBITzCONSTEXPR w32::w32(t5u a)   : val(toVBit(a)) {}
inline VBITzCONSTEXPR w32::w32(t12s a)  : val(toVBit(a)) {}
inline VBITzCONSTEXPR w32::w32(t20s_rp12 a)
        : val((w32::BitType(toVBit(a)) << 12)) {}
inline VBITzCONSTEXPR w32::w32(addr a)  : val(toVBit(a)) {}
inline VBITzCONSTEXPR w32::w32(t21s_s2 a)
        : val(toVBit(a)) {}
inline VBITzCONSTEXPR w32::w32(t13s_s2 a)
        : val(toVBit(a)) {}
inline VBITzCONSTEXPR w32::w32(t31s_rp1 a)
        : val((w32::BitType(toVBit(a)) << 1)) {}

inline VBITzCONSTEXPR addr::addr(w32 a) : val(toVBit(a)) {}

inline VBITzCONSTEXPR t31s_rp1::t31s_rp1(w32 a)
        : val((toVBit(a) >> 1)) {}


//  Operations

checkers_import_export /*primitive*/ w32 add(w32, w32);
checkers_import_export /*primitive*/ w32 sub(w32, w32);
checkers_import_export /*primitive*/ w32 slt(w32, w32);
checkers_import_export /*primitive*/ w32 sltu(w32, w32);
checkers_import_export /*primitive*/ w32 seq0(w32);
checkers_import_export /*primitive*/ w32 sne0(w32);

checkers_import_export /*primitive*/ w32 band(w32, w32);
checkers_import_export /*primitive*/ w32 bor(w32, w32);
checkers_import_export /*primitive*/ w32 bxor(w32, w32);

checkers_import_export /*primitive*/ w32 sll(w32, w32);
checkers_import_export /*primitive*/ w32 srl(w32, w32);
checkers_import_export /*primitive*/ w32 sra(w32, w32);

checkers_import_export /*primitive*/ w32 mul(w32, w32);
checkers_import_export /*primitive*/ w32 mulh(w32, w32);
checkers_import_export /*primitive*/ w32 mulhsu(w32, w32);
checkers_import_export /*primitive*/ w32 mulhu(w32, w32);

checkers_import_export /*primitive*/ void mul_hw(w32, w32, t2u, w32 &, w32 &);

checkers_import_export /*primitive*/ bool eq(w32, w32);
checkers_import_export /*primitive*/ bool lt(w32, w32);
checkers_import_export /*primitive*/ bool ltu(w32, w32);
checkers_import_export /*primitive*/ bool ne(w32, w32);
checkers_import_export /*primitive*/ bool ge(w32, w32);
checkers_import_export /*primitive*/ bool geu(w32, w32);

checkers_import_export /*primitive*/ w32 sext(w08);
checkers_import_export /*primitive*/ w32 zext(w08);
checkers_import_export /*primitive*/ w32 sext(w16);
checkers_import_export /*primitive*/ w32 zext(w16);

checkers_import_export /*primitive*/ w32 divs(w32, w32);
checkers_import_export /*primitive*/ w32 rems(w32, w32);
checkers_import_export /*primitive*/ w32 divu(w32, w32);
checkers_import_export /*primitive*/ w32 remu(w32, w32);

//cntrl:  checkers_import_export /*primitive*/ w32 jal(t21s_s2);
//cntrl:  checkers_import_export /*primitive*/ w32 jalr(w32);

//cntrl:  checkers_import_export /*primitive*/ void j(t21s_s2);
//cntrl:  checkers_import_export /*primitive*/ void jr(w32);

//cntrl:  checkers_import_export /*primitive*/ void br(bool, t13s_s2);

checkers_import_export /*primitive*/ void nop();

checkers_import_export /*primitive*/ w32 zext_08(w32);

// < cnn_p.h >

checkers_import_export /*primitive*/ w32 mac(w32, w32, w32);
checkers_import_export /*primitive*/ w32 exp(w32);


} //namespace trv32p3_cnn_primitive


#ifndef __chess_traits_templates__
#define __chess_traits_templates__
#ifdef __cplusplus /*native or SystemC*/
template <class T> struct chessRemoveCVq                   { typedef T type; };
template <class T> struct chessRemoveCVq<const T>          { typedef T type; };
#ifndef volatile //old hack in chess.h
template <class T> struct chessRemoveCVq<volatile T>       { typedef T type; };
template <class T> struct chessRemoveCVq<const volatile T> { typedef T type; };
#endif
template <class T> struct chessRemoveRef                   { typedef T type; };
template <class T> struct chessRemoveRef<T&>               { typedef T type; };
template <class T> struct chessRemoveRef<T&&>              { typedef T type; };

template<typename T> struct chessTraitsOf;  // generated for each fundamental type

// chess_bitsof and chess_elementsof are sizeof-like operators that can be called
// either with a type or an expression argument (type checked only, never executed);
struct chessTraitsOfHelper {
    chessTraitsOfHelper();
    template<typename T> explicit operator T() const volatile; // convertible to any type
};
chessTraitsOfHelper operator+(chessTraitsOfHelper); // unary
template<typename T> T operator+(T, chessTraitsOfHelper); // binary
// x can be a type, so (x) is a cast of unary + on the helper; or
// x can be an expression, with type preserving binary + of the helper.
#define chess_bitsof(x)     chessTraitsOf<typename chessRemoveCVq<typename chessRemoveRef<decltype((x)+chessTraitsOfHelper())>::type>::type>::bits
#define chess_elementsof(x) chessTraitsOf<typename chessRemoveCVq<typename chessRemoveRef<decltype((x)+chessTraitsOfHelper())>::type>::type>::elems

#endif //__cplusplus
#endif /*__chess_traits_templates__*/

#ifndef do_not_generate_chess_traitsof /*trouble-shooting hook*/
#ifdef __cplusplus
template <> struct chessTraitsOf<trv32p3_cnn_primitive::w08> {
    static const unsigned bits = 8;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::w16> {
    static const unsigned bits = 16;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::w32> {
    static const unsigned bits = 32;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::u08> {
    static const unsigned bits = 8;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::addr> {
    static const unsigned bits = 32;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::iword> {
    static const unsigned bits = 32;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::t1u> {
    static const unsigned bits = 1;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::t2u> {
    static const unsigned bits = 2;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::t5u> {
    static const unsigned bits = 5;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::t6u> {
    static const unsigned bits = 6;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::t8u> {
    static const unsigned bits = 8;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::t12s> {
    static const unsigned bits = 12;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::t5unz> {
    static const unsigned bits = 5;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::t13s_s2> {
    static const unsigned bits = 13;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::t20s_rp12> {
    static const unsigned bits = 20;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::t21s_s2> {
    static const unsigned bits = 21;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::t31s_rp1> {
    static const unsigned bits = 31;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::w64> {
    static const unsigned bits = 64;
};
template <> struct chessTraitsOf<trv32p3_cnn_primitive::v22w32> {
    static const unsigned bits = 704;
    static const unsigned elems = 22;
};
#endif //__cplusplus
#endif /*!do_not_generate_chess_traitsof*/


#ifdef CHESS_NATIVE_NAMESPACE
} //namespace CHESS_NATIVE_NAMESPACE
#endif

#ifdef _MSC_VER
#pragma warning(pop)
#endif
#ifdef __GNUC__
#pragma GCC diagnostic pop
#endif


#endif /*_trv32p3_cnn_iss_types_h*/
