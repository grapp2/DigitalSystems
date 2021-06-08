library ieee;
use ieee.std_logic_1164.all;
entity ShiftRegister is
	port(
		i_clk, i_res: in std_logic;
		i_ctrl: in std_logic_vector (1 downto 0);
		i_d: in std_logic_vector (3 downto 0);
		o_q: out std_logic_vector(3 downto 0)
	);
end ShiftRegister;
architecture arch of ShiftRegister is
begin
	sr0 : entity work.gen_shift_register(arch)
		generic map(N => 4)
		port map(i_clk => i_clk, i_res => i_res, i_ctrl => i_ctrl,
					i_d => i_d, o_q => o_q);
end arch;