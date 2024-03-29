
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:19 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



architecture rtl of debug_controller is

  component jtag_scan_register
    generic (
      scan_reg_width_gen : natural := 16);
    port (
      jtag_trst : in std_logic;
      jtag_capture_dr_in : in std_logic;
      jtag_par_in : in std_logic_vector(scan_reg_width_gen-1 downto 0);
      jtag_shift_dr_in : in std_logic;
      jtag_si_in : in std_logic;
      jtag_tck_in : in std_logic;
      jtag_update_dr_in : in std_logic;
      jtag_par_out : out std_logic_vector(scan_reg_width_gen-1 downto 0);
      jtag_so_out : out std_logic);
  end component;

  -- configuration parameters:
  constant DBG_LDST_WATCHPOINTS             : natural := 0;
  constant DBG_RANGE_WATCHPOINTS            : natural := 0;
  constant DBG_MERGE_WATCHPOINTS_PER_MEMORY : natural := 0;
  constant DBG_REMEMBER_MEMORY_ACCESS       : natural := 0;

  -- register widths
  constant DBG_DATA_REG_WIDTH               : natural := 8;
  constant DBG_ADDR_REG_WIDTH               : natural := 32;
  constant DBG_INSTR_REG_WIDTH              : natural := 32;
  constant DBG_STATUS_REG_WIDTH             : natural := 16;
  constant DBG_CONTEXT_REG_WIDTH            : natural := 0;

  -- status register bit indices
  constant DBG_MODE_INDX                    : natural := 0;
  constant DBG_BP_HIT_INDX                  : natural := 5;
  constant DBG_BREAKIN_INDX                 : natural := 6;
  constant DBG_BREAKOUT_INDX                : natural := 7;
  constant DBG_SWBREAK_INDX                 : natural := 8;

  -- register indices
  constant DBG_DATA_REG_INDX                : std_logic_vector(1 downto 0) := "00";
  constant DBG_ADDR_REG_INDX                : std_logic_vector(1 downto 0) := "01";
  constant DBG_INSTR_REG_INDX               : std_logic_vector(1 downto 0) := "10";
  constant DBG_STATUS_REG_INDX              : std_logic_vector(1 downto 0) := "11";

  -- register opcodes                       : t_jtag_opcode_tp := "0000000rrrr"
  constant DBG_DATA_REG_INSTR               : t_jtag_opcode_tp := "00000000000";
  constant DBG_ADDR_REG_INSTR               : t_jtag_opcode_tp := "00000000001";
  constant DBG_INSTR_REG_INSTR              : t_jtag_opcode_tp := "00000000010";
  constant DBG_STATUS_REG_INSTR             : t_jtag_opcode_tp := "00000000011";
  constant DBG_CONTEXT_REG_INSTR            : t_jtag_opcode_tp := "00000000100";

  -- instruction opcodes                    : t_jtag_opcode_tp := "0000001iiii"
  constant DBG_REQUEST_INSTR                : t_jtag_opcode_tp := "00000010001";
  constant DBG_RESUME_INSTR                 : t_jtag_opcode_tp := "00000010010";
  constant DBG_RESET_INSTR                  : t_jtag_opcode_tp := "00000010011";
  constant DBG_STEP_INSTR                   : t_jtag_opcode_tp := "00000010100";
  constant DBG_EXECUTE_INSTR                : t_jtag_opcode_tp := "00000010101";
  constant DBG_STEPDI_INSTR                 : t_jtag_opcode_tp := "00000010100";

  -- breakpoint instruction opcodes         : t_jtag_opcode_tp := "000001bbbii"
  constant DBG_BP0_ENABLE_INSTR             : t_jtag_opcode_tp := "00000100000";
  constant DBG_BP0_EXPORT_INSTR             : t_jtag_opcode_tp := "00000100001";
  constant DBG_BP0_DISABLE_INSTR            : t_jtag_opcode_tp := "00000100010";
  constant DBG_BP1_ENABLE_INSTR             : t_jtag_opcode_tp := "00000100100";
  constant DBG_BP1_EXPORT_INSTR             : t_jtag_opcode_tp := "00000100101";
  constant DBG_BP1_DISABLE_INSTR            : t_jtag_opcode_tp := "00000100110";
  constant DBG_BP2_ENABLE_INSTR             : t_jtag_opcode_tp := "00000101000";
  constant DBG_BP2_EXPORT_INSTR             : t_jtag_opcode_tp := "00000101001";
  constant DBG_BP2_DISABLE_INSTR            : t_jtag_opcode_tp := "00000101010";
  constant DBG_BP3_ENABLE_INSTR             : t_jtag_opcode_tp := "00000101100";
  constant DBG_BP3_EXPORT_INSTR             : t_jtag_opcode_tp := "00000101101";
  constant DBG_BP3_DISABLE_INSTR            : t_jtag_opcode_tp := "00000101110";

  -- load/store instruction opcodes         : t_jtag_opcode_tp := "000010iiiii"
  constant DBG_PMb_LOAD_INSTR               : t_jtag_opcode_tp := "00001000000";
  constant DBG_PMb_STORE_INSTR              : t_jtag_opcode_tp := "00001000001";
  constant DBG_DMb_LOAD_INSTR               : t_jtag_opcode_tp := "00001000010";
  constant DBG_DMb_STORE_INSTR              : t_jtag_opcode_tp := "00001000011";

  -- common instructions "11111"...
  constant DBG_SYNC_REQUEST_INSTR           : t_jtag_instr_tp := "1111100000010001";
  constant DBG_SYNC_RESUME_INSTR            : t_jtag_instr_tp := "1111100000010010";
  constant DBG_SYNC_RESET_INSTR             : t_jtag_instr_tp := "1111100000010011";
  constant DBG_SYNC_STEP_INSTR              : t_jtag_instr_tp := "1111100000010100";
  constant DBG_SYNC_STEPDI_INSTR            : t_jtag_instr_tp := "1111100000010100";

  signal bp_enable : std_logic_vector(3 downto 0);
  signal bp_export : std_logic_vector(3 downto 0);
  signal bp_hits : std_logic_vector(3 downto 0);
  signal breakout : std_logic_vector(3 downto 0);
  signal core_id : t_jtag_coreid_tp;
  signal core_resume : std_logic;
  signal core_selected : std_logic;
  signal core_step : std_logic;
  signal dbg_bp0 : std_logic_vector(31 downto 0);
  signal dbg_bp0_we : std_logic;
  signal dbg_bp1 : std_logic_vector(31 downto 0);
  signal dbg_bp1_we : std_logic;
  signal dbg_bp2 : std_logic_vector(31 downto 0);
  signal dbg_bp2_we : std_logic;
  signal dbg_bp3 : std_logic_vector(31 downto 0);
  signal dbg_bp3_we : std_logic;
  signal exec_instr : std_logic;
  signal jtag_ir_id : t_jtag_coreid_tp;
  signal jtag_ir_op : t_jtag_opcode_tp;
  signal new_bp_hit : std_logic;
  signal new_breakout : std_logic;
  signal ocd_addr_pdcr : std_logic_vector(31 downto 0);
  signal ocd_addr_pdcw : std_logic_vector(31 downto 0);
  signal ocd_data_pdcr : std_logic_vector(7 downto 0);
  signal ocd_data_pdcw : std_logic_vector(7 downto 0);
  signal ocd_instr_pdcr : std_logic_vector(31 downto 0);
  signal ocd_instr_pdcw : std_logic_vector(31 downto 0);
  signal pcr : std_logic_vector(31 downto 0);
  signal reg_bp_hit : std_logic;
  signal reg_breakout : std_logic;
  signal reg_dbg_mode : std_logic;
  signal reg_swbreak : std_logic;
  signal request_instr : std_logic;
  signal reset_instr : std_logic;
  signal resume0_instr : std_logic;
  signal resume1_instr : std_logic;
  signal set_bp_hit : std_logic;
  signal set_breakout : std_logic;
  signal set_dbg_mode : std_logic;
  signal set_swbreak : std_logic;
  signal step0_instr : std_logic;
  signal step1_instr : std_logic;
  signal bp_enable_REG : std_logic_vector(3 downto 0);
  signal bp_export_REG : std_logic_vector(3 downto 0);
  signal dbg_bp0_REG : std_logic_vector(31 downto 0);
  signal dbg_bp1_REG : std_logic_vector(31 downto 0);
  signal dbg_bp2_REG : std_logic_vector(31 downto 0);
  signal dbg_bp3_REG : std_logic_vector(31 downto 0);
  signal dbg_instr_exec_REG : std_logic;
  signal dbg_status_REG : t_jtag_status_tp;
  signal reset_instr_REG : std_logic;

