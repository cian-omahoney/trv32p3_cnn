
#ifndef INCLUDED_CNN_C_H_
#define INCLUDED_CNN_C_H_

namespace trv32p3_cnn_primitive {

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Inline Primitive Functions
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//  inline w32 p_inl_userX (w32 a, w32 b, ...) { ... }
  inline w32 imac(w32 c, w32 a, w32 b) {
    return mac(c,a,b);
  }
  
 inline w32 iexp(w32 a) {
   return exp(a);
  }
  
  inline w32 irelu(w32 a) {
    return prelu(a);
  }
  
  inline w32 iincmac (w32 c, w32 a, w32 b, w32 a_addr_i, w32& a_addr_o, w32 b_addr_i, w32& b_addr_o) {
     return incmac(c,a,b,a_addr_i,a_addr_o,b_addr_i,b_addr_o);
  }

}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~~ Promoted Intrinsics
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

promotion int MyMAC(int, int, int) = w32 imac(w32,w32,w32);
promotion int exp(int) = w32 iexp(w32);
promotion int ReLU(int) = w32 irelu(w32);
promotion int incmac(int, int, int, int, int&, int, int&) = w32 iincmac (w32 c, w32 a, w32 b, w32 a_addr_i, w32& a_addr_o, w32 b_addr_i, w32& b_addr_o);
  
// Promote to processor primitives
//promotion int c_user1 (int,int) = w32 p_user1 (w32,32);

// Promote to inline primitives
//promotion int c_userX (int,int) = w32 p_inl_userX (w32,32);


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~~ Inline Intrinsics
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//inline int c_inl_userY (int a, int b) { ... }


#endif
