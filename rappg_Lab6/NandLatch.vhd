library ieee;
use ieee.std_logic_1164.all;
entity NandLatch is
	port(
		i_s,i_r: in std_logic;
		o_q, o_qbar: buffer std_logic
	);
end NandLatch;
architecture arch of NandLatch is
begin
	o_q <= i_s nand o_qbar;
	o_qbar <= i_r nand o_q;
end arch;