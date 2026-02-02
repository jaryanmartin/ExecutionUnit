library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SkipCNet is
    Generic ( N : natural := 64 );
    Port (
        C : in std_logic_vector(N downto 0)
    );
end entity SkipCNet;

architecture Behaviour of SkipCNet is
begin

end architecture Behaviour;
