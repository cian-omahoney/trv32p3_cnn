
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:39 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



architecture rtl of hazards is

  signal hzd_stall : std_logic;

  signal jalr_readHWraw : std_logic;
  signal read_after_divHWraw : std_logic;
  signal read_after_div_1HWraw : std_logic;
  signal write_after_divHWwaw : std_logic;
  signal div_busyHWnoDep : std_logic;
  signal div_wpHWnoDep : std_logic;
  signal agu_read_after_writeHWraw : std_logic;

begin


  hzd_stall <= '1' when jalr_readHWraw /= '0' or read_after_divHWraw /= '0' or read_after_div_1HWraw /= '0'
      or write_after_divHWwaw /= '0' or div_busyHWnoDep /= '0' or div_wpHWnoDep /= '0'
      or agu_read_after_writeHWraw /= '0' else '0';

  hzd_stall_out <= hzd_stall;

  p_hazards : process(hazards_decode_ID,
                      hazards_decode_EX,
                      Ch_t5u_EX_11_7,
                      Ch_t5u_ID_11_7,
                      Ch_t5u_ID_19_15,
                      Ch_t5u_ID_24_20,
                      div_adr_in,
                      div_bsy_in,
                      div_wnc_in)

  begin
    if  -- jalr_readHWraw1stEX and jalr_readHWraw2ndID
      ((hazards_decode_EX and hazards_decode_ID(0)) /= '0'
       and Ch_t5u_EX_11_7 = Ch_t5u_ID_19_15) then
      jalr_readHWraw <= '1'; -- ctrl.n:262
    else
      jalr_readHWraw <= '0';
    end if;

    if  -- read_after_divHWraw1stEX and read_after_divHWraw2ndID
      ((div_bsy_in and hazards_decode_ID(1)) /= '0'
       and div_adr_in = Ch_t5u_ID_19_15) then
      read_after_divHWraw <= '1'; -- div.n:93
    else
      read_after_divHWraw <= '0';
    end if;

    if  -- read_after_div_1HWraw1stEX and read_after_div_1HWraw2ndID
      ((div_bsy_in and hazards_decode_ID(2)) /= '0'
       and div_adr_in = Ch_t5u_ID_19_15)
        -- read_after_div_1HWraw1stEX and read_after_div_1HWraw2nd1ID
        or ((div_bsy_in and hazards_decode_ID(3)) /= '0'
            and div_adr_in = Ch_t5u_ID_24_20)
        -- read_after_div_1HWraw1stEX and read_after_div_1HWraw2nd2ID
        or ((div_bsy_in and hazards_decode_ID(4)) /= '0'
            and div_adr_in = Ch_t5u_ID_11_7) then
      read_after_div_1HWraw <= '1'; -- div.n:93
    else
      read_after_div_1HWraw <= '0';
    end if;

    if  -- write_after_divHWwaw1stEX and write_after_divHWwaw2ndID
      ((div_bsy_in and hazards_decode_ID(5)) /= '0'
       and div_adr_in = Ch_t5u_ID_11_7) then
      write_after_divHWwaw <= '1'; -- div.n:102
    else
      write_after_divHWwaw <= '0';
    end if;

    if  -- div_busyHWnoDep1stEX and div_busyHWnoDep2ndID
      ((div_bsy_in and hazards_decode_ID(6)) /= '0') then
      div_busyHWnoDep <= '1'; -- div.n:111
    else
      div_busyHWnoDep <= '0';
    end if;

    if  -- div_wpHWnoDep1stEX and div_wpHWnoDep2ndID
      ((div_wnc_in and hazards_decode_ID(7)) /= '0') then
      div_wpHWnoDep <= '1'; -- div.n:120
    else
      div_wpHWnoDep <= '0';
    end if;

    if  -- agu_read_after_writeHWraw1stEX and agu_read_after_writeHWraw2ndID
      ((hazards_decode_EX and hazards_decode_ID(1)) /= '0'
       and Ch_t5u_EX_11_7 = Ch_t5u_ID_19_15) then
      agu_read_after_writeHWraw <= '1'; -- ldst.n:145
    else
      agu_read_after_writeHWraw <= '0';
    end if;

  end process p_hazards;

end rtl;
