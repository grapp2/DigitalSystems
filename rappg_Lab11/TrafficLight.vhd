library ieee;
use ieee.std_logic_1164.all;
entity TrafficLight is
	port(
		i_nemer, i_ynite, i_clk, i_res: in std_logic;
		outputs: out std_logic_vector (5 downto 0)
	);
end TrafficLight;
architecture arch of TrafficLight is
	type eg_state_type is (s0,s1,s2,s3);
	signal state_reg, state_next: eg_state_type;
	signal clk: std_logic;
	attribute syn_encoding: string;
	attribute syn_encoding of eg_state_type: type is "safe, one-hot";
begin
	clkdiv: entity work.clk_div(a) port map(clock_50Mhz => i_clk, clock_1hz => clk);
	process(clk, i_res)
	begin
		if (i_res = '1') then
			state_reg <= s0;
		elsif (clk'event and clk = '1') then
			state_reg <= state_next;
		end if;
	end process;
	process(state_reg, i_nemer, i_ynite, state_next)
	begin
		state_next <= state_reg;
		outputs <= (others => '0');
		case state_reg is
			when s0 =>
				if (i_nemer = '0') then
					outputs <= "001001";
					state_next <= s0;
				else
					if (i_ynite = '1') then
						outputs <= "010000";
						state_next <= s1;
					else
						outputs <= "001100";
						state_next <= s1;
					end if;
				end if;
			when s1 =>
				if (i_nemer = '0') then
					outputs <= "001001";
					state_next <= s0;
				else
					if(i_ynite = '0') then 
						outputs <= "001010";
						state_next <= s2;
					else 
						outputs <= "000001";
						state_next <= s0;
					end if;
				end if;
			when s2 =>
				outputs <= "000001";
				if (i_nemer = '0') then
					outputs(3) <= '1';
					state_next <= s2;
				else
					outputs (5) <= '1';
					state_next <= s3;
				end if;
			when s3 =>
				outputs <= "000001";
				if (i_nemer = '0') then
					outputs (3) <= '1';
					state_next <= s3;
				else
					outputs (4) <= '1';
					state_next <= s0;
				end if;
		end case;
	end process;
end arch;