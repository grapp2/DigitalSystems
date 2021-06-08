library ieee;
use ieee.std_logic_1164.all;
entity MasterFSM is
	port(
		i_start, i_clk, i_res: in std_logic;
		i_x, i_y: in std_logic_vector(7 downto 0);
		o_bcd3,o_bcd2,o_bcd1,o_bcd0: out std_logic_vector(3 downto 0)
	);
end MasterFSM;
architecture arch of MasterFSM is
	type state_type is (idle, findGCD, convNum);
	signal state_reg, state_next: state_type;
	signal bin2bcd_start, bin2bcd_done, gcd_start, gcd_done: std_logic; --Start and done ticks
	signal gcd_out: std_logic_vector (7 downto 0); --Number to convert to 4 digit BCD
  signal bin_signal: std_logic_vector(12 downto 0);
begin
	-- instantiate gcd component
	gcd0: entity work.GCD 
	port map(
		i_x => i_x,i_y => i_y, i_start => gcd_start, i_clk => i_clk, i_res => i_res,
		o_gcd => gcd_out, o_done => gcd_done, o_ready => open
	);
	bin_signal <= "00000" & gcd_out;
	-- instantiate converter
	bin2bcd0: entity work.bin2bcd 
	port map(
      clk => i_clk, reset => i_res, start => bin2bcd_start, bin => bin_signal,
      ready => open, done_tick => bin2bcd_done, bcd3 => o_bcd3, bcd2 => o_bcd2, bcd1 => o_bcd1, bcd0 => o_bcd0
   );
	-- Master FSM
	process (i_clk, i_res)
	begin
		if (i_res = '1') then
			state_reg <= idle;
		elsif (i_clk'event and i_clk = '1') then
			state_reg <= state_next;
		end if;
	end process;
	process(i_start, i_res, i_x, i_y, state_reg,bin2bcd_start, bin2bcd_done, gcd_start, gcd_done)
	begin
		state_next <= state_reg;
		gcd_start <= '0';
		bin2bcd_start <= '0';
		case state_reg is
			when idle =>
				if (i_start = '1') then
					state_next <= findGCD;
					gcd_start <= '1';
				end if;
			when findGCD =>
				if (gcd_done = '1') then
					state_next <= convNum;
					bin2bcd_start <= '1';
				end if;
			when convNum =>
				if (bin2bcd_done = '1') then
					state_next <= idle;
				end if;
		end case;
	end process;
end arch;

