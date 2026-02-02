library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AddnSub_entity is
    Generic ( N : natural := 64 );
    Port (
        A : in std_logic_vector(N-1 downto 0);
        AddnSub : in std_logic; 
        B : out std_logic_vector(N-1 downto 0)
    );
end entity AddnSub_entity;

architecture Behaviour of AddnSub_entity is
    signal A_unsigned : unsigned(N-1 downto 0);
begin
    A_unsigned <= unsigned(not A) + 1;

    -- Process block for conditional signal assignments
    process (A, AddnSub)  -- Sensitivity list includes signals A and AddnSub
    begin
        if AddnSub = '1' then
            B <= std_logic_vector(A_unsigned);  -- Perform addition (two's complement)
        elsif AddnSub = '0' then
            B <= A;  -- Perform subtraction (no change to A)
        end if;
    end process;
end architecture Behaviour;
