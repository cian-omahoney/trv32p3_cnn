
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:19 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library trv32p3_cnn_lib;
use trv32p3_cnn_lib.data_types.all;
use trv32p3_cnn_lib.cntrl_types.all;

-- entity decoder : decoder
entity decoder is
  port (
    reset : in std_logic;
    clock : in std_logic;
    hzd_stall_in : in std_logic;
    kill_ID_in : in std_logic;
    trn_ID_valid_in : in std_logic;
    trn_IR_ID : in t_iword;
    EX_enabling_out : out t_EX_enabling;
    ID_enabling_out : out t_ID_enabling;
    X_x_r1_rad_out : out t_t5u;
    X_x_r2_rad_out : out t_t5u;
    X_x_r3_rad_out : out t_t5u;
    X_x_w2_wad_out : out t_t5u;
    issue_sig_out : out std_logic;
    reg_IR_EX_out : out t_iword;
    reg_IR_ID_out : out t_iword);
end decoder;
