library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FuncClass_entity is
    Generic ( N : natural := 64 );
    Port (
            AltB, AltBu, logic_result, ShiftFN3 : in std_logic_vector(N-1 downto 0);
            FuncClass : in std_logic_vector(1 downto 0);
            Result : out std_logic_vector(N-1 downto 0)
    );
end entity FuncClass_entity;

architecture behavioral of FuncClass_entity is
begin
    process(FuncClass, AltB, AltBu, logic_result, ShiftFN3)
    begin
        if FuncClass = "10" then
            Result <= AltB;
        elsif FuncClass = "11" then
            Result <= AltBu;
        elsif FuncClass = "01" then
            Result <= logic_result;
        elsif FuncClass = "00" then
            Result <= ShiftFN3;
        end if;
    end process;
end architecture behavioral;
