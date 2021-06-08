library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity NAdder is
port(
	i_a3, i_b3: std_logic_vector(2 downto 0)
);
end NAdder;
architecture arch of NAdder is
	signal o_print: std_logic_vector(3 downto 0);
	signal o_sum3: std_logic_vector(2 downto 0);
	signal o_c3: std_logic;
begin
	adder: work.gen_add_w_carry(arch)
		generic map(N=>3)
		port map(i_a => i_a3, i_b => i_b3, o_cout => o_c3, o_sum => o_sum3);
	o_print <= o_sum3 & o_c3;
	sevenSegment: work.SevenSegment(arch)
		port map(i_a => o_print);
end arch;