library ieee, altera;
use ieee.std_logic_1164.all;
use altera.maxplus2.all;
entity StopwatchNewVHDL is
	port(
		i_clr,i_stopstart,i_clk: in std_logic;
		o_q0, o_q1: out std_logic_vector (6 downto 0);
		o_dp: out std_logic
	);
end StopwatchNewVHDL;
architecture arch of StopwatchNewVHDL is
	signal clk10hz, buffedclk, qtff, co: std_logic;
	signal n0,n1: std_logic_vector (3 downto 0);
begin
	o_dp <= '0';
	clkdiv: entity work.clk_div(a) port map(clock_50Mhz => i_clk, clock_10hz => clk10Hz);
	buff: component global port map(a_in => clk10Hz, a_out => buffedclk);
	tff0: component tff port map(t => '1', clk => i_stopstart, clrn => i_clr, q => qtff, prn => '1');
	mod0: entity work.mod10(arch) port map(i_clk => buffedclk, i_clr => not(i_clr), i_en => qtff, o_q => n0, o_rco => co, i_ld => '0',i_d => "0000");
	mod1: entity work.mod10(arch) port map(i_clk => buffedclk, i_clr => not(i_clr), i_en => co, o_q => n1,i_ld => '0',i_d => "0000");
	sevenseg0: entity work.SevenSegment(arch) port map(i_a => n0, o_d => o_q0);
	sevenseg1: entity work.SevenSegment(arch) port map(i_a => n1, o_d => o_q1);
end arch;