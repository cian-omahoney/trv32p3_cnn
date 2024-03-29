
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:19 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library trv32p3_cnn_lib;
use trv32p3_cnn_lib.data_types.all;

-- entity mux_aguB : mux_aguB
entity mux_aguB is
  port (
    bin_selector_ID : in std_logic_vector(1 downto 0);
    CTt12s_cstP20_ID_in : in t_t12s;
    CTt12s_cstP25_11_5P7_4_0_ID_in : in t_t12s;
    aguB_out : out t_w32);
end mux_aguB;
