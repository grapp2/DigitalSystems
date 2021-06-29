# DigitalSystems
## Collection of Digital Systems VHDL projects

### rappg_Lab2
  #### Simple 2 input AND gate entity with test bench
    input: i_a, i_b - std_logic
    output: o_res   - std_logic

### rappg_Lab3 
  #### 2 bit comparator
    input: i_a, i_b             - std_logic_vector (1 downto 0)
    output: o_gt, o_lt, o_eq    - std_logic

### rappg_Lab5
  #### 2 input multiplexer
    input:  i_a   - std_logic (select line)
            i_d   - std_logic_vector (1 downto 0) (data line)
    output: o_y   - std_logic
  #### 8 input multiplexer
    input:  i_a   - std_logic_vector (2 downto 0) (select line)
            i_d   - std_logic_vector (7 downto 0) (data line)
            i_e   - std_logic (enable)
    output: o_y   - std_logic
  #### NAdder
  Mapping an adder component to add two vectors together
`    input:  i_a3, i_b3   - std_logic_vector (2 downto 0)
     output: o_tot        - std_logic_vector (3 downto 0) (total sum)
             o_sum        - std_logic_vector (3 downto 0) (sum w/o carry)
             o_c          - std_logic (carry)`
   
