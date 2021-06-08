library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity gen_counter is
	generic(N: integer := 8);
	port(
		i_clk, i_res, i_clr, i_en, i_up, i_ld: in std_logic;
		i_d: in std_logic_vector(N-1 downto 0);
		o_max_tick,o_min_tick: out std_logic;
		o_q: out std_logic_vector(N-1 downto 0)
	);
end gen_counter;
architecture arch of gen_counter is
	signal r_reg, r_next: unsigned(N-1 downto 0);
begin
	process(i_clk,i_res)
	begin
		if (i_res = '1') then
			r_reg <= (others => '0');
		elsif (i_clk'event and i_clk = '1') then
			r_reg <= r_next;
		end if;
	end process;
	process(i_up,i_ld,i_clk,i_en)
	begin
		if (i_clr = '1') then
			r_next <= (others => '0');
		elsif (i_ld = '1') then
			r_next <= unsigned(i_d);
		else
			if (i_en = '1' and i_up = '0') then
				r_next <= r_reg - 1;
			elsif (i_en = '1' and i_up = '1') then
				r_next <= r_reg + 1;
			elsif (i_en = '0') then
				r_next <= r_reg;
			end if;
		end if;
	end process;
	o_q <= std_logic_vector(r_reg);
	o_max_tick <= '1' when r_reg = (2**N-1) else '0';
	o_min_tick <= '1' when r_reg = 0 else '0';
end arch;