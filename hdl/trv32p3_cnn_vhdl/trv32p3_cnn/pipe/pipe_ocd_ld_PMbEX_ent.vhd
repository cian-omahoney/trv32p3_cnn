
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:39 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library trv32p3_cnn_lib;
use trv32p3_cnn_lib.data_types.all;

-- entity pipe_ocd_ld_PMbEX : pipe_ocd_ld_PMbEX
entity pipe_ocd_ld_PMbEX is
  port (
    clock : in std_logic;
    ocd_ld_PMbID_w_in : in boolean;
    ocd_ld_PMbEX_r_out : out boolean);
end pipe_ocd_ld_PMbEX;
