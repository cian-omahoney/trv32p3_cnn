
// File generated by noodle version U-2022.12#33f3808fcb#221128, Fri Mar 22 18:32:28 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

#ifdef __chess__
#error "generated native file not intended for compilation by chess"
#endif

// Native C++ types and functions


#include "trv32p3_cnn_chess_types.h"

#ifdef __GNUC__
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wparentheses"
#endif
#ifdef _MSC_VER
#pragma warning(push)
#pragma warning(disable : 4554) // C4554: check operator precedence for possible error
#endif


#include <math.h>
#ifdef _MSC_VER
#include <float.h>
#define copysign _copysign
#endif
#ifndef CHESS_NATIVE_LINKAGE
#define CHESS_NATIVE_LINKAGE
#endif

#ifdef CHESS_NATIVE_NAMESPACE
namespace CHESS_NATIVE_NAMESPACE {
#endif



//TBD generate specific versions for known configurations
#define CHESS_NATIVE_ONEULL (unsigned long long)(1)
#define CHESS_NATIVE_ONES ~(unsigned long long)(0)
#define CHESS_NATIVE_FAIL(msg) return (std::cerr << "error: in dbl2expo: literal " << d << " : " << msg << '\n'), 0/*ERROR*/

CHESS_NATIVE_LINKAGE long long dbl2expo(double d, int bits, int sign,
                       int expo, int sexp, int layo, int mbit, int zexp)
{
    //assert(expo > 0);
    //assert(layo != 3); // ieee dealt with separately

    int lead = 0;                               // nr of leading bits
    if (layo > 100) { lead = layo - 100; layo = 1; }

    int exp;
#ifdef _MSC_VER
    unsigned long long sfcd = (unsigned long long)ldexp(frexp(copysign(d,1.0),&exp),64-1);
    sfcd <<= 1; //otherwise saturates as if signed
#else
    unsigned long long sfcd = (unsigned long long)ldexp(frexp(copysign(d,1.0),&exp),64);
#endif
    bool mbit_frac = mbit == 2 || mbit == 3;
    bool mbit_impl = mbit == 0 || mbit == 3;

    unsigned long long bpat = 0;    // bit pattern
    unsigned long long epat = 0;    // bit pattern of exponent (if any)

    // number of bits for significant value
    int m_bits = bits - expo - lead;
    if (sign == 2) m_bits -= 1;                 // separate sign bit
    if (sign == 1) m_bits -= 1;                 // treat as if separate
    if (mbit_impl) m_bits += 1;                 // implicit bit

    // significant value, shifted to fractional point
    int shift_factor = 64 - m_bits;
    if (shift_factor == 0) {
        bpat = sfcd;
    }
    else if (shift_factor > 0) {               // shift and round
        if (shift_factor < 64) {
            bpat = sfcd >> shift_factor;
        } else {
            bpat = 0;
        }
    }
    else
        CHESS_NATIVE_FAIL("out of range (negative shift factor)");

    if (bpat & ~(CHESS_NATIVE_ONES >> (64 - m_bits)))
        CHESS_NATIVE_FAIL("out of range");

    // sign of negative literals
    bool neg = std::signbit(d);

    // floating point formatting
    int e_max = 1 << (expo - (sexp ? 1 : 0));
    int e_min = (sexp ? -e_max + 1 : 0);
    int e_exp = exp;
    if (!mbit_frac) e_exp -= 1;                 // initial bit before .

    if (e_exp >= e_max)
        //TBD e_exp == e_max gives Inf or Nan numbers - allow ?
        CHESS_NATIVE_FAIL("exponent out of range");

    // denormalisation
    if (e_exp <= e_min) {
        int denorm_factor = e_min - e_exp;
        if (denorm_factor < m_bits) {
            e_exp = e_min; //+= denorm_factor;
            shift_factor += denorm_factor;
            bpat >>= denorm_factor;
            if (mbit_impl)  {
                shift_factor += 1;
                bpat >>= 1;
            }
        }
        else
            CHESS_NATIVE_FAIL("underflow");
    }
    if (shift_factor < 64) { // floating standard rounding to nearest even
        if (!(shift_factor >= 1)) { std::cerr << "dbl2expo: expected shift_factor >= 1" << std::endl; exit(5); }
        unsigned long long rbit = CHESS_NATIVE_ONEULL << (shift_factor-1);
        unsigned long long rpat = sfcd - (bpat << shift_factor);  // sub-fraction bits
        //assert(rpat == (sfcd & (CHESS_NATIVE_ONES >> (64 - shift_factor))));
        if (sfcd & rbit) {
            rpat &= ~rbit;                          // clear first fraction bit, i.e. zero if exact middle
            if (rpat || (bpat & CHESS_NATIVE_ONEULL)) { // round if not exact middle, or would be odd
                bpat += CHESS_NATIVE_ONEULL;
                unsigned long long sbit = CHESS_NATIVE_ONEULL << m_bits;
                if (e_exp == e_min && mbit_impl) sbit >>= 1;
                if (m_bits < 64 && (bpat & sbit)) {   // rescale
                    if (e_exp != e_min || !mbit_impl) bpat >>= 1; // else rounded up to implicit bit
                    e_exp += 1;
                }
            }
        }
    }
    if (mbit_impl)                              // discard implicit bit
        bpat &= ~(CHESS_NATIVE_ONEULL << (--m_bits));

    // exponent
    switch (sexp) {
    case 0:                                     // unsigned exponent
        if (e_exp < 0)
            CHESS_NATIVE_FAIL("unsigned exponent cannot hold negative value");
        else
            epat = (unsigned long long)e_exp;
        break;
    case 1:                                     // two's complement exponent
        if (sfcd == 0)
            e_exp = zexp;
        if (e_exp < -e_max) //?TBD
            CHESS_NATIVE_FAIL("two's complement exponent out of range");
        else
            epat = (unsigned long long)e_exp & (CHESS_NATIVE_ONES >> (64 - expo));
        break;
    case 2:                                     // sign magnitude exponent
        if (sfcd == 0) break; // (assuming 0.0 ==> 0x0)
        if (e_exp < -e_max) //?TBD
            CHESS_NATIVE_FAIL("sign magnitude exponent out of range");
        else if (e_exp < 0)
            epat = (unsigned long long)-e_exp | (CHESS_NATIVE_ONEULL << (expo-1));
        else
            epat = (unsigned long long)e_exp;
        break;
    case 3:                                     // biased exponent
        if (sfcd == 0) break;
        e_exp += e_max - 1;
        if (e_exp < 0) //?TBD
            CHESS_NATIVE_FAIL("biased exponent out of range");
        else
            epat = (unsigned long long)e_exp;
        break;
    }
    if (epat & (CHESS_NATIVE_ONES << expo))
        CHESS_NATIVE_FAIL("exponent out of range");
    
    // sign of negative literals (incl. negative zero)
    switch (sign) {
    case 0:                                     // unsigned
        if (neg)
            CHESS_NATIVE_FAIL("negative value for unsigned type");
        break;
    case 1:                                     // two's-complement
        if (expo) ++m_bits;                             // add sign bit
        if (neg) {
            bpat = 0 - bpat;
            if (expo) bpat &= CHESS_NATIVE_ONES >> (64 - m_bits);
            if (bpat                                    // allow underflow 
                && !(bpat & (CHESS_NATIVE_ONEULL << (m_bits-1))))    // sign overflow
                CHESS_NATIVE_FAIL("out of range");
        }
        else if (bpat == (CHESS_NATIVE_ONEULL << (m_bits-1)))        // saturate outer limit
            bpat -= CHESS_NATIVE_ONEULL;
        else if (bpat & (CHESS_NATIVE_ONEULL << (m_bits-1)))         // sign overflow
            CHESS_NATIVE_FAIL("out of range");
        break;
    case 2:                                     // sign magnitude
        if (neg) {
            unsigned long long sbit = CHESS_NATIVE_ONEULL << (bits-1);
            if (layo > 0) sbit >>= expo;
            // obvious for 2; also for 1 because bpat will be shifted back up
            bpat |= sbit;
        }
        //??TBD else -- check sign overflow ??
        break;
    }

    // combine exponent and significant value
    switch (layo) {
    case 0: // sign - exp - frac
        if (!(unsigned(m_bits) < 64)) { std::cerr << "dbl2expo layout 0: expected shift factor < 64" << std::endl; exit(5); }
        epat <<= m_bits;
        break;
    case 1: // sign - frac - exp
        if (!(unsigned(expo) < 64)) { std::cerr << "dbl2expo layout 1: expected shift factor < 64" << std::endl; exit(5); }
        bpat <<= expo;
        break;
    case 2: // exp - sign - frac
        unsigned shift = m_bits + (sign == 2 ? 1 : 0);
        if (!(shift < 64)) { std::cerr << "dbl2expo layout 2: expected shift factor < 64" << std::endl; exit(5); }
        epat <<= shift;
        break;
    }
    if (bpat & epat)
        CHESS_NATIVE_FAIL("unexpected overlap of exponent and significant value");
    bpat |= epat;
    if (lead) {
        bpat = bpat << (64 - bits + lead);
        bpat = (long long)bpat >> lead;
        bpat = bpat >> (64 - bits);
    }
    return bpat;
}

CHESS_NATIVE_LINKAGE double expo2dbl(long long val, int bits, int sign,
                int expo, int sexp, int layo, int mbit, int zexp)
{
    //assert(expo > 0);
    //assert(layo != 3); // ieee dealt with separately

    int lead = 0;                       // nr of leading bits
    if (layo > 100) { lead = layo - 100; layo = 1; }

    int fbts = bits - expo - 1;         // nr of significant fraction bits
    int fbtsx = fbts;                   //  (remember)
    if (sign != 2) fbts += 1;           //  (incorporate sign in fraction)

    int exb = 64 - expo;                // nr of extension bits w.r.t. expo
    int fxb = 64 - fbts;                // nr of extension bits w.r.t. fbts

    unsigned long long uval = val;
    long long eval = 0;
    bool neg = 0;

    switch (layo) {
    case 0:                     // sign - exp - fraction (default)
        //assert(sign == 2);
        neg = (val & (CHESS_NATIVE_ONEULL << (bits-1))) != 0;
        eval = (uval >> fbts) & (CHESS_NATIVE_ONES >> exb);
        uval = uval & (CHESS_NATIVE_ONES >> fxb);
        break;
    case 1:                     // sign - fraction - exp
        neg = (val & (CHESS_NATIVE_ONEULL << (bits-1))) != 0;
        eval = uval & (CHESS_NATIVE_ONES >> exb);
        uval = (uval >> expo) & (CHESS_NATIVE_ONES >> fxb);
        break;
    case 2:                     // exp - sign - fraction
        neg = (val & (CHESS_NATIVE_ONEULL << fbtsx)) != 0;
        eval = (val >> (fbtsx+1)) & (CHESS_NATIVE_ONES >> exb);      //sign extend > 64 bits
        uval = uval & (CHESS_NATIVE_ONES >> fxb);
        break;
    }
    switch (sign) {
    case 0:                     // fraction unsigned
        neg = false;                    // overrule
        break;
    case 1:                     // fraction signed (make positive)
        if (neg) uval = - ((long long)uval << fxb >> fxb);
        break;
    case 2:                     // fraction sign magnitude (default)
        break;
    }
    int e_exp = 0;
    bool denrm = false; //TBD OTHER CASES
    switch (sexp) {
    case 0:                     // exponent unsigned
        e_exp = (int)eval;
        break;
    case 1:                     // exponent signed
        e_exp = (int)(eval << exb >> exb);      // sign extend
        denrm = (!uval) //zero only     (TBD this should be an mbit option)
            && (e_exp == zexp);         //TBD use signed minimum
        break;
    case 2:                     // exponent sign magnitude
        e_exp = (int)(eval & (CHESS_NATIVE_ONES >> (exb+1)));
        if (eval & (CHESS_NATIVE_ONEULL << (expo-1))) e_exp = - e_exp;
        break;
    case 3:                     // exponent biased (default)
        e_exp = (int)(eval - ((CHESS_NATIVE_ONEULL << (expo-1)) - 1));
        denrm = !eval;          // assume denormalised if eval == 0
        break;
    }
    switch (mbit) {
    case 3:                     // implicit most-significant bit (fractional)
        e_exp -= 1;                     // bit after  .         (TO BE TESTED)
        // fall-through
    case 0:                     // implicit most-significant bit (default)
        if (!denrm) uval |= CHESS_NATIVE_ONEULL << fbts;
        else e_exp += 1;                // bit before .
        fbts += 1;                      // also one more bit
        break;
    case 1:                     // most-significant bit before .
        e_exp += 1;                     // bit before .
        break;
    case 2:                     // most-significant bit after .
        break;
    }
    double d = ldexp((double)(long long)uval,e_exp-fbts+1+lead);
    if (neg) d = copysign(d,-1.0);
    return d;
}

#undef CHESS_NATIVE_ONEULL
#undef CHESS_NATIVE_ONES
#undef CHESS_NATIVE_FAIL

#ifdef CHESS_NATIVE_NAMESPACE
} //namespace CHESS_NATIVE_NAMESPACE
#endif

#ifdef _MSC_VER
#pragma warning(pop)
#endif
#ifdef __GNUC__
#pragma GCC diagnostic pop
#endif

