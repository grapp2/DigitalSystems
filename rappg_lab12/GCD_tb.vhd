
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity GCD_tb is
end GCD_tb;

architecture arch of GCD_tb is
  constant N: integer:= 8;
  constant T: time := 1000000000 ns;
  signal clk, reset: std_logic;
  signal start, done: std_logic;
  signal x, y: std_logic_vector (N-1 downto 0);
  signal gcd: std_logic_vector(N-1 downto 0);
begin
  -- instantiation of counter component
  gcd0: entity work.GCD(arch)
    generic map (N => N)
    port map(
      i_clk => clk, i_res => reset, i_start => start,
      i_x => x, i_y => y, o_gcd => gcd, o_done => done
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
    for i in 1 to 10 loop
      wait until rising_edge(clk);
    end loop;
    
    x <= std_logic_vector(to_unsigned(199,8));
    y <= std_logic_vector(to_unsigned(251,8));
    wait until falling_edge(clk);
    start <= '1';
    wait until falling_edge(clk);
    start <= '0';
    for i in 1 to 15 loop
      wait until rising_edge(clk);
    end loop;
    
    x <= std_logic_vector(to_unsigned(0,8));
    y <= std_logic_vector(to_unsigned(88,8));
    wait until falling_edge(clk);
    start <= '1';
    wait until falling_edge(clk);
    start <= '0';
    for i in 1 to 20 loop
      wait until rising_edge(clk);
    end loop;
    
    wait for 4*T;
    assert false
      report "Simulation Completed"
      severity failure;
  end process;
end arch;
