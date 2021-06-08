library ieee;
use ieee.std_logic_1164.all;
entity jkFF0 is
	port(
		i_j, i_k, i_clk, i_pr, i_clr: in std_logic;
		o_q, o_qbar: out std_logic
	);
end jkFF0;
architecture arch of jkFF0 is
	signal internal_Q, internal_Qbar: std_logic;
begin
	o_q <= internal_Q;
	o_qbar <= internal_Qbar;
	process (i_clr, i_pr)
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
			if (i_j = '0' and i_k = '1') then
				internal_Q <= '0';
				internal_Qbar <= '1';			
			elsif(i_j = '1' and i_k = '0') then
				internal_Q <= '1';
				internal_Qbar <= '0';
			elsif(i_j = '1' and i_k = '1') then
				internal_Q <= not internal_Q;
				internal_Qbar <= not internal_Qbar;
			end if;
		end if;
	end process;
end arch;