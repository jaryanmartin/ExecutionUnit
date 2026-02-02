library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ShiftSelector is
    Generic ( N : natural := 64 );
    Port (
            A, B      : in std_logic_vector(N-1 downto 0);
            ShiftFN : in std_logic;
            Result  : out std_logic_vector(N-1 downto 0)
    );
end entity ShiftSelector;

architecture behavioral of ShiftSelector is
begin
    process (A, B, ShiftFN, Result)
    begin
        if ShiftFN = '0' then
            Result <= A;
        elsif ShiftFN = '1' then
            Result <= B;
        end if;
    end process;
end architecture behavioral;
