
// File generated by noodle version U-2022.12#33f3808fcb#221128, Thu Jan 25 15:52:17 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3

#ifdef __chess__
#error "generated native file not intended for compilation by chess"
#endif

// Native equivalent of Chess promoted operations

#include "trv32p3_iss_types.h"
#include "trv32p3_chess_types.h"
#include "trv32p3_inline_primitives.h"
#include "trv32p3_chess_opns.h"

#ifndef CHESS_NATIVE_LINKAGE
#define CHESS_NATIVE_LINKAGE
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

CHESS_NATIVE_LINKAGE int mulh(int a0, int a1)
{
    trv32p3_primitive::w32 p0 = a0;
    trv32p3_primitive::w32 p1 = a1;
    trv32p3_primitive::w32 t = trv32p3_primitive::mulh(p0, p1);
    int r; r = toVBit(t).value();
    return r;
}

CHESS_NATIVE_LINKAGE unsigned mulh(unsigned a0, unsigned a1)
{
    trv32p3_primitive::w32 p0 = a0;
    trv32p3_primitive::w32 p1 = a1;
    trv32p3_primitive::w32 t = trv32p3_primitive::mulhu(p0, p1);
    unsigned r; r = toVBit(t).value();
    return r;
}

CHESS_NATIVE_LINKAGE int mulh(int a0, unsigned a1)
{
    trv32p3_primitive::w32 p0 = a0;
    trv32p3_primitive::w32 p1 = a1;
    trv32p3_primitive::w32 t = trv32p3_primitive::mulhsu(p0, p1);
    int r; r = toVBit(t).value();
    return r;
}

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint to_dint_se(int i)
    {
     return dint(i,i >> 31);
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint to_dint_ze(int i)
    {
     return dint(i,0);
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE int to_int(dint w)
    {
     return w.low;
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
CHESS_NATIVE_LINKAGE unsigned add(unsigned a0, unsigned a1)
{
    w32 p0 = a0;
    w32 p1 = a1;
    w32 t = add(p0, p1);
    unsigned r; r = toVBit(t).value();
    return r;
}
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
CHESS_NATIVE_LINKAGE unsigned sub(unsigned a0, unsigned a1)
{
    w32 p0 = a0;
    w32 p1 = a1;
    w32 t = sub(p0, p1);
    unsigned r; r = toVBit(t).value();
    return r;
}
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint l_add(dint a, dint b)
    {
     dint r;
     if (chess_manifest(a.low == 0))
      {
       r.low = b.low;
       r.high = a.high + b.high;
      }
     else
      if (chess_manifest(b.low == 0))
       {
        r.low = a.low;
        r.high = a.high + b.high;
       }
      else
       {
        r.low = add(a.low,b.low);
        r.high = add(a.high,b.high);
        r.high = r.high + (r.low < a.low);
       }
     return r;
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint l_sub(dint a, dint b)
    {
     dint r;
     if (chess_manifest(b.low == 0))
      {
       r.low = a.low;
       r.high = a.high - b.high;
      }
     else
      {
       r.low = sub(a.low,b.low);
       r.high = sub(a.high,b.high);
       r.high = r.high - (a.low < b.low);
      }
     return r;
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint l_and(dint a, dint b)
    {
     return dint(a.low & b.low,a.high & b.high);
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint l_or(dint a, dint b)
    {
     return dint(a.low | b.low,a.high | b.high);
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint l_xor(dint a, dint b)
    {
     return dint(a.low ^ b.low,a.high ^ b.high);
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint l_complement(dint a)
    {
     return dint(~a.low,~a.high);
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
CHESS_NATIVE_LINKAGE unsigned mulh(int a0, int a1)
{
    w32 p0 = a0;
    w32 p1 = a1;
    w32 t = mulh(p0, p1);
    unsigned r; r = toVBit(t).value();
    return r;
}
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
CHESS_NATIVE_LINKAGE unsigned mulhu(unsigned a0, unsigned a1)
{
    w32 p0 = a0;
    w32 p1 = a1;
    w32 t = mulhu(p0, p1);
    unsigned r; r = toVBit(t).value();
    return r;
}
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
CHESS_NATIVE_LINKAGE unsigned mul(unsigned a0, unsigned a1)
{
    w32 p0 = a0;
    w32 p1 = a1;
    w32 t = mul(p0, p1);
    unsigned r; r = toVBit(t).value();
    return r;
}
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint l_mul(dint a, dint b)
    {
     unsigned p1lo = 0; unsigned p1hi = 0;
     unsigned p2lo = 0; unsigned p2hi = 0;
     unsigned p3lo = 0; unsigned p3hi = 0;
     if (!chess_manifest(a.low == 0 || b.low == 0))
      p1lo = mul(a.low,b.low);
     else
      ;
     if (!chess_manifest(a.low == 0 || b.low == 0))
      p1hi = mulhu(a.low,b.low);
     else
      ;
     if (!chess_manifest(a.high == 0 || b.low == 0))
      p2lo = mul(a.high,b.low);
     else
      ;
     if (!chess_manifest(b.high == 0 || a.low == 0))
      p3lo = mul(b.high,a.low);
     else
      ;
     return dint(p1lo,p1hi + p2lo + p3lo);
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint l_mul(int a, int b)
    {
     return dint(mul(a,b),mulh(a,b));
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
CHESS_NATIVE_LINKAGE long long lmul(int a0, int a1)
{
    int p0 = a0;
    int p1 = a1;
    trv32p3_primitive::dint t = trv32p3_primitive::l_mul(p0, p1);
    long long r; r = toVBit(t).value();
    return r;
}
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE bool l_lts(dint a, dint b)
    {
     if ((int)a.high < (int)b.high)
      return true;
     else
      if (a.high == b.high)
       return a.low < b.low;
      else
       return false;
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE bool l_les(dint a, dint b)
    {
     if (chess_manifest(a.high == 0 && a.low == 0))
      {
       return (int)b.high >= 0;
      }
     else
      ;
     if ((int)a.high < (int)b.high)
      return true;
     else
      if (a.high == b.high)
       return a.low <= b.low;
      else
       return false;
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE bool l_ltu(dint a, dint b)
    {
     if ((unsigned)a.high < (unsigned)b.high)
      return true;
     else
      if (a.high == b.high)
       return a.low < b.low;
      else
       return false;
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE bool l_leu(dint a, dint b)
    {
     if ((unsigned)a.high < (unsigned)b.high)
      return true;
     else
      if (a.high == b.high)
       return a.low <= b.low;
      else
       return false;
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE bool l_eq(dint a, dint b)
    {
     return a.high == b.high && a.low == b.low;
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE bool l_ne(dint a, dint b)
    {
     return a.high != b.high || a.low != b.low;
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint l_lsl(dint a, int f)
    {
     unsigned carries;
     dint r;
     if (f == 0)
      return a;
     else
      ;
     int ff = f - 32;
     if (ff < 0)
      {
       carries = a.low >> -ff;
       r.low = chess_dont_warn_range(a.low << f);
       r.high = chess_dont_warn_range(a.high << f) | carries;
      }
     else
      {
       carries = a.low << ff;
       r.low = 0;
       r.high = carries;
      }
     return r;
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint l_asr(dint a, int f)
    {
     unsigned carries;
     dint r;
     if (f == 0)
      return a;
     else
      ;
     int ff = f - 32;
     if (ff < 0)
      {
       carries = a.high << -ff;
       r.low = chess_dont_warn_range(a.low >> f) | carries;
       r.high = chess_dont_warn_range((int)a.high >> f);
      }
     else
      {
       carries = (int)a.high >> ff;
       r.low = carries;
       r.high = (int)a.high >> 31;
      }
     return r;
    }
} //namespace trv32p3_primitive
#endif//!

#if 0//!
namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE dint l_lsr(dint a, int f)
    {
     unsigned carries;
     dint r;
     if (f == 0)
      return a;
     else
      ;
     int ff = f - 32;
     if (ff < 0)
      {
       carries = a.high << -ff;
       r.low = chess_dont_warn_range(a.low >> f) | carries;
       r.high = chess_dont_warn_range(a.high >> f);
      }
     else
      {
       carries = a.high >> ff;
       r.low = carries;
       r.high = 0;
      }
     return r;
    }
} //namespace trv32p3_primitive
#endif//!

CHESS_NATIVE_LINKAGE int slt(int a0, int a1)
{
    trv32p3_primitive::w32 p0 = a0;
    trv32p3_primitive::w32 p1 = a1;
    trv32p3_primitive::w32 t = trv32p3_primitive::slt(p0, p1);
    int r; r = toVBit(t).value();
    return r;
}

CHESS_NATIVE_LINKAGE int slt(unsigned a0, unsigned a1)
{
    trv32p3_primitive::w32 p0 = a0;
    trv32p3_primitive::w32 p1 = a1;
    trv32p3_primitive::w32 t = trv32p3_primitive::sltu(p0, p1);
    int r; r = toVBit(t).value();
    return r;
}

CHESS_NATIVE_LINKAGE int seq0(int a0)
{
    trv32p3_primitive::w32 p0 = a0;
    trv32p3_primitive::w32 t = trv32p3_primitive::seq0(p0);
    int r; r = toVBit(t).value();
    return r;
}

CHESS_NATIVE_LINKAGE int sne0(int a0)
{
    trv32p3_primitive::w32 p0 = a0;
    trv32p3_primitive::w32 t = trv32p3_primitive::sne0(p0);
    int r; r = toVBit(t).value();
    return r;
}

//undefined void signed_div_magic(int, int &, int &, bool &) chess_property(signed_div_magic)

//undefined void unsigned_div_magic(unsigned, unsigned &, int &, bool &) chess_property(unsigned_div_magic)

namespace trv32p3_primitive {
    CHESS_NATIVE_LINKAGE w32 imac(w32 c, w32 a, w32 b)
    {
     return mac(c,a,b);
    }
} //namespace trv32p3_primitive

CHESS_NATIVE_LINKAGE int MyMAC(int a0, int a1, int a2)
{
    trv32p3_primitive::w32 p0 = a0;
    trv32p3_primitive::w32 p1 = a1;
    trv32p3_primitive::w32 p2 = a2;
    trv32p3_primitive::w32 t = trv32p3_primitive::imac(p0, p1, p2);
    int r; r = toVBit(t).value();
    return r;
}


#ifdef CHESS_NATIVE_NAMESPACE
} //namespace CHESS_NATIVE_NAMESPACE
#endif

#ifdef _MSC_VER
#pragma warning(pop)
#endif
#ifdef __GNUC__
#pragma GCC diagnostic pop
#endif

