
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:39 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library trv32p3_cnn_lib;
use trv32p3_cnn_lib.data_types.all;

-- entity mux_pm_addr : mux_pm_addr
entity mux_pm_addr is
  port (
    ocd_ld_PMbEX_r_in : in boolean;
    ocd_st_PMbEX_r_in : in boolean;
    pm_ld_pdg_en_in : in std_logic;
    ocd_addr_r_in : in t_addr;
    pm_addr1_in : in t_addr;
    pm_addr_out : out t_addr);
end mux_pm_addr;
