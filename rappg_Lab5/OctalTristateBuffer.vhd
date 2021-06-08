library ieee;
use ieee.std_logic_1164.all;
entity OctalTristateBuffer is
	port(
		i_a1, i_a2: in std_logic_vector (3 downto 0);
		i_e1, i_e2: in std_logic;
		o_y1,o_y2: out std_logic_vector(3 downto 0)
	);
end OctalTristateBuffer;
architecture arch of OctalTristateBuffer is
begin
	process(i_a1,i_a2,i_e1,i_e2)
	begin
		if (i_e1 = '0' and i_e2 = '0') then
			o_y1 <= "ZZZZ";
			o_y2 <= "ZZZZ";
		elsif (i_e1 = '1' and i_e2 = '0') then
			o_y1(0) <= i_a1(0);
			o_y1(1) <= i_a1(1);
			o_y1(2) <= i_a1(2);
			o_y1(3) <= i_a1(3);
			o_y2 <= "ZZZZ";
		elsif (i_e1 = '0' and i_e2 = '1') then
			o_y2(0) <= i_a2(0);
			o_y2(1) <= i_a2(1);
			o_y2(2) <= i_a2(2);
			o_y2(3) <= i_a2(3);
			o_y1 <= "ZZZZ";
		elsif (i_e1 = '1' and i_e2 = '1') then
			o_y1(0) <= i_a1(0);
			o_y1(1) <= i_a1(1);
			o_y1(2) <= i_a1(2);
			o_y1(3) <= i_a1(3);
			o_y2(0) <= i_a2(0);
			o_y2(1) <= i_a2(1);
			o_y2(2) <= i_a2(2);
			o_y2(3) <= i_a2(3);
		end if;
	end process;
end arch;