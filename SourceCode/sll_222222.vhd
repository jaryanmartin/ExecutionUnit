library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sll_222222 is
    Generic ( N : natural := 64 );  -- Width of the input/output vectors
    Port (
        A     : in  std_logic_vector(N-1 downto 0);  -- Input value to shift
        B     : in  std_logic_vector(6 downto 0);    -- Number of positions to shift
        Result: out std_logic_vector(N-1 downto 0)   -- Shifted output
    );
end entity sll_222222;

architecture behavioral of sll_222222 is
begin
    process(A, B)
        variable temp : unsigned(N-1 downto 0);  -- Use unsigned for arithmetic operations
        variable shift_amount : integer;        -- Shift amount as an integer
    begin
        -- Convert inputs
        temp := unsigned(A);  -- Convert A to unsigned
        shift_amount := to_integer(unsigned(B));  -- Convert B to an integer

        -- Perform the shift
        if shift_amount < N then
            temp := shift_left(temp, shift_amount);  -- Perform left shift
        else
            temp := (others => '0');  -- If shift exceeds width, output all zeros
        end if;

        -- Assign the result back to the output
        Result <= std_logic_vector(temp);
    end process;
end architecture behavioral;