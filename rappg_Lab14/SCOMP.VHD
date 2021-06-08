LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.ALL;
USE  IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY SCOMP IS
  PORT(	
    clock, reset 				: IN STD_LOGIC;
    program_counter_out 		: OUT STD_LOGIC_VECTOR( 7 DOWNTO 0 );
    register_AC_out 			: OUT STD_LOGIC_VECTOR(15 DOWNTO 0 );
		memory_data_bus_out	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0 );
		memory_address_bus_out	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0 )
	);
END SCOMP;
ARCHITECTURE arch OF SCOMP IS
  TYPE STATE_TYPE IS ( reset_pc, fetch, decode, execute_add, execute_load, execute_store, 
		      execute_store2, execute_jump );
  SIGNAL state_reg, state_next: STATE_TYPE;
  SIGNAL memory_data_bus: std_logic_vector(15 downto 0);
  SIGNAL ir_reg, ir_next  	: unsigned(15 DOWNTO 0 ); -- instruction register, memory data line
  SIGNAL ac_reg, ac_next 				: unsigned(15 DOWNTO 0 ); --accumulator register
  SIGNAL pc_reg, pc_next, memory_address_bus 			: unsigned( 7 DOWNTO 0 ); --program counter register, memory address line
  SIGNAL memory_write 			: STD_LOGIC;
  BEGIN
			-- Use Altsyncram function for computer's memory (256 16-bit words)
    memory: altsyncram
      GENERIC MAP (
		    operation_mode => "SINGLE_PORT",
		    width_a => 16,
		    widthad_a => 8,
		    lpm_type => "altsyncram",
		    outdata_reg_a => "UNREGISTERED",
        -- Reads in mif file for initial program and data values
		    init_file => "program.mif",
		    intended_device_family => "Cyclone"
		  )
	   PORT MAP (	
        wren_a => memory_write, clock0 => clock, 
        address_a => std_logic_vector(memory_address_bus), data_a => std_logic_vector(ac_reg), 
        q_a => memory_data_bus -- keep as std_logic_vector
      );
			-- Output major signals for simulation
    program_counter_out 		<= std_logic_vector(pc_reg);
    register_AC_out 			<= std_logic_vector(ac_reg);
    memory_data_bus_out 	<= memory_data_bus; 
    memory_address_bus_out <= std_logic_vector(memory_address_bus); 
    PROCESS ( clock, reset )
    BEGIN
      IF reset = '1' THEN
        state_reg <= reset_pc;
        pc_reg <= (others => '0');
        ac_reg <= (others => '0');
        ir_reg <= (others => '0');
      ELSIF clock'EVENT AND clock = '1' THEN
		    state_reg <= state_next;
		    ir_reg <= ir_next;
		    ac_reg <= ac_next;
		    pc_reg <= pc_next;
      END IF;
    END PROCESS;
  
    PROCESS (state_reg,ir_reg,ac_reg,pc_reg,memory_data_bus,memory_address_bus,memory_write)
    BEGIN
      memory_write <= '0';
      pc_next <= pc_reg;
      ac_next <= ac_reg;
      ir_next <= ir_reg;
      CASE state_reg IS
        -- reset the computer, need to clear some registers
    		  WHEN reset_pc =>
          memory_address_bus <= (others => '0');
    			   state_next <= fetch;
    					-- Fetch instruction from memory and add 1 to PC
    		  WHEN fetch =>
    		    memory_address_bus <= pc_reg;
    			   ir_next 	<= unsigned(memory_data_bus);
    			   pc_next 		<= pc_reg + 1;
    			   state_next 					<= decode;
    					-- Decode instruction and send out address of any data operands
    		  WHEN decode =>
    		    memory_address_bus <= ir_reg(7 downto 0);
    			   CASE ir_reg( 15 DOWNTO 8 ) IS
    				    WHEN "00000000" =>
    				      state_next 	<= execute_add;
    				    WHEN "00000001" =>
    				      state_next 	<= execute_store;
    				    WHEN "00000010" =>
    				      state_next 	<= execute_load;		
    				    WHEN "00000011" =>
    				      state_next 	<= execute_jump;
    				    WHEN OTHERS =>
    				      state_next 	<= fetch;
    			   END CASE;
 				-- Execute the ADD instruction
    		  WHEN execute_add =>
    		    memory_address_bus <= pc_reg;
    			   ac_next 				<= ac_reg + unsigned(memory_data_bus);				
    			   state_next 	<= fetch;
    					-- Execute the STORE instruction
    					-- (needs three clock cycles for memory write)
    		  WHEN execute_store =>
    		    memory_write <= '1';
    		    memory_address_bus <= ir_reg(7 downto 0);
     			  state_next						<= execute_store2;
    					-- This state ensures that the memory address is
    					--  valid until after memory_write goes inactive
    		  WHEN execute_store2 =>
    		    memory_address_bus <= pc_reg;
    			   state_next 					<= fetch;
    			   
    					-- Execute the LOAD instruction
    		  WHEN execute_load =>
    		    memory_address_bus <= pc_reg;
    			   ac_next 				     <= unsigned(memory_data_bus);
    			   state_next       <= fetch;
    					-- Execute the JUMP instruction
    		  WHEN execute_jump =>
    		    memory_address_bus <= ir_reg(7 downto 0);
    			   pc_next 			      <= ir_reg( 7 DOWNTO 0 );
    			   state_next 				  <= fetch;
    		  WHEN OTHERS =>
    			   state_next       <= fetch;
		  END CASE;
	 END PROCESS;
-- memory address register is stored inside synchronous memory unit 
-- need to send it's outputs based on current state
END arch;