begin

  -- assign to outputs
  ocd_req_out <= '0' when resume0_instr = '1' or core_step = '1' else
    '1' when reg_dbg_mode = '1' or set_dbg_mode = '1' else
    '0';
  dbg_reset_out <= reset_instr_REG;
  ocd_exe_out <= exec_instr;
  dbg_set_break_out <= dbg_status_REG(DBG_BREAKOUT_INDX);

  ocd_addr_pdcw_out <= unsigned(ocd_addr_pdcw);
  ocd_data_pdcw_out <= signed(ocd_data_pdcw);
  ocd_instr_pdcw_out <= unsigned(ocd_instr_pdcw);

  pcr <= std_logic_vector(pcr_in);
  ocd_addr_pdcr <= std_logic_vector(ocd_addr_pdcr_in);
  ocd_data_pdcr <= std_logic_vector(ocd_data_pdcr_in);
  ocd_instr_pdcr <= std_logic_vector(ocd_instr_pdcr_in);

  -- core selection, local opcode selection
  jtag_ir_id <= unsigned(jtag_ireg_in(15 downto 11));
  jtag_ir_op <= jtag_ireg_in(10 downto 0);
  core_id <= to_unsigned(nid_gen, 5);
  core_selected <= '1' when jtag_ir_id = core_id else '0';

  delay_proc : process(clock, reset_ext)
  begin
    if reset_ext /= '0' then
      dbg_instr_exec_REG <= '0';
      reset_instr_REG <= '0';
    elsif clock'event and clock = '1' then
      reset_instr_REG <= reset_instr;
      if ((step0_instr or resume0_instr) and ocd_mode_in) = '1' then
        dbg_instr_exec_REG <= '1';
      elsif ocd_mode_in /= '1' then
        dbg_instr_exec_REG <= '0';
      end if;
    end if;
  end process delay_proc;

  -- select debug register (demux/mux)
  dbg_register_mux : process(core_selected,
                             jtag_ir_op,
                             pcr,
                             ocd_data_pdcr,
                             ocd_instr_pdcr,
                             dbg_status_REG,
                             dbg_data_pi_in,
                             dbg_data_we_in)
  begin
    dbg_data_po_out <= (others => '0');
    en_ocd_data_pdcw_out <= '0';
    ocd_data_pdcw <= (others => '0');
    en_ocd_addr_pdcw_out <= '0';
    ocd_addr_pdcw <= (others => '0');
    en_ocd_instr_pdcw_out <= '0';
    ocd_instr_pdcw <= (others => '0');
    if core_selected = '1' and jtag_ir_op(7 downto 4) = "0000" then
      if dbg_data_we_in = '1' then
        case jtag_ir_op(1 downto 0) is
          when DBG_DATA_REG_INDX =>
            en_ocd_data_pdcw_out <= '1';
            ocd_data_pdcw <= dbg_data_pi_in(31 downto 24);
          when DBG_ADDR_REG_INDX =>
            en_ocd_addr_pdcw_out <= '1';
            ocd_addr_pdcw <= dbg_data_pi_in;
          when DBG_INSTR_REG_INDX =>
            en_ocd_instr_pdcw_out <= '1';
            ocd_instr_pdcw <= dbg_data_pi_in;
          when others =>
            null;
        end case;
      end if;
      case jtag_ir_op(1 downto 0) is
        when DBG_DATA_REG_INDX =>
          dbg_data_po_out(7 downto 0) <= ocd_data_pdcr;
        when DBG_ADDR_REG_INDX =>
          dbg_data_po_out <= pcr;
        when DBG_INSTR_REG_INDX =>
          dbg_data_po_out <= ocd_instr_pdcr;
        when DBG_STATUS_REG_INDX =>
          dbg_data_po_out(15 downto 0) <= dbg_status_REG;
        when others =>
          null;
      end case;
    end if;
  end process dbg_register_mux;

  -- decode debug instructions
  dbg_instr_decode : process(core_selected,
                             dbg_instr_exec_in,
                             dbg_instr_exec_REG,
                             jtag_ir_op,
                             jtag_ireg_in)
  begin
    request_instr <= '0';
    resume0_instr <= '0';
    resume1_instr <= '0';
    reset_instr <= '0';
    step0_instr <= '0';
    step1_instr <= '0';
    exec_instr <= '0';
    ocd_ld_PMb_out <= false;
    ocd_st_PMb_out <= false;
    ocd_ld_DMb_out <= false;
    ocd_st_DMb_out <= false;

    if core_selected = '1' then -- local

      case jtag_ir_op is
        when DBG_REQUEST_INSTR =>
          if dbg_instr_exec_in = '1' then
            request_instr <= '1';
          end if;
        when DBG_RESUME_INSTR =>
          if dbg_instr_exec_in = '1' then
            resume0_instr <= '1';
          elsif dbg_instr_exec_REG = '1' then
            resume1_instr <= '1';
          end if;
        when DBG_RESET_INSTR =>
          if dbg_instr_exec_in = '1' then
            reset_instr <= '1';
          end if;
        when DBG_STEP_INSTR =>
          if dbg_instr_exec_in = '1' then
            step0_instr <= '1';
          elsif dbg_instr_exec_REG = '1' then
            step1_instr <= '1';
          end if;
        when DBG_EXECUTE_INSTR =>
          if dbg_instr_exec_in = '1' then
            exec_instr <= '1';
          end if;
        when DBG_PMb_LOAD_INSTR =>
          if dbg_instr_exec_in = '1' then
            ocd_ld_PMb_out <= true;
          end if;
        when DBG_PMb_STORE_INSTR =>
          if dbg_instr_exec_in = '1' then
            ocd_st_PMb_out <= true;
          end if;
        when DBG_DMb_LOAD_INSTR =>
          if dbg_instr_exec_in = '1' then
            ocd_ld_DMb_out <= true;
          end if;
        when DBG_DMb_STORE_INSTR =>
          if dbg_instr_exec_in = '1' then
            ocd_st_DMb_out <= true;
          end if;
        when others =>
          null;
      end case;

    else -- global instructions

      case jtag_ireg_in is
        when DBG_SYNC_REQUEST_INSTR =>
          if dbg_instr_exec_in = '1' then
            request_instr <= '1';
          end if;
        when DBG_SYNC_RESUME_INSTR =>
          if dbg_instr_exec_in = '1' then
            resume0_instr <= '1';
          elsif dbg_instr_exec_REG = '1' then
            resume1_instr <= '1';
          end if;
        when DBG_SYNC_RESET_INSTR =>
          if dbg_instr_exec_in = '1' then
            reset_instr <= '1';
          end if;
        when DBG_SYNC_STEP_INSTR =>
          if dbg_instr_exec_in = '1' then
            step0_instr <= '1';
          elsif dbg_instr_exec_REG = '1' then
            step1_instr <= '1';
          end if;
        when others =>
          null;
      end case;

    end if;

  end process dbg_instr_decode;

  -- single instruction step: release core from dbg mode till first instr. issue
  core_step <= step0_instr or step1_instr;

  -- force release from breakpoint
  core_resume <= resume0_instr or resume1_instr;

  -- decode breakpoint instructions
  breakpoint_decode : process(core_selected,
                              dbg_instr_exec_in,
                              jtag_ir_op,
                              bp_enable_REG,
                              bp_export_REG,
                              ocd_addr_pdcr)
  begin
    bp_enable <= bp_enable_REG;
    bp_export <= bp_export_REG;
    dbg_bp0_we <= '0';
    dbg_bp0 <= (others => '0');
    dbg_bp1_we <= '0';
    dbg_bp1 <= (others => '0');
    dbg_bp2_we <= '0';
    dbg_bp2 <= (others => '0');
    dbg_bp3_we <= '0';
    dbg_bp3 <= (others => '0');
    if core_selected = '1' and dbg_instr_exec_in = '1' then
      case jtag_ir_op is
        when DBG_RESET_INSTR =>
          bp_enable <= (others => '0');
          bp_export <= (others => '0');
        when DBG_BP0_ENABLE_INSTR =>
          dbg_bp0_we <= '1';
          bp_enable(0) <= '1';
          dbg_bp0 <= ocd_addr_pdcr;
        when DBG_BP0_EXPORT_INSTR =>
          bp_export(0) <= '1';
        when DBG_BP0_DISABLE_INSTR =>
          bp_enable(0) <= '0';
          bp_export(0) <= '0';
        when DBG_BP1_ENABLE_INSTR =>
          dbg_bp1_we <= '1';
          bp_enable(1) <= '1';
          dbg_bp1 <= ocd_addr_pdcr;
        when DBG_BP1_EXPORT_INSTR =>
          bp_export(1) <= '1';
        when DBG_BP1_DISABLE_INSTR =>
          bp_enable(1) <= '0';
          bp_export(1) <= '0';
        when DBG_BP2_ENABLE_INSTR =>
          dbg_bp2_we <= '1';
          bp_enable(2) <= '1';
          dbg_bp2 <= ocd_addr_pdcr;
        when DBG_BP2_EXPORT_INSTR =>
          bp_export(2) <= '1';
        when DBG_BP2_DISABLE_INSTR =>
          bp_enable(2) <= '0';
          bp_export(2) <= '0';
        when DBG_BP3_ENABLE_INSTR =>
          dbg_bp3_we <= '1';
          bp_enable(3) <= '1';
          dbg_bp3 <= ocd_addr_pdcr;
        when DBG_BP3_EXPORT_INSTR =>
          bp_export(3) <= '1';
        when DBG_BP3_DISABLE_INSTR =>
          bp_enable(3) <= '0';
          bp_export(3) <= '0';
        when others =>
          null;
      end case;

    end if;
  end process breakpoint_decode;

  -- update breakpoint control registers
  update_breakpoint_regs : process(clock, reset_ext)
  begin
    if reset_ext /= '0' then
      bp_enable_REG <= (others => '0');
      bp_export_REG <= (others => '0');
      dbg_bp0_REG <= (others => '0');
      dbg_bp1_REG <= (others => '0');
      dbg_bp2_REG <= (others => '0');
      dbg_bp3_REG <= (others => '0');
    elsif clock'event and clock = '1' then
      bp_enable_REG <= bp_enable;
      bp_export_REG <= bp_export;
      if dbg_bp0_we = '1' then
        dbg_bp0_REG <= dbg_bp0;
      end if;
      if dbg_bp1_we = '1' then
        dbg_bp1_REG <= dbg_bp1;
      end if;
      if dbg_bp2_we = '1' then
        dbg_bp2_REG <= dbg_bp2;
      end if;
      if dbg_bp3_we = '1' then
        dbg_bp3_REG <= dbg_bp3;
      end if;
    end if;
  end process update_breakpoint_regs;

  -- check breakpoint hit
  check_breakpoint_hit : process(pcr,
                                 dbg_bp0_REG,
                                 dbg_bp1_REG,
                                 dbg_bp2_REG,
                                 dbg_bp3_REG,
                                 reg_bp_hit,
                                 dbg_status_REG,
                                 bp_enable_REG,
                                 bp_export_REG)
  begin
    if reg_bp_hit = '1' then
      bp_hits <= dbg_status_REG(4 downto 1);
    else
      bp_hits <= (others => '0');
    end if;
    breakout <= (others => '0');
    if dbg_bp0_REG = pcr then
      bp_hits(0) <= bp_enable_REG(0);
      breakout(0) <= bp_export_REG(0);
    end if;
    if dbg_bp1_REG = pcr then
      bp_hits(1) <= bp_enable_REG(1);
      breakout(1) <= bp_export_REG(1);
    end if;
    if dbg_bp2_REG = pcr then
      bp_hits(2) <= bp_enable_REG(2);
      breakout(2) <= bp_export_REG(2);
    end if;
    if dbg_bp3_REG = pcr then
      bp_hits(3) <= bp_enable_REG(3);
      breakout(3) <= bp_export_REG(3);
    end if;
  end process check_breakpoint_hit;

  new_bp_hit <= '0' when core_resume = '1' or core_step = '1' else
    bp_hits(0) or bp_hits(1) or bp_hits(2) or bp_hits(3);

  set_bp_hit <= '0' when resume0_instr = '1' or step0_instr = '1' else
    '1' when new_bp_hit = '1' else
    reg_bp_hit;

  new_breakout <= '0' when core_resume = '1' or core_step = '1' else
    breakout(0) or breakout(1) or breakout(2) or breakout(3);

  set_breakout <= '0' when resume0_instr = '1' or step0_instr = '1' else
    '1' when new_breakout = '1' else
    reg_breakout;

  set_dbg_mode <= '0' when resume0_instr = '1' else
    '1' when request_instr = '1' or dbg_ext_break_in = '1' or new_bp_hit = '1' or ocd_swbreak_in = '1' else
    reg_dbg_mode;

  set_swbreak <= '0' when core_resume = '1' or core_step = '1' else
    '1' when ocd_swbreak_in = '1' else
    reg_swbreak;

  -- implementation of status register
  status_register : process(clock, reset_ext)
  begin
    if reset_ext /= '0' then
      dbg_status_REG <= (others => '0');
    elsif clock'event and clock = '1' then
      dbg_status_REG <= "0000000" & set_swbreak &
      set_breakout & dbg_ext_break_in &
      set_bp_hit & bp_hits & set_dbg_mode;
    end if;
  end process status_register;

  reg_dbg_mode <= dbg_status_REG(DBG_MODE_INDX);
  reg_bp_hit <= dbg_status_REG(DBG_BP_HIT_INDX);
  reg_breakout <= dbg_status_REG(DBG_BREAKOUT_INDX);
  reg_swbreak <= dbg_status_REG(DBG_SWBREAK_INDX);

end rtl;
