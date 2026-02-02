library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Snet is
    Generic ( N : natural := 64 );
    Port (
        P : in std_logic_vector(N-1 downto 0);
	C : in std_logic_vector(N-1 downto 0);
        S    : out std_logic_vector(N-1 downto 0)
    );
end entity Snet;

architecture Behaviour of Snet is
begin
	
	S <= P xor C;

end architecture Behaviour;