LIBRARY ieee;
USE ieee.std_logic_1164.all;
 
ENTITY and_gate IS
  PORT (
    i_a    : IN  std_logic;
    i_b    : IN  std_logic;
    o_res : OUT std_logic
    );
END and_gate;
 
ARCHITECTURE rtl OF and_gate IS
  SIGNAL and_gate : std_logic;
BEGIN
  and_gate   <= input_1 and input_2;
  and_result <= and_gate;
END rtl;
