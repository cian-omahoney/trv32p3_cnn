
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:19 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



architecture rtl of ocd_addr_incr is

begin

  p_ocd_addr_incr : process(ocd_ld_DMbEX_r_in,
                            ocd_ld_PMbEX_r_in,
                            ocd_st_DMbEX_r_in,
                            ocd_st_PMbEX_r_in,
                            ocd_addr_r_in)

  begin
    ocd_addr_w_out <= (others => '0');

    -- (ocd_addr_w_incr1_ocd_addr_r_ocd_addr_incr___ocd_ld_DMbEX_r_EX_alw, ocd_addr_w_incr1_ocd_addr_r_ocd_addr_incr___ocd_st_DMbEX_r_EX_alw, ocd_addr_w_incr4_ocd_addr_r_ocd_addr_incr___ocd_ld_PMbEX_r_EX_alw, ocd_addr_w_incr4_ocd_addr_r_ocd_addr_incr___ocd_st_PMbEX_r_EX_alw)
    if ocd_ld_DMbEX_r_in then
      -- [ocd.n:71]
      addr_incr1_addr(ocd_addr_w_out, ocd_addr_r_in);
    end if;
    if ocd_st_DMbEX_r_in then
      -- [ocd.n:78]
      addr_incr1_addr(ocd_addr_w_out, ocd_addr_r_in);
    end if;
    if ocd_ld_PMbEX_r_in then
      -- [ocd.n:87]
      addr_incr4_addr(ocd_addr_w_out, ocd_addr_r_in);
    end if;
    if ocd_st_PMbEX_r_in then
      -- [ocd.n:94]
      addr_incr4_addr(ocd_addr_w_out, ocd_addr_r_in);
    end if;

  end process p_ocd_addr_incr;

end rtl;
