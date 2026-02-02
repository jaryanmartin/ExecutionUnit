library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LAColumn is
    Generic ( M : natural := 64 );
    Port (
        G, P : in std_logic_vector(M downto 0);
        bG, BP : out std_logic
    );
end entity LAColumn;


architecture Recursive of LACOlumn is
		Signal bpLo, bPHi : std_logic;
		Signal bGLo, bGHi : std_logic;
begin

Recur: if M > 0 generate
Upper: Entity work.LAColumn
				generic map( (M/2) )
				port map( G => G( M downto (M+1)/2 ), P => P( M downto (M+1)/2 ) , bP => bPhi, bG => bGHi);

Lower: Entity work.LAColumn
				generic map( (M+1)/2-1 )
				port map( G => G( ((M+1)/2)-1 downto 0), P => P( ((M+1)/2)-1 downto 0) , bP => bPlo, bG => bGlo);
						
		bP <= bphi AND bPlo;
		bG <= bGHi OR ( bpHi AND bGlo );
End Generate Recur;

stop: if M = 0 Generate
		bP <= P(0);
		bG <= G(0);
End Generate stop;


end architecture Recursive;