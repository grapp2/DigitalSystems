# DigitalSystems
## Collection of Digital Systems VHDL projects

### rappg_Lab2
#### and_gate.vhd
2 input AND gate
```
input:  i_a, i_b - std_logic
output: o_res   - std_logic
```
#### and_gate_tb.vhd
port maps and_gate.vhd and iterates through possible inputs
```
signals: i_SIG1, i_SIG2 (input signals)
         o_result                (output signal)
```

### rappg_Lab3 
#### case_2bit.vhd
2 bit comparator with case statement: Checks if inputs are equal, less than, or greater than each other and outputs result using a case statement
```
input:  i_a, i_b             - std_logic_vector (1 downto 0)
output: o_gt, o_lt, o_eq    - std_logic
```
#### bool2bit.vhd
2 bit comparator with boolean algebra
```
input:  i_a, i_b             - std_logic_vector (1 downto 0)
output: o_gt, o_lt, o_eq    - std_logic
```
#### withselect_2bit.vhd
2 bit comparator with with-select statement
```
input:  i_a, i_b             - std_logic_vector (1 downto 0)
output: o_gt, o_lt, o_eq    - std_logic
```
#### ifthen2bit.vhd
2 bit comparator with if-then statement
```
input:  i_a, i_b             - std_logic_vector (1 downto 0)
output: o_gt, o_lt, o_eq    - std_logic
```

### rappg_Lab5
#### 2inmux.vhd
uses select line to choose between two inputs
```
input:  i_a   - std_logic (select line)
        i_d   - std_logic_vector (1 downto 0) (data line)
output: o_y   - std_logic
```
#### 8inmux.vhd
    input:  i_a   - std_logic_vector (2 downto 0) (select line)
            i_d   - std_logic_vector (7 downto 0) (data line)
            i_e   - std_logic (enable)
    output: o_y   - std_logic
#### NAdder.vhd
Maps an adder component to add two vectors together
```    
input:  i_a3, i_b3   - std_logic_vector (2 downto 0)
output: o_tot        - std_logic_vector (3 downto 0) (total sum)
        o_sum        - std_logic_vector (3 downto 0) (sum w/o carry)
        o_c          - std_logic (carry)
```
#### OctalTristateBuffer.vhd
Passes 8 inputs to 8 outputs if an enable is set
```
input:  i_a1, i_a2   - std_logic_vector (3 downto 0) (data lines)
        i_e1, i_e2   - std_logic                     (enable)
output: o_y1, o_y2   - std_logic_vector (3 downto 0)
```

#### gen_add_w_carry.vhd
Adds 2 generically mapped input vectors together
```
input:  i_a, i_b     - std_logic_vector (N-1 downto 0) (data lines)
output: o_cout       - std_logic                       (carry)
        o_sum        - std_logic_vector (N-1 downto 0) (sum without carry)
```
### rappg_Lab6
#### jkFF0.vhd
```
input:  i_j, i_k, i_clk, i_pr, i_clr         std_logic
output: o_q, o_qbar                          std_logic
```
#### NandLatch.vhd
```
input:  i_s,i_r            std_logic
output: o_q, o_qbar        std_logic
```
#### dff.vhd
```
input:  i_d, i_clk, i_pr, i_clr     std_logic
output: o_q,o_qbar                  std_logic
```
#### DualDFF7474.vhd
Maps two d flip flops together
```
input:  i_pr,i_clk,i_clr,i_d: in std_logic_vector (1 downto 0);
output: o_q, o_qbar: out std_logic_vector (1 downto 0)
```
#### QuadDFF.vhd
Maps four d flip flops together with an enable changes input.
```
i_d               std_logic_vector(3 downto 0)
i_e               std_logic_vector(1 downto 0) (enables q manipulation)
o_q, o_qbar       std_logic_vector(3 downto 0)
```

### rappg_Lab7
#### ShiftRegister.vhd
Map to generic shift register entity
```
input:  i_clk, i_res       std_logic
        i_ctrl             std_logic_vector (1 downto 0)
        i_d                std_logic_vector (3 downto 0)
output: o_q                std_logic_vector(3 downto 0)
```
#### gen_shift_register.vhd
Generic shift register entity, shifts bits up or down with control line and has an asynchronous reset.
```
input:  i_clk, i_res       std_logic
        i_ctrl             std_logic_vector (1 downto 0)
        i_d                std_logic_vector (N-1 downto 0)
output: o_q                std_logic_vector(N-1 downto 0)
signal: r_reg, r_next      std_logic_vector(N-1 downto 0)
```

### rappg_Lab8
#### gen_counter.vhd
Synchronous counter with asynchronous reset, can count up and down or load data from input.
```
input:  i_clk, i_res, i_clr, i_en, i_up, i_ld         std_logic
        i_d                                           std_logic_vector(N-1 downto 0)
        o_max_tick,o_min_tick                         std_logic
output: o_q                                           std_logic_vector(N-1 downto 0)
signal: r_reg, r_next                                 unsigned(N-1 downto 0)
```
