library ieee;
use ieee.std_logic_1164.all;
entity ifthen2bit is
	port(
		i_a,i_b: in integer range 0 to 3;
		o_gt, o_lt, o_eq: out std_logic
	);
end ifthen2bit;
architecture arch of ifthen2bit is
begin
	process(i_a,i_b)
	begin
		if (i_a > i_b) then 
			o_gt <= '1';
			o_lt <= '0';
			o_eq <= '0';
		elsif (i_a < i_b) then 
			o_lt <= '1';
			o_eq <= '0';
			o_gt <= '0';
		else 
			o_eq <= '1';
			o_lt <= '0';
			o_gt <= '0';
		end if;
	end process;
end arch;