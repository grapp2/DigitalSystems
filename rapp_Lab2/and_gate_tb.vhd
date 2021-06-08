LIBRARY ieee;
USE ieee.std_logic_1164.all;
 
ENTITY and_gate_tb IS
END and_gate_tb;
 
ARCHITECTURE behave OF and_gate_tb IS
  SIGNAL i_SIG1   : std_logic := '0';
  SIGNAL i_SIG2   : std_logic := '0';
  SIGNAL o_RESULT : std_logic;
   
  COMPONENT and_gate IS
    PORT (
      input_1    : IN  std_logic;
      input_2    : IN  std_logic;
      and_result : OUT std_logic);
  END COMPONENT and_gate;
   
BEGIN
   
  and_gate_INST : and_gate
    PORT MAP (
      input_1    => i_SIG1,
      input_2    => i_SIG2,
      and_result => o_RESULT
      );
 
  PROCESS IS
  BEGIN
    i_SIG1 <= '0';
    i_SIG2 <= '0';
    WAIT FOR 10 ns;
    i_SIG1 <= '0';
    i_SIG2 <= '1';
    WAIT FOR 10 ns;
    i_SIG1 <= '1';
    i_SIG2 <= '0';
    WAIT FOR 10 ns;
    i_SIG1 <= '1';
    i_SIG2 <= '1';
    WAIT FOR 10 ns;    
  END PROCESS;
     
END behave;