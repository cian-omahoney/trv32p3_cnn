
// File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 18:04:14 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



`timescale 1ns/1ps

// module hazards : hazards
module hazards
  ( input  [7:0] hazards_decode_ID,
    input        hazards_decode_EX,
    input  [4:0] Ch_t5u_EX_11_7, // t5u
    input  [4:0] Ch_t5u_ID_11_7, // t5u
    input  [4:0] Ch_t5u_ID_19_15, // t5u
    input  [4:0] Ch_t5u_ID_24_20, // t5u
    input  [4:0] div_adr_in, // t5unz
    input        div_bsy_in, // t1u
    input        div_wnc_in, // t1u
    output       hzd_stall_out
  );


  wire   hzd_stall;

  reg    jalr_readHWraw;
  reg    read_after_divHWraw;
  reg    read_after_div_1HWraw;
  reg    write_after_divHWwaw;
  reg    div_busyHWnoDep;
  reg    div_wpHWnoDep;
  reg    agu_read_after_writeHWraw;


  assign hzd_stall = jalr_readHWraw || read_after_divHWraw || read_after_div_1HWraw
      || write_after_divHWwaw || div_busyHWnoDep || div_wpHWnoDep
      || agu_read_after_writeHWraw;

  assign hzd_stall_out = hzd_stall;

  always @ (*)

  begin : p_hazards

    if (                     // jalr_readHWraw1stEX and jalr_readHWraw2ndID
         (hazards_decode_EX && hazards_decode_ID[0]
           && Ch_t5u_EX_11_7 == Ch_t5u_ID_19_15))
      jalr_readHWraw = 1'b1; // ctrl.n:262
    else
      jalr_readHWraw = 1'b0;

    if (                          // read_after_divHWraw1stEX and read_after_divHWraw2ndID
         (div_bsy_in && hazards_decode_ID[1]
           && Ch_t5u_ID_19_15 == div_adr_in))
      read_after_divHWraw = 1'b1; // div.n:93
    else
      read_after_divHWraw = 1'b0;

    if (                            // read_after_div_1HWraw1stEX and read_after_div_1HWraw2ndID
         (div_bsy_in && hazards_decode_ID[2]
           && Ch_t5u_ID_19_15 == div_adr_in)
                                    // read_after_div_1HWraw1stEX and read_after_div_1HWraw2nd1ID
      || (div_bsy_in && hazards_decode_ID[3]
           && Ch_t5u_ID_24_20 == div_adr_in)
                                    // read_after_div_1HWraw1stEX and read_after_div_1HWraw2nd2ID
      || (div_bsy_in && hazards_decode_ID[4]
           && Ch_t5u_ID_11_7 == div_adr_in))
      read_after_div_1HWraw = 1'b1; // div.n:93
    else
      read_after_div_1HWraw = 1'b0;

    if (                           // write_after_divHWwaw1stEX and write_after_divHWwaw2ndID
         (div_bsy_in && hazards_decode_ID[5]
           && Ch_t5u_ID_11_7 == div_adr_in))
      write_after_divHWwaw = 1'b1; // div.n:102
    else
      write_after_divHWwaw = 1'b0;

    if (                      // div_busyHWnoDep1stEX and div_busyHWnoDep2ndID
         (div_bsy_in && hazards_decode_ID[6]))
      div_busyHWnoDep = 1'b1; // div.n:111
    else
      div_busyHWnoDep = 1'b0;

    if (                    // div_wpHWnoDep1stEX and div_wpHWnoDep2ndID
         (div_wnc_in && hazards_decode_ID[7]))
      div_wpHWnoDep = 1'b1; // div.n:120
    else
      div_wpHWnoDep = 1'b0;

    if (                                // agu_read_after_writeHWraw1stEX and agu_read_after_writeHWraw2ndID
         (hazards_decode_EX && hazards_decode_ID[1]
           && Ch_t5u_EX_11_7 == Ch_t5u_ID_19_15))
      agu_read_after_writeHWraw = 1'b1; // ldst.n:145
    else
      agu_read_after_writeHWraw = 1'b0;

  end

endmodule
