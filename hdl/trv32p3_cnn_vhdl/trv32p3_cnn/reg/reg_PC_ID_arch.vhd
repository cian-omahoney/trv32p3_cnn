
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:19 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



architecture rtl of reg_PC_ID is

  signal reg_val : t_addr;
  -- synopsys translate_off
  signal reg_write_log     : std_logic := '0';
  -- synopsys translate_on

begin

  -- synopsys translate_off
  p_reg_PC_ID_log : process(clock)

    procedure log_reg_PC_ID(reg_val : in t_addr) is
      variable lline : line;
      variable val_ok : boolean := true;
    begin
      write(lline, string'("PC_ID"));
      write(lline, string'(" = "));
      for j in reg_val'range loop
        if reg_val(j) /= '0' and reg_val(j) /= '1' then
          val_ok := false;
          exit;
        end if;
      end loop;
      if val_ok then
        hwrite(lline, std_logic_vector(reg_val));
      else
        write(lline, string'("X"));
      end if;
      logfile_write(lline);
    end log_reg_PC_ID;

  begin

    if reg_log_gen then
      if clock'event and clock = '0' then
        if reg_write_log = '1' then
          log_reg_PC_ID(reg_val);
        end if;
      end if;
    end if;
  end process p_reg_PC_ID_log;
  -- synopsys translate_on

  p_read_reg_PC_ID : process(reg_val)
  begin
    -- PC_ID_r_out <= (others => '0');

    -- (PC_ID_r_rd_PC_ID_ID)
    -- [alu.n:209][ctrl.n:109][ctrl.n:160]
    PC_ID_r_out <= reg_val;

  end process p_read_reg_PC_ID;

  p_write_reg_PC_ID : process(clock)
  begin
    if clock'event and clock = '1' then
      -- synopsys translate_off
      reg_write_log <= '0';
      -- synopsys translate_on

      -- (PC_ID_wr_PC_ID_w_PC_ID_PC_ID_w_cntrl_issue_pdg_en)
      if PC_ID_PC_ID_w_cntrl_issue_pdg_en_in = '1' then
        -- synopsys translate_off
        reg_write_log <= '1';
        -- synopsys translate_on
        reg_val <= PC_ID_w_in;
      end if;

    end if;
  end process p_write_reg_PC_ID;

end rtl;
