
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:19 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library trv32p3_cnn_lib;
use trv32p3_cnn_lib.data_types.all;
-- synopsys translate_off
use std.textio.all;
use ieee.std_logic_textio.all;
-- synopsys translate_on

-- entity reg_ocd_data : reg_ocd_data
entity reg_ocd_data is
  -- synopsys translate_off
  generic (
    reg_log_gen : boolean := true);
  -- synopsys translate_on

  port (
    reset : in std_logic;
    clock : in std_logic;
    en_ocd_data_pdcw_in : in std_logic;
    ocd_ld_DMbS3_r_in : in boolean;
    ocd_data_pdcw_in : in t_w08;
    ocd_data_w_in : in t_w08;
    ocd_data_pdcr_out : out t_w08;
    ocd_data_r_out : out t_w08);
end reg_ocd_data;
