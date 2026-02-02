library ieee;
use ieee.std_logic_1164.all;

entity LogicUnit is
    Generic ( N : natural := 64 );  -- Data width
    Port (
        A : in std_logic_vector(N-1 downto 0);  -- Operand A
        B : in std_logic_vector(N-1 downto 0);  -- Operand B
        Func : in std_logic_vector(1 downto 0);  -- Logic function (01=XOR, 10=OR, 11=AND)
        Result : out std_logic_vector(N-1 downto 0)  -- Logic result
    );
end entity LogicUnit;

architecture behavioral of LogicUnit is
begin
    process(A, B, Func)
    begin
        case Func is
            -- LUI operation
            when "00" => 
                    Result <= B; -- We don't have the instruction (hence we don't have the opcode/immediate) so just do nothing I guess
						  -- Do we use the value of B?
						  -- SextI goes to the B register which is an input to the execution unit. Which is a sign extended version of the immediate value.
						  -- I think that for lui test cases we just need to make B already in its immediate form
            -- XOR operation
            when "01" => 
                    Result <= A xor B;  -- Bitwise XOR
            -- OR operation
            when "10" =>
                    Result <= A or B;   -- Bitwise OR
                    -- AND operation
                when "11" =>
                    Result <= A and B;  -- Bitwise AND
               -- Default case (no operation or error handling)
            when others => 
                Result <= A;  -- Default case: all zeros
        end case;
    end process;
end architecture behavioral;