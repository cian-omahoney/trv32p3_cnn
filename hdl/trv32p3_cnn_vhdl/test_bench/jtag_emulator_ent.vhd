
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:19 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



library ieee;
use ieee.std_logic_1164.all;


entity jtag_emulator is
  generic (
    ocd_clock_freq_gen : natural := 100;
    ocd_remember_data_select_gen : natural := 0);
  port (
    jtag_tdo_in : in std_logic;
    jtag_tck_out : out std_logic;
    jtag_tdi_out : out std_logic;
    jtag_tms_out : out std_logic;
    jtag_trst_out : out std_logic);
end jtag_emulator;
