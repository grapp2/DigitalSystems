library ieee, altera;
use ieee.std_logic_1164.all;
use altera.maxplus2.all;
entity Stopwatch2 is
	port(
		i_clr,i_stopstart,i_clk: in std_logic;
		o_q0, o_q1: out std_logic_vector (6 downto 0);
		o_dp: out std_logic
	);
end Stopwatch2;
architecture arch of Stopwatch2 is
	signal clk10hz, buffedclk, qtff, co: std_logic;
	signal n0,n1: std_logic_vector (3 downto 0);
	component clk_div
		port(
			clock_50Mhz: in std_logic;
			clock_10hz: out std_logic
		);
	end component;
	component SevenSegment
		port(
			i_a: in std_logic_vector (3 downto 0);
			o_d: out std_logic_vector (6 downto 0)
		);
	end component;
	component mod10
		port(
			i_clk, i_clr, i_en: in std_logic;
			o_rco: out std_logic;
			o_q: out std_logic_vector(3 downto 0)
		);
	end component;
	component tff
		port(
			t,clrn,clk: in std_logic;
			q: out std_logic
		);
	end component;
	component global
		port(
			a_in: in std_logic;
			a_out: out std_logic
		);
	end component;
begin
	o_dp <= '0';
	clkdiv: clk_div port map(clock_50Mhz => i_clk, clock_10hz => clk10Hz);
	buff: global port map(a_in => clk10Hz, a_out => buffedclk);
	tff0: tff port map(t => '1', clk => i_stopstart, clrn => i_clr, q => qtff);
	mod0: mod10 port map(i_clk => buffedclk, i_clr => not(i_clr), i_en => qtff, o_q => n0, o_rco => co);
	mod1: mod10 port map(i_clk => buffedclk, i_clr => not(i_clr), i_en => co, o_q => n1);
	sevenseg0: SevenSegment port map(i_a => n0, o_d => o_q0);
	sevenseg1: SevenSegment port map(i_a => n1, o_d => o_q1);
end arch;