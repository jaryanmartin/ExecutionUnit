library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PTree is
    Generic ( M : natural := 64 );
    Port (
        P : in std_logic_vector(M downto 0);
        BP : out std_logic
    );
end entity PTree;

architecture recursive of PTree is
		Signal bpLo, bPHi : std_logic;
begin

Recur: if M > 0 generate
lower:	entity work.PTree
			generic map( (M+1)/2-1 )
			port map( P => P( ((M+1)/2)-1 downto 0) , bP => bPlo);
			

Upper:	entity work.PTree
			generic map( (M/2) )
			port map( P => P( M downto (M+1)/2 ) , bP => bPhi);

		bP <= bphi and bPlo;
End Generate Recur;

stop: if M = 0 Generate
		bP <= p(0);
End Generate stop;

end architecture recursive;