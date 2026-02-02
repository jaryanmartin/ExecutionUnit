library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GTree is
    Generic ( M : natural := 64 );
    Port (
        G, P : in std_logic_vector(M downto 0);
        bG : out std_logic
    );
end entity GTree;

architecture Recursive of Gtree is
begin
	
	bG <= G(m) or P(m) ;

end architecture Recursive;