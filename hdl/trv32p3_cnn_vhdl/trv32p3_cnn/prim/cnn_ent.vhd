
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:19 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library trv32p3_cnn_lib;
use trv32p3_cnn_lib.data_types.all;
use trv32p3_cnn_lib.primitives.all;

-- entity cnn : cnn
entity cnn is
  port (
    ohe_selector_EX : in std_logic;
    xuA_in : in t_w32;
    xuB_in : in t_w32;
    xuC_in : in t_w32;
    cnn_R_out : out t_w32);
end cnn;
