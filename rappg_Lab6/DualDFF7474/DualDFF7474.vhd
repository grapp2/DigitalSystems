library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity DualDFF7474 is
	port(
		i_pr,i_clk,i_clr,i_d: in std_logic_vector (1 downto 0);
		o_q, o_qbar: out std_logic_vector (1 downto 0)
	);
end DualDFF7474;
architecture arch of DualDFF7474 is
begin
	dualDFF1: work.dualDFF(arch)
		port map(i_pr => i_pr(0), i_clk => i_clk(0), i_clr => i_clr(0), i_d => i_d(0), o_q => o_q(0), o_qbar => o_qbar(0));
	dualDFF2: work.dualDFF(arch)
		port map(i_pr => i_pr(1), i_clk => i_clk(1), i_clr => i_clr(1), i_d => i_d(1), o_q => o_q(1), o_qbar => o_qbar(1));
end arch;