library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BLAN is
    Generic ( N : natural := 64 );
    Port (
        G, P : in std_logic_vector(N-1 downto 0);
        bG, bP : out std_logic_vector(N-1 downto 0)
    );
end entity BLAN;

architecture FLA of BLAN is


begin
		ForGenerate: for i in N-1 downto 0 generate
        begin
			ColumnBlock:	entity work.LAColumn
			generic map( M => i )
			port map( G => G(i downto 0), P => P(i downto 0), bG => bG(i), bP => bP(i) );
			end generate;

end architecture FLA;