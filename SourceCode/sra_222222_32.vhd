library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sra_222222_32 is
    Generic ( N : natural := 64 );  -- Width of the input/output vectors
    Port (
        A     : in  std_logic_vector(N-1 downto 0);  -- Input value to shift
        B     : in  std_logic_vector(6 downto 0);    -- Number of positions to shift
        Result: out std_logic_vector(N-1 downto 0)   -- Shifted output
    );
end entity sra_222222_32;

architecture behavioral of sra_222222_32 is
    signal zeros : std_logic_vector(31 downto 0);
    signal tempSTD : std_logic_vector(N-1 downto 0);
begin
	zeros <= (others => A(31));
	    process(A, B)
        variable temp : signed(N-1 downto 0);  -- Use unsigned for arithmetic operations
        variable shift_amount : integer;        -- Shift amount as an integer
    begin
        -- Convert inputs
        temp := signed(A);  -- Convert A to unsigned
        shift_amount := to_integer(unsigned(B));  -- Convert B to an integer

        -- Perform the shift
        if shift_amount < N then
            temp := shift_right(temp, shift_amount);  -- Perform left shift
        else
            temp := (others => A(31));  -- If shift exceeds width, output all zeros
        end if;

        -- Assign the result back to the output
        tempSTD <= std_logic_vector(temp);
		  Result <= zeros & tempSTD(31 downto 0);
    end process;
end architecture behavioral;