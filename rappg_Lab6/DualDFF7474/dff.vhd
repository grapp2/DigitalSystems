library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity dualDFF is
	port(
		i_d, i_clk, i_pr, i_clr: in std_logic;
		o_q,o_qbar: out std_logic
	);
end dualDFF;
architecture arch of dualDFF is
	signal internal_Q, internal_Qbar: std_logic;
begin
	o_q <= internal_Q;
	o_qbar <= internal_Qbar;
	process (i_clk, i_clr, i_pr)
	begin
		if (i_pr = '0' and i_clr = '1') then 
			internal_Q <= '1';
			internal_Qbar <= '0';
		elsif (i_pr = '1' and i_clr = '0') then 
			internal_Q <= '0';
			internal_Qbar <= '1';
		elsif (i_pr = '0' and i_clr = '0') then 
			internal_Q <= '1';
			internal_Qbar <= '1';
		elsif (i_clk'event and i_clk = '1' and i_pr = '1' and i_clr = '1') then
			internal_Q <= i_d;
			internal_Qbar <= not(i_d);
		end if;
	end process;
end arch;
