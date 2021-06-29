library ieee;
use ieee.std_logic_1164.all;
entity WithSelect2Bit is
	port(
		i_a, i_b: in std_logic_vector (1 downto 0);
		o_gt, o_lt, o_eq: out std_logic
	);
end WithSelect2Bit;
architecture arch of WithSelect2Bit is
	signal in_bits: std_logic_vector (3 downto 0);
	signal out_bits: std_logic_vector (2 downto 0);
	begin
		in_bits <= i_a & i_b;
		with in_bits select
			out_bits <=	"001" when "0000"|"0101"|"1010"|"1111",
					"010" when "0001"|"0010"|"0011"|"0110"|"0111"|"1011",
					"100" when "0100"|"1000"|"1100"|"1101"|"1110"|"1001",
					"000" when others;
			o_eq <= out_bits(0);
			o_lt <= out_bits(1);
			o_gt <= out_bits(2);
	end arch;
