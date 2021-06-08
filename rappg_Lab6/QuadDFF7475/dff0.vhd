library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity dff0 is
	port(
		i_d: in std_logic;
		i_g: in std_logic;
		o_q,o_qbar: out std_logic
	);
end dff0;
architecture arch of dff0 is
	signal internal_Q: std_logic;
begin
	o_q <= internal_Q;
	o_qbar <= not internal_Q;
	process(i_D,i_g)
	begin
		if (i_g = '1') then internal_Q <= i_d;
		else
		end if;
	end process;
end arch;