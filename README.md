# DigitalSystems
## Collection of Digital Systems VHDL projects

### rappg_Lab2
#### Simple 2 input AND gate entity with test bench
    input:  i_a, i_b - std_logic
    output: o_res   - std_logic

### rappg_Lab3 
#### 2 bit comparator
    input:  i_a, i_b             - std_logic_vector (1 downto 0)
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
#### N-Adder
Maps an adder component to add two vectors together
```    
input:  i_a3, i_b3   - std_logic_vector (2 downto 0)
output: o_tot        - std_logic_vector (3 downto 0) (total sum)
        o_sum        - std_logic_vector (3 downto 0) (sum w/o carry)
        o_c          - std_logic (carry)
```
#### Octal Tristate Buffer
Passes 8 inputs to 8 outputs if an enable is set
```
input:  i_a1, i_a2   - std_logic_vector (3 downto 0) (data lines)
        i_e1, i_e2   - std_logic                     (enable)
output: o_y1, o_y2   - std_logic_vector (3 downto 0)
```

#### Generic add with carry
Adds 2 generically mapped input vectors together
```
input:  i_a, i_b     - std_logic_vector (N-1 downto 0) (data lines)
output: o_cout       - std_logic                       (carry)
        o_sum        - std_logic_vector (N-1 downto 0) (sum without carry)
```
### rappg_Lab6

