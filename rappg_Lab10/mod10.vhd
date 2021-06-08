library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mod10 is
	port(
		i_clk, i_clr, i_en, i_ld: in std_logic;
		i_d: in std_logic_vector(3 downto 0);
		o_rco: out std_logic;
		o_q: out std_logic_vector(3 downto 0)
	);
end mod10;
architecture arch of mod10 is
	signal r_reg, r_next: unsigned(3 downto 0);
begin
	process(i_clk, i_clr)
	begin
		if (i_clr = '1') then
			r_reg <= (others => '0');
		elsif (i_clk'event and i_clk = '1') then
			r_reg <= r_next;
		end if;
	end process;
	process(i_ld,i_en,r_reg,i_d)
	begin
		if (i_ld = '1') then
			if(r_reg <= 9) then
				r_next <= unsigned(i_d);
			else
				r_next <= (others => '0');
			end if;
		else
			if (i_en = '1') then
				if(r_reg < 9) then
					r_next <= r_reg + 1;
				else
					r_next <= (others => '0');
				end if;
			else
				r_next <= r_reg;
			end if;
		end if;
	end process;
	o_q <= std_logic_vector(r_reg);
	o_rco <= '1' when r_reg = 9 AND i_en = '1' else '0';
end arch;