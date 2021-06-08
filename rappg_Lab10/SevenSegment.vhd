library ieee;
use ieee.std_logic_1164.all;
entity SevenSegment is
	port(
		i_a: in std_logic_vector (3 downto 0);
		o_d: out std_logic_vector (6 downto 0)
	);
end SevenSegment;
architecture arch of SevenSegment is
begin
	process (i_a)
	begin
		if (i_a = "0000") then
			o_d <= "1000000";
		elsif (i_a = "0001") then
			o_d <= "1111001";
		elsif (i_a = "0010") then
			o_d <= "0100100";
		elsif (i_a = "0011") then
			o_d <= "0110000";
		elsif (i_a = "0100") then
			o_d <= "0011001";
		elsif (i_a = "0101") then
			o_d <= "0010010";
		elsif (i_a = "0110") then
			o_d <= "0000010";
		elsif (i_a = "0111") then
			o_d <= "1111000";
		elsif (i_a = "1000") then
			o_d <= "0000000";
		elsif (i_a = "1001") then
			o_d <= "0011000";
		elsif (i_a = "1010") then
			o_d <= "0001000";
		elsif (i_a = "1011") then
			o_d <= "0000011";
		elsif (i_a = "1100") then
			o_d <= "1000110";
		elsif (i_a = "1101") then
			o_d <= "0100001";
		elsif (i_a = "1110") then
			o_d <= "0000110";
		elsif (i_a = "1111") then
			o_d <= "0001110";
		else
			o_d <= "1111111";
		end if;
	end process;
end arch;