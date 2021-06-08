library ieee;
use ieee.std_logic_1164.all;
entity In2Mux is
	port(
		i_a: in std_logic;
		i_d: in std_logic_vector (1 downto 0);
		o_y: out std_logic
	);
end In2Mux;
architecture arch of In2Mux is
begin
	process(i_d,i_a)
	begin
		if (i_a = '0') then o_y <= i_d(0);
		elsif (i_a = '1') then o_y <= i_d(1);
		else o_y <= '0';
		end if;
	end process;
end arch;