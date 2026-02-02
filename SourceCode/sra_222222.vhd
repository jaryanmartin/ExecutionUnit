library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sra_222222 is
    Generic ( N : natural := 64 );  -- Width of the input/output vectors
    Port (
        A     : in  std_logic_vector(N-1 downto 0);  -- Input value to shift
        B     : in  std_logic_vector(6 downto 0);    -- Number of positions to shift
        Result: out std_logic_vector(N-1 downto 0)   -- Shifted output
    );
end entity sra_222222;

architecture behavioral of sra_222222 is
begin
    process(A, B)
        variable temp : signed(N-1 downto 0);  -- Use signed for arithmetic operations
        variable shift_amount : integer;       -- Shift amount as an integer
    begin
        -- Convert inputs
        temp := signed(A);  -- Convert A to signed
        shift_amount := to_integer(unsigned(B));  -- Convert B to an integer

        -- Perform the arithmetic shift
        if shift_amount < N then
            temp := shift_right(temp, shift_amount);  -- Perform arithmetic right shift
        else
            -- Propagate the MSB for large shifts
            temp := (others => temp(N-1));  -- All bits become the MSB (sign bit)
        end if;

        -- Assign the result back to the output
        Result <= std_logic_vector(temp);
    end process;
end architecture behavioral;