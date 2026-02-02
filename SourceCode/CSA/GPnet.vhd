library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GPnet is
    Generic ( N : natural := 64 );
    Port (
        A, B : in std_logic_vector(N-1 downto 0);
        G, P    : out std_logic_vector(N-1 downto 0)
    );
end entity GPnet;

architecture Behaviour of GPnet is
begin
	P<= A xor B;  -- Propagate signals
	G <= A and B;  -- Generate signals

end architecture Behaviour;