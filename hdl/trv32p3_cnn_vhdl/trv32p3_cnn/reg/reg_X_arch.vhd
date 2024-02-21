
-- File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 13:01:39 2024
-- Copyright 2014-2022 Synopsys, Inc. All rights reserved.
-- go -I../lib -F -DIS_VHDL -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -VHDL -otrv32p3_cnn_vhdl -cgo_options.cfg -Itrv32p3_cnn_vhdl/tmp_pdg -updg -updg_controller trv32p3_cnn



architecture rtl of reg_X is

  signal reg_val : t_w32_array(0 to 31);
  -- synopsys translate_off
  signal reg_write_log     : std_logic_vector(0 to 31) := (others => '0');
  -- synopsys translate_on

begin

  -- synopsys translate_off
  p_reg_X_log : process(clock)

    procedure log_reg_X(addr : in integer; reg_val : in t_w32_array(0 to 31)) is
      variable lline : line;
      variable val_ok : boolean := true;
    begin
      write(lline, string'("X"));
      write(lline, string'("["));
      write(lline, addr);
      write(lline, string'("]"));
      write(lline, string'(" = "));
      for j in reg_val(addr)'range loop
        if reg_val(addr)(j) /= '0' and reg_val(addr)(j) /= '1' then
          val_ok := false;
          exit;
        end if;
      end loop;
      if val_ok then
        hwrite(lline, std_logic_vector(reg_val(addr)));
      else
        write(lline, string'("X"));
      end if;
      logfile_write(lline);
    end log_reg_X;

  begin

    if clock'event and clock = '0' then
      if reg_log_gen then
        for k in reg_val'range loop
          if reg_write_log(k) = '1' then
            log_reg_X(k, reg_val);
          end if;
        end loop;
      end if;
    end if;
  end process p_reg_X_log;
  -- synopsys translate_on

  p_read_reg_X : process(reg_val,
                         X_x_r1_raddr_in,
                         X_x_r2_raddr_in,
                         X_x_r3_raddr_in)
  begin
    -- x_r1_out <= (others => '0');
    -- x_r2_out <= (others => '0');
    -- x_r3_out <= (others => '0');

    -- (x_r1_rd_X___X_x_r1_rad_EX)
    -- [alu.n:69][alu.n:131][alu.n:167][mpy.n:61][div.n:58][ctrl.n:94][cnn.n:26](regX.n:75)(regX.n:121)
    x_r1_out <= reg_val(to_integer(X_x_r1_raddr_in));

    -- (x_r2_rd_X___X_x_r2_rad_EX)
    -- [alu.n:70][mpy.n:62][div.n:59][ldst.n:99][ldst.n:100][ldst.n:101][ctrl.n:95][cnn.n:27](regX.n:82)(regX.n:114)
    x_r2_out <= reg_val(to_integer(X_x_r2_raddr_in));

    -- (x_r3_rd_X___X_x_r3_rad_EX)
    -- [cnn.n:28][ldst.n:54][ldst.n:91][ctrl.n:189](regX.n:107)(regX.n:89)
    x_r3_out <= reg_val(to_integer(X_x_r3_raddr_in));

  end process p_read_reg_X;

  p_write_reg_X : process(clock, reset)
  begin
    if reset /= '0' then
      -- synopsys translate_off
      reg_write_log <= (others => '0');
      -- synopsys translate_on
      reg_val <= (others => to_signed(0, t_w32'length));
    elsif clock'event and clock = '1' then
      -- synopsys translate_off
      reg_write_log <= (others => '0');
      -- synopsys translate_on

      -- (X_wr_x_w1_X_x_w1_div_main_pdg_w_a_X_x_w1_div_main_pdg_en)
      if X_x_w1_div_main_pdg_en_in = '1' then
        -- synopsys translate_off
        reg_write_log(to_integer(X_x_w1_wad_in)) <= '1';
        -- synopsys translate_on
        reg_val(to_integer(X_x_w1_wad_in)) <= x_w1_in;
      end if;

      case bin_selector_EX is
        when "01" => -- (X_wr_x_w1___X_x_w1_wad_EX)
                     -- [regX.n:99]
                     -- synopsys translate_off
          reg_write_log(to_integer(X_x_w1_wad_in)) <= '1';
                     -- synopsys translate_on
          reg_val(to_integer(X_x_w1_wad_in)) <= x_w1_in;
        when "10" => -- (X_wr_x_w2___X_x_w2_wad_EX)
                     -- [cnn.n:36](regX.n:107)
                     -- synopsys translate_off
          reg_write_log(to_integer(X_x_w2_waddr_in)) <= '1';
                     -- synopsys translate_on
          reg_val(to_integer(X_x_w2_waddr_in)) <= x_w2_in;
        when others =>
          null;
      end case;

    end if;
  end process p_write_reg_X;

end rtl;
