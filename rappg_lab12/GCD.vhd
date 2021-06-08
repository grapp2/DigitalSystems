library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity GCD is
  generic(N: integer:= 8);
  port(
    i_x,i_y: in std_logic_vector (N-1 downto 0);
    i_start, i_clk, i_res: in std_logic;
    o_gcd: out std_logic_vector (N-1 downto 0);
    o_done, o_ready: out std_logic
  );
end GCD;
architecture arch of GCD is
  type state_type is (ready, op0, done);
  signal state_reg, state_next: state_type;
  signal x_reg, y_reg, x_next, y_next, gcd_reg, gcd_next: unsigned(N-1 downto 0);
begin
  process (i_clk, i_res)
  begin
    if (i_res = '1') then
      state_reg <= ready;
      x_reg <= (others => '0');
      y_reg <= (others => '0');
      gcd_reg <= (others => '0');
    elsif (i_clk'event and i_clk = '1') then
      state_reg <= state_next;
      x_reg <= x_next;
      y_reg <= y_next;
      gcd_reg <= gcd_next;
    end if;
  end process;
  process (i_x, i_y, i_start, state_reg, x_next, y_next, gcd_next, x_reg, y_reg, gcd_reg)
    constant zero_vector: std_logic_vector (N-1 downto 0) := (others => '0');
  begin
    x_next <= x_reg;
    y_next <= y_reg;
    gcd_next <= gcd_reg;
    o_done <= '0';
    o_ready <= '0';
    case (state_reg) is
      when (ready) =>
        o_ready <= '1';
        if (i_start = '1') then
          x_next <= unsigned(i_x); --load in x and y
          y_next <= unsigned(i_y);
          state_next <= op0; -- next state operate
        else
          state_next <= ready;
        end if;
      when (op0) =>
        if (i_x = zero_vector or i_y = zero_vector) then
          gcd_next <= (others => '0');
          state_next <= done;
        else
          if (x_reg /= y_reg) then
            if (x_reg < y_reg) then
              y_next <= y_reg - x_reg;
            else
              x_next <= x_reg - y_reg;
            end if;
            state_next <= op0;
          else
            gcd_next <= x_reg;
            state_next <= done;
          end if;
       end if;
      when (done) =>
        o_done <= '1';
        state_next <= ready;
      end case;
    end process;
  o_gcd <= std_logic_vector(gcd_reg);
end arch;
