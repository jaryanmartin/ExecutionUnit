library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sll_222222_32 is
    Generic ( N : natural := 64 );  -- Width of the input/output vectors
    Port (
        A     : in  std_logic_vector(N-1 downto 0);  -- Input value to shift
        B     : in  std_logic_vector(6 downto 0);    -- Number of positions to shift
        Result: out std_logic_vector(N-1 downto 0)   -- Shifted output
    );
end entity sll_222222_32;

architecture behavioral of sll_222222_32 is
begin
    process(A, B)
        variable temp_lower : unsigned(31 downto 0);  -- Lower 32 bits to be shifted
        variable shift_amount : integer;             -- Shift amount as an integer
        variable temp_result : unsigned(N-1 downto 0); -- Temporary result
    begin
        -- Convert lower 32 bits of A to unsigned
        temp_lower := unsigned(A(31 downto 0));

        -- Convert B (std_logic_vector) to an integer for the shift amount
        shift_amount := to_integer(unsigned(B));

        -- Perform the shift
        if shift_amount < 32 then
            temp_lower := shift_left(temp_lower, shift_amount);  -- Shift lower 32 bits
        else
            temp_lower := (others => '0');  -- If shift amount exceeds 31, set lower bits to zero
        end if;

        -- Combine upper zeros with shifted lower bits
        temp_result := (others => '0');  -- Initialize entire result to zero
        temp_result(31 downto 0) := temp_lower;  -- Assign shifted lower 32 bits

        -- Assign the result back to the output
        Result <= std_logic_vector(temp_result);
    end process;
end architecture behavioral;