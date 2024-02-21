
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:39 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library trv32p3_cnn_lib;
use trv32p3_cnn_lib.data_types.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-- entity tb_mem_PMb :  tb_mem_PMb
entity tb_mem_PMb is
  generic (
    PMb_addr_size_gen : positive := 23;
    PMb_data_size_gen : integer := 8;
    PMb_file_gen : string := "data.PMb";
    PMb_id_gen : integer := 0;
    PMb_size_gen : positive := 8388608;
    reg_log_gen : boolean := true);

  port (
    reset : in std_logic;
    clock : in std_logic;
    pm_addr_in : in t_addr;
    pm_ld_in : in std_logic;
    pm_st_in : in std_logic;
    pm_wr_in : in t_iword;
    pm_rd_out : out t_iword);
end tb_mem_PMb;
