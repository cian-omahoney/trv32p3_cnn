
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:39 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



architecture rtl of mux_mpyM is

begin

  p_mux_mpyM : process(bin_selector_EX)

  begin
                   -- mpyM_out <= (others => '0');

    -- (mpyM_copy0___CTt2u_cstV0_EX)
    -- [mpy.n:69]
    mpyM_out <= t_t2u'("00");

    case bin_selector_EX is
      when "01" => -- (mpyM_copy0___CTt2u_cstV2_EX)
                   -- [mpy.n:68]
        mpyM_out <= t_t2u'("10");
      when "10" => -- (mpyM_copy0___CTt2u_cstV3_EX)
                   -- [mpy.n:66][mpy.n:67]
        mpyM_out <= t_t2u'("11");
      when others =>
        null;
    end case;

  end process p_mux_mpyM;

end rtl;
