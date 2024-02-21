
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:19 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



architecture rtl of mux_X_x_w1_wad is

begin

  p_mux_X_x_w1_wad : process(ohe_selector_EX,
                             X_x_w1_div_main_pdg_en_in,
                             CTt5u_cstP7_EX_in,
                             X_x_w1_div_main_pdg_w_a_in)

  begin
    X_x_w1_wad_out <= (others => '0');

    -- (__X_x_w1_wad_cp_X_x_w1_div_main_pdg_w_a_X_x_w1_div_main_pdg_en)
    if X_x_w1_div_main_pdg_en_in = '1' then
      X_x_w1_wad_out <= resize(X_x_w1_div_main_pdg_w_a_in, t_t5u'length);
    end if;

    if ohe_selector_EX = '1' then -- (__X_x_w1_wad_copy0___CTt5u_cstP7_EX)
                                  -- [regX.n:99]
      X_x_w1_wad_out <= CTt5u_cstP7_EX_in;
    end if;

  end process p_mux_X_x_w1_wad;

end rtl;
