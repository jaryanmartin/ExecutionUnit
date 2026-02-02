library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mask is
    Generic ( N : natural := 64 );
    Port (
        A : in std_logic_vector(N-1 downto 0);
        B    : out std_logic_vector(6 downto 0)
    );
end entity Mask;

architecture Behaviour of Mask is
    signal updA : std_logic_vector(N-1 downto 0);

begin
B <= A(6 downto 0);
end architecture Behaviour;