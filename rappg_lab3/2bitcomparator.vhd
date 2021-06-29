library ieee;
use ieee.std_logic_1164.all;
entity Case2Bit is
	port(
		i_a, i_b: in std_logic_vector (1 downto 0);
		o_gt, o_lt, o_eq: out std_logic
	);
end Case2Bit;
architecture arch of Case2Bit is
	signal in_bits: std_logic_vector (3 downto 0);
	begin
		in_bits <= i_a & i_b;
		process(i_a,i_b)
		begin
		case in_bits is
			when "0000"|"0101"|"1010"|"1111"=>
				o_eq <= '1';
				o_lt <= '0';
				o_gt <= '0';
			when "0001"|"0010"|"0011"|"0110"|"0111"|"1011" =>
				o_lt <= '1';
				o_gt <= '0';
				o_eq <= '0';
			when "0100"|"1000"|"1100"|"1101"|"1110"|"1001" =>
				o_gt <= '1';
				o_eq <= '0';
				o_lt <= '0';
			end case;
		end process;
	end arch;
