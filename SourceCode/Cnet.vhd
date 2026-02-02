library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Cnet is
    Generic ( N : natural := 64 );
    Port (
        G, P : in std_logic_vector(N-1 downto 0);
	Cin : in std_logic;
        OC : out std_logic_vector(N downto 0)
    );
end entity Cnet;

architecture Structural of Cnet is

		Signal bG, bp : std_logic_vector( N-1 downto 0 ); 

begin

BLAN:	entity work.BLAN
			generic map( N => N )
			port map( G => G, P => P, bG => bG, bP => bP );

ForGenerate: for i in 0 to N-1 generate
        begin
		OC(i+1) <= bG(i) or (bP(i) and Cin);
			end generate;
	OC(0) <= Cin;

end architecture Structural;