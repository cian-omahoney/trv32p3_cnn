
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:39 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



architecture rtl of mux_dmb_wr is

begin

  p_mux_dmb_wr : process(ohe_selector_EX,
                         ocd_st_DMbS3_r_in,
                         ocd_data_r_in,
                         x_r2_in)

  begin
    dmb_wr_out <= (others => '0');

    -- (dmb_wr_copy0_ocd_data_r___ocd_st_DMbS3_r_S3_alw)
    if ocd_st_DMbS3_r_in then
      -- [ocd.n:80]
      dmb_wr_out <= ocd_data_r_in;
    end if;

    if ohe_selector_EX = '1' then -- (dmb_wr_copy0_x_r2_EX)
                                  -- [ldst.n:99](regX.n:82)
      dmb_wr_out <= x_r2_in(7 downto 0);
    end if;

  end process p_mux_dmb_wr;

end rtl;
