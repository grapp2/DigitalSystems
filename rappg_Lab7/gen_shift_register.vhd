library ieee;
use ieee.std_logic_1164.all;
entity gen_shift_register is
	generic(N: integer := 4);
	port(
		i_clk, i_res: in std_logic;
		i_ctrl: in std_logic_vector (1 downto 0);
		i_d: in std_logic_vector (N-1 downto 0);
		o_q: out std_logic_vector(N-1 downto 0)
	);
end gen_shift_register;
architecture arch of gen_shift_register is
	signal r_reg, r_next: std_logic_vector(N-1 downto 0);
begin
	process(i_clk,i_res,i_ctrl,I_d)
	begin
		if (i_res = '0') then
			r_reg <= (others => '0');
		elsif (i_clk'event and i_clk = '1') then
			r_reg <= r_next;
		end if;
	end process;
	process(i_ctrl,i_clk,i_d)
	begin
		if (i_ctrl = "01") then
			r_next <= r_reg(N-2 downto 0) & i_d(0);
		elsif (i_ctrl = "10") then
			r_next <= i_d(N-1) & r_reg(N-1 downto 1);
		elsif (i_ctrl = "11") then
			r_next <= i_d;
		end if;
	end process;
	o_q <= r_reg;
end arch;