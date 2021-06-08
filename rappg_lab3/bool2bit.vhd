library ieee;
use ieee.std_logic_1164.all;
entity bool2bit is
	port(
		i_a, i_b: in std_logic_vector (1 downto 0);
		o_gt, o_lt, o_eq: out std_logic
	);
end bool2bit;
architecture arch of bool2bit is
begin
	o_gt <= (i_a(1) and (not i_b(1))) 
		or (i_a(0) and (not i_b(0)) and (not i_b(1))) 
		or (i_a(0) and i_a(1) and (not i_b(0)));
	o_lt <= ((not i_a(1)) and i_b(1)) 
		or ((not i_a(1)) and (not i_a(0)) and i_b(0)) 
		or ((not i_a(0)) and i_b(1) and i_b(0));
	o_eq <= (i_a(0) xnor i_b(0)) and (i_a(1) xnor i_b(1));
end arch;