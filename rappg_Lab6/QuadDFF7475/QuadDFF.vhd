library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity qffl7475 is
port(
	i_d: in std_logic_vector(3 downto 0);
	i_e: in std_logic_vector(1 downto 0);
	o_q, o_qbar: out std_logic_vector(3 downto 0)
);
end qffl7475;
architecture arch of qffl7475 is
begin
	dff1: work.dff0(arch)
		port map(i_d => i_d(0), i_g => i_e(0), o_q => o_q(0), o_qbar => o_qbar(0));
	dff2: work.dff0(arch)
		port map(i_d => i_d(1), i_g => i_e(0), o_q => o_q(1), o_qbar => o_qbar(1));
	dff3: work.dff0(arch)
		port map(i_d => i_d(2), i_g => i_e(1), o_q => o_q(2), o_qbar => o_qbar(2));
	dff4: work.dff0(arch)
		port map(i_d => i_d(3), i_g => i_e(1), o_q => o_q(3), o_qbar => o_qbar(3));
end arch;
