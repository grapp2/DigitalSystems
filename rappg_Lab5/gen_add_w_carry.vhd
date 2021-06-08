library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity gen_add_w_carry is
	generic(N: integer);
	port(
		i_a, i_b: in std_logic_vector(N-1 downto 0);
		o_cout: out std_logic;
		o_sum: out std_logic_vector(N-1 downto 0)
	);
end gen_add_w_carry;
architecture arch of gen_add_w_carry is
	signal a_ext, b_ext, sum_ext: unsigned(N downto 0);
begin
	a_ext <= unsigned('0'& i_a);
	b_ext <= unsigned('0'& i_b);
	sum_ext <= a_ext + b_ext;
	o_sum <= std_logic_vector(sum_ext(N-1 downto 0));
	o_cout <= sum_ext(N);
end arch;