library ieee;
use ieee.std_logic_1164.all;
entity In8Mux is
	port(
		i_a: in std_logic_vector (2 downto 0);
		i_d: in std_logic_vector (7 downto 0);
		i_e: in std_logic;
		o_y: out std_logic
	);
end In8Mux;
architecture arch of In8Mux is
begin
	process(i_d,i_a,i_e)
	begin
		if (i_e = '0') then
			if (i_a = "000") then o_y <= i_d(0);
			elsif (i_a = "001") then o_y <= i_d(1);
			elsif (i_a = "010") then o_y <= i_d(2);
			elsif (i_a = "011") then o_y <= i_d(3);
			elsif (i_a = "100") then o_y <= i_d(4);
			elsif (i_a = "101") then o_y <= i_d(5);
			elsif (i_a = "110") then o_y <= i_d(6);
			elsif (i_a = "111") then o_y <= i_d(7);
			else o_y <= '0';
			end if;
		else o_y <= '0';
		end if;
	end process;
end arch;
