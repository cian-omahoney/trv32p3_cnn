/*
-- File : dm.p
--
-- Contents : Definition of the trv32p3_cnn DM IO interface.
-- This IO interfaces merges the aligned access from DMb DMh DMw
--
-- Copyright (c) 2019-2022 Synopsys, Inc. This Synopsys processor model
-- captures an ASIP Designer Design Technique. The model and all associated
-- documentation are proprietary to Synopsys, Inc. and may only be used
-- pursuant to the terms and conditions of a written license agreement with
-- Synopsys, Inc.  All other use, reproduction, modification, or distribution
-- of the Synopsys processor model or the associated  documentation is
-- strictly prohibited.
*/

#include "trv32p3_cnn_define.h"

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~~ DM IO Interface
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Two chained io_interface units
//  1) merge byte/half/word accesses
//  2) write back buffer


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~~ Merge byte/half/word accesses
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// This IO Interface
// * merges the memory record aliases
// * interfaces to a single-cycle 32b wide memory with byte enables
// * supports only aligned addresses
// * has an external interface with word addresses

io_interface dm_merge (DMb) {

  // Assumption:
  // nml_side {
  //   mem DMb [SIZE,1]<w08,addr> access {
  //     dmb_ld`0`: dmb_rd`1` = DMb[dm_addr`0`]`1`;
  //     dmb_st`0`: DMb[dm_addr`0`]`1` = dmb_wr`1`;
  //   };
  //   mem DMh [SIZE,2]<w16,addr> alias DMb access {
  //     dmh_ld`0`: dmh_rd`1` = DMh[dm_addr`0`]`1`;
  //     dmh_st`0`: DMh[dm_addr`0`]`1` = dmh_wr`1`;
  //   };
  //   mem DMw [SIZE,4]<w32,addr> alias DMb access {
  //     dmw_ld`0`: dmw_rd`1` = DMw[dm_addr`0`]`1`;
  //     dmw_st`0`: DMw[dm_addr`0`]`1` = dmw_wr`1`;
  //   };
  // }

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ External Interface
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  trn wdm_st <uint4_t>; // byte write mask

  mem wDM [2**30] <v4u8,addr> access {
    wdm_ld`0`: wdm_rd`1`           = wDM[wdm_addr`0`]`1`;
    wdm_st`0`: wDM[wdm_addr`0`]`1` = wdm_wr`1`;
  };


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Local Storage
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  reg col_ff <uint2_t>; hw_init col_ff = 0;
  reg st_ff <uint3_t>;  hw_init st_ff = 0;


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Process response from memory
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  process process_result() {

    // dmb_rd, dmh_rd, dmw_rd
    u08 b0 = wdm_rd[col_ff];                    // 0, 1, 2, 3
    // dmh_rd, dmw_rd
    u08 b1 = wdm_rd[col_ff[1]::"1"];            // 1, 3

    dmw_rd = wdm_rd[3]::wdm_rd[2]::b1::b0;
    dmh_rd = b1::b0;
    dmb_rd = b0;

  }


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Process request from core
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  process process_request() {

    // split address
    addr    row = dm_addr[31:2];
    uint2_t col = dm_addr[1:0];

    // addr (read or write)
    wdm_addr = row;

    // read enable
    wdm_ld = dmw_ld | dmh_ld | dmb_ld;

    // register read info
    col_ff = col;

    // write enable
    uint4_t          t1 = "0000";
    if      (dmw_st) t1 = "1111";
    else if (dmh_st) t1 = "0011" << (col[1]::"0");
    else if (dmb_st) t1 = "0001" << (col);
    wdm_st = t1;

    // write data
    if (st_ff[2]) {
      wdm_wr = dmw_wr;
    } else if (st_ff[1]) {
      wdm_wr = dmh_wr::dmh_wr;
    } else if (st_ff[0]) {
      wdm_wr = dmb_wr::dmb_wr::dmb_wr::dmb_wr;
    }

    // delay store control
    st_ff = dmw_st :: dmh_st :: dmb_st;

  }


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ DC Synthesis embedded options
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#ifndef SYNTHESIS_NO_UNGROUP
  vlog synthesis_options() {%

    // Ungroup this design. It is in the critical path.
    %% synopsys dc_tcl_script_begin
    %% set_ungroup [current_design]
    %% synopsys dc_tcl_script_end

  %}
#endif


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Debug Access
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  void dbg_access_DMb(AddressType a, w08& val, bool read) {
    addr    row = a[31:2];
    uint2_t col = a[1:0];

    u08 v = val;
    dbg_access_wDM(row,col,v,read);
    val = v;
  }
}


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// ~~~ Writeback Buffer
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

