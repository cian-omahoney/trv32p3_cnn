
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:19 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



architecture rtl of mux_ocd_instr_w is

begin

  p_mux_ocd_instr_w : process(ocd_ld_PMbS3_r_in,
                              pm_rd_dp_in)

  begin
    ocd_instr_w_out <= (others => '0');

    -- (ocd_instr_w_copy0_pm_rd___ocd_ld_PMbS3_r_S3_alw)
    if ocd_ld_PMbS3_r_in then
      -- [ocd.n:89]
      ocd_instr_w_out <= pm_rd_dp_in;
    end if;

  end process p_mux_ocd_instr_w;

end rtl;
