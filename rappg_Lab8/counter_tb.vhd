
library ieee;
use ieee.std_logic_1164.all;

entity counter_tb is
end counter_tb;

architecture arch of counter_tb is
  constant N: integer:= 3;
  constant T: time := 20 ns;
  signal clk, reset: std_logic;
  signal syn_clr, load, en, up: std_logic;
  signal d: std_logic_vector (N-1 downto 0);
  signal max_tick, min_tick: std_logic;
  signal q: std_logic_vector(N-1 downto 0);
begin
  -- instantiation of counter component
  counter_unit: entity work.gen_counter(arch)
    generic map (N => N)
    port map(
      i_clk => clk, i_res => reset, i_clr => syn_clr, i_en => en, i_up => up,
      i_ld => load, i_d => d, o_max_tick => max_tick, o_min_tick => min_tick,
      o_q => q
    );
  -- clock 20 ns
  process
  begin
    clk <= '0';
    wait for T/2;
    clk <= '1';
    wait for T/2;
  end process;
  -- reset
  reset <= '1', '0' after T/2;
  process
  begin
    en <= '0';
    syn_clr <='0';
    load <= '0';
    up <= '1';
    d <= (others => '0');
    wait until falling_edge(clk);
    wait until falling_edge(clk);
    load <= '1';
    d <= "011";
    wait until falling_edge(clk);
    load <= '0';
    wait until falling_edge(clk);
    wait until falling_edge(clk);
    syn_clr <= '1';
    wait until falling_edge(clk);
    syn_clr <= '0';
    en <= '1';
    up <= '1';
    for i in 1 to 10 loop
      wait until falling_edge(clk);
    end loop;
    en <= '0';
    wait until falling_edge(clk);
    wait until falling_edge(clk);
    en <= '1';
    wait until falling_edge(clk);
    wait until falling_edge(clk);
    up <= '0';
    for i in 1 to 10 loop
      wait until falling_edge(clk);
    end loop;
    wait until q = "010";
    wait until falling_edge(clk);
    up <= '0';
    wait on min_tick;
    wait until falling_edge(clk);
    up <= '1';
    wait on min_tick;
    wait until falling_edge(clk);
    up <= '0';
    wait for 4*T; -- wait for 80 ns
    en <= '0';
    wait for 4*T;
    assert false
      report "Simulation Completed"
      severity failure;
  end process;
end arch;