io_interface dm_wbb (wDM) {

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ External Interface
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  trn edm_st<uint4_t>; // byte write mask

  mem eDM [2**30] <v4u8,addr> access {
    edm_ld`0`: edm_rd`1`           = eDM[edm_addr`0`]`0`;
    edm_st`0`: eDM[edm_addr`0`]`0` = edm_wr`0`;
  };


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Local Storage
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  reg edm_addr_ff <addr>;          hw_init edm_addr_ff = 0;       //delay store address
  reg edm_strb_ff <uint4_t>;       hw_init edm_strb_ff = 0;       //delay store strobe
  reg edm_st_ff <uint1_t>;         hw_init edm_st_ff = 0;         //delay store control
  reg edm_data_ff <v4u8>;          hw_init edm_data_ff = 0;       //write-back buffer
  reg edm_wbb_ff <uint1_t>;        hw_init edm_wbb_ff = 0;        //buffer contains data
  reg edm_addr_match_ff <uint1_t>; hw_init edm_addr_match_ff = 0; //load addr matches wbb


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Process response from memory
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  process process_result() {

    bool byp = (edm_wbb_ff && edm_addr_match_ff);
    uint4_t sel = edm_strb_ff & (byp::byp::byp::byp);
    wdm_rd =
        (sel[3] == 0 ? edm_rd[3] : edm_data_ff[3]) ::
        (sel[2] == 0 ? edm_rd[2] : edm_data_ff[2]) ::
        (sel[1] == 0 ? edm_rd[1] : edm_data_ff[1]) ::
        (sel[0] == 0 ? edm_rd[0] : edm_data_ff[0]);

  }


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Process request from core
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  process process_request() {

    // issue load request
    edm_ld = wdm_ld;
    if (wdm_ld) {
      edm_addr = wdm_addr;
      edm_addr_match_ff = (wdm_addr == edm_addr_ff);
    }

    // process new and pending store requests
    edm_st = 0;
    if (wdm_ld) {
      if (edm_st_ff) {
        // cannot issue store request now; buffer data instead
        edm_data_ff = wdm_wr;
        edm_wbb_ff = 1;
      }
    }
    else {
      if (edm_wbb_ff) {
        // issue pending store request
        edm_st   = edm_strb_ff;
        edm_addr = edm_addr_ff;
        edm_wr   = edm_data_ff;
        edm_wbb_ff = 0;
      }
      else if (edm_st_ff) {
        // issue store request from previous cycle
        edm_st   = edm_strb_ff;
        edm_addr = edm_addr_ff;
        edm_wr   = wdm_wr;
      }

      if (wdm_st != 0) {
        // delay new store request
        edm_addr_ff = wdm_addr;
        edm_strb_ff = wdm_st;
      }
    }
    // delay store control
    edm_st_ff = (wdm_st != 0);

  }


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ DC Synthesis embedded options
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#ifndef SYNTHESIS_NO_UNGROUP
  vlog synthesis_options() {%

    // Ungroup this design. It is in the critical path.
    %% synopsys dc_tcl_script_begin
    %% set_ungroup [current_design]
    %% synopsys dc_tcl_script_end

  %}
#endif


  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  // ~~~ Debug Access
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  void dbg_access_wDM(AddressType a, VectorIndexType elem, u08& val, bool read) {
    if (edm_wbb_ff && edm_addr_ff == a) {
      // read wbb
      v4u8 tmp_wbb;
      dbg_access_edm_data_ff(tmp_wbb,/*read*/true);
      if (!read && edm_strb_ff[elem]) {
        // update wbb
        tmp_wbb[elem] = val;
        dbg_access_edm_data_ff(tmp_wbb,/*read*/false);
      }
      // access eDM
      dbg_access_eDM(a,elem,val,read);
      // select eDM or wbb
      val = edm_strb_ff[elem] ? tmp_wbb[elem] : val;
    } else {
      // access eDM
      dbg_access_eDM(a,elem,val,read);
    }
  }
}
