/*
-- File : trv32p3_cnn_chess.h
--
-- Contents : Chess header file for the trv32p3_cnn processor.
--
-- Copyright (c) 2019-2022 Synopsys, Inc. This Synopsys processor model
-- captures an ASIP Designer Design Technique. The model and all associated
-- documentation are proprietary to Synopsys, Inc. and may only be used
-- pursuant to the terms and conditions of a written license agreement with
-- Synopsys, Inc.  All other use, reproduction, modification, or distribution
-- of the Synopsys processor model or the associated  documentation is
-- strictly prohibited.
*/

#ifndef INCLUDED_TRV32P3_CNN_CHESS_H_
#define INCLUDED_TRV32P3_CNN_CHESS_H_

#include "trv32p3_cnn.h"

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~~ Properties of Built-in Types
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Define word length and signedness. Required for promoted types, optional for
// represented types.
class    signed char       property(  8 bit   signed );
class  unsigned char       property(  8 bit unsigned );
class    signed short      property( 16 bit   signed );
class  unsigned short      property( 16 bit unsigned );
class    signed int        property( 32 bit   signed );
class  unsigned int        property( 32 bit unsigned );
class    signed long long  property( 64 bit   signed );
class  unsigned long long  property( 64 bit unsigned );

// IEEE 754 single precision
class float       property( 32 bit ieee llvm_emulated );

// IEEE 754 double precision
class double      property( 64 bit ieee llvm_emulated );

// long double is same as double
class long double property( 64 bit ieee ); // represented by double


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~~ Dual-Int Representation of 64-bit Values
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

namespace trv32p3_cnn_primitive {
  struct dint property(keep_in_registers llvm_emulated dont_generate) {
    unsigned low;   // trv32p3_cnn is little endian hence MSBs last
    unsigned high;
    dint(unsigned l, unsigned h) : low(l),high(h) { }
  };
};

chess_properties {

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Type System
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // * signed built-in types are represented by signed primitive types
  // * unsigned short and unsigned char are promoted to signed primitive types
  // * unsigned int is represented by a signed primitive type
  // * char is signed
  // * unsigned char, unsigned short are zero extended to w32
  // * signed char, signed short are sign extended to w32
  // * signed & unsigned long long are 64b, emulated with a struct
  // * (unsigned) long is represented by (unsigned) int

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Type Promotions

  promotion w32            : transitory { addr };

  promotion w16            : strong { w32 }
                             transitory { addr }
                             exclude {
                               w32 zext(w16)
                             };

  promotion w08            : strong { w16, w32 }
                             transitory { addr }
                             exclude {
                               w32 zext(w08),
                               w32 zext(w16)
                             };

  promotion unsigned short : strong { w16, w32 }
                             transitory { addr }
                             exclude { w32 sext(w16) };

  promotion unsigned char  : strong { w08, w16, w32  }
                             transitory { addr }
                             exclude {
                               w32 sext(w08)
                               // unsigned char in w16 storage: zero extended to 16b.
                               // It can be safely sign/zero extended to w32.
                               //   w32 sext(w16)
                               //   w32 zext(w16)
                             };

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Type Representations

  // Pointers
  representation void*                : w32;

  // Integer types
  representation   signed long long   : dint;
  representation unsigned long long   : dint;
  representation   signed int         : w32;
  representation unsigned int         : w32;
  representation   signed short       : w16;
  representation   signed char        : w08;

  // Floating point types
  representation double               : dint;
  representation float                : w32;

  // Built-in types represented by other built-in types
  representation   signed long        :   signed int;
  representation unsigned long        : unsigned int;
  representation char                 : signed char;
  representation long double          : double;

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Subsumed Constants
  //
  // promote immediate types to w32. Only for non-trivial not considered by
  // cosel, e.g. with right_paddding_XX

  promotion t20s_rp12 : strong  { w32 } ...; // via lui


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ General Properties
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  default_memory         : DMb;

  // stack
  spill_memory           : DMb, DMh, DMw;
  stack_pointer          : SP;
  sp_location            : bottom;
  sp_offset_type DMb     : t12s;
  sp_offset_type DMh     : t12s;
  sp_offset_type DMw     : t12s;

  // indexed addressing: DM[reg+imm]
  pointer_index_type     : t12s;

  // absolute addresses: DM[imm]
  small_static_memory    : DMb_stat;

  // only for ISS, not debug client
  breakpoint_focus_stage : EX;

  link_register          : LR;

  reserved               : x0; // =zero
  reserved               : PC_ID, PC_EX;


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ ABI
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  argument_registers
    w08, w16, w32, unsigned short, unsigned char, bool :
    x10, x11, x12, x13, x14, x15, x16, x17;
}

#include "trv32p3_cnn_c_userext-types.h"
#include "trv32p3_cnn_c_int.h"
#include "trv32p3_cnn_c_longlong.h"
#include "trv32p3_cnn_c_setcmp.h"
#include "trv32p3_cnn_c_const.h"
#include "trv32p3_cnn_c_memfn.h"
#include "trv32p3_cnn_c_bitfield.h"
#include "trv32p3_cnn_c_float.h"
#include "trv32p3_cnn_c_double.h"
#include "trv32p3_cnn_c_divbyct.h"
#include "trv32p3_cnn_c_userext.h"
#include "cnn_c.h"



#include "trv32p3_cnn_c_rewrite.h"


#endif // INCLUDED_TRV32P3_CNN_CHESS_H_
