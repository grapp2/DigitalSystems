
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity MasterFSM_tb is
end MasterFSM_tb;

architecture arch of MasterFSM_tb is
  constant T: time := 1000000000 ns;
  signal clk, reset: std_logic;
  signal start, done: std_logic;
  signal x, y: std_logic_vector (7 downto 0);
  signal bcd3, bcd2, bcd1, bcd0: std_logic_vector(3 downto 0);
begin
  -- instantiation of counter component
  Master0: entity work.MasterFSM(arch)
    port map(
      i_clk => clk, i_res => reset, i_start => start,
      i_x => x, i_y => y, o_bcd3 => bcd3,o_bcd2 =>bcd2,o_bcd1 =>bcd1,o_bcd0 =>bcd0
    );
  -- clock 1 s
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
    
    x <= std_logic_vector(to_unsigned(255,8));
    y <= std_logic_vector(to_unsigned(221,8));
    start <= '0';
    wait until falling_edge(clk);
    start <= '1';
    wait until falling_edge(clk);
    start <= '0';
    for i in 1 to 25 loop
      wait until rising_edge(clk);
    end loop;
    
    
    wait for 4*T;
    assert false
      report "Simulation Completed"
      severity failure;
  end process;
end arch;
