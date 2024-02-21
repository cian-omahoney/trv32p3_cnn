
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:39 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



architecture rtl of mux_aguB is

begin

  p_mux_aguB : process(bin_selector_ID,
                       CTt12s_cstP20_ID_in,
                       CTt12s_cstP25_11_5P7_4_0_ID_in)

  begin
    aguB_out <= (others => '0');

    case bin_selector_ID is
      when "01" => -- (aguB_copy0___CTt12s_cstP20_ID)
                   -- [ldst.n:55]
        aguB_out <= resize(CTt12s_cstP20_ID_in, t_w32'length);
      when "10" => -- (aguB_copy0___CTt12s_cstP25_11_5P7_4_0_ID)
                   -- [ldst.n:92]
        aguB_out <= resize(CTt12s_cstP25_11_5P7_4_0_ID_in, t_w32'length);
      when others =>
        null;
    end case;

  end process p_mux_aguB;

end rtl;
