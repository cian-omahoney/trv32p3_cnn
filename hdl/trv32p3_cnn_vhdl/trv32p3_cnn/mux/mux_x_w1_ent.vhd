
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:19 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library trv32p3_cnn_lib;
use trv32p3_cnn_lib.data_types.all;

-- entity mux_x_w1 : mux_x_w1
entity mux_x_w1 is
  port (
    bin_selector_EX : in std_logic_vector(2 downto 0);
    X_x_w1_div_main_pdg_en_in : in t_uint1_t;
    CTt20s_rp12_cstP12_EX_in : in t_t20s_rp12;
    aluR_in : in t_w32;
    lxR_in : in t_w32;
    mpyH_in : in t_w32;
    mpyL_in : in t_w32;
    pidTGT_r_in : in t_w32;
    x_w11_in : in t_w32;
    x_w1_out : out t_w32);
end mux_x_w1;
