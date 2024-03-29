
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:19 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library trv32p3_cnn_lib;
use trv32p3_cnn_lib.data_types.all;

-- entity controller : controller
entity controller is
  port (
    reset : in std_logic;
    clock : in std_logic;
    ohe_selector_EX : in std_logic;
    bin_selector_ID : in std_logic_vector(1 downto 0);
    cnd_in : in boolean;
    hzd_stall_in : in std_logic;
    issue_sig_in : in std_logic;
    jmp_tgt_EX_in : in t_w32;
    jmp_tgt_ID_in : in t_w32;
    ocd_exe_in : in t_t1u;
    ocd_instr_r_in : in t_iword;
    ocd_req_in : in t_t1u;
    pcr_in : in t_addr;
    pm_rd_in : in t_iword;
    PC_ID_PC_ID_w_cntrl_issue_pdg_en_out : out std_logic;
    PC_ID_w_out : out t_addr;
    PC_pcw_cntrl_nxtpc_pdg_en_out : out std_logic;
    kill_ID_out : out std_logic;
    lnk_id_out : out t_w32;
    ocd_mode_out : out t_t1u;
    pcw_out : out t_addr;
    pm_addr_out : out t_addr;
    pm_ld_pdg_en_out : out std_logic;
    trn_ID_valid_out : out std_logic;
    trn_IR_ID_out : out t_iword);
end controller;
