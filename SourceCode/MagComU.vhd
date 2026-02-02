library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MagComU is
    Generic ( N : natural := 64 );
    Port (
        A, B : in std_logic_vector(N-1 downto 0);
        ALessThanB, AEqualB    : out std_logic
    );
end entity MagComU;

architecture Behaviour of MagComU is
			signal hiLessThan, loLessThan, hiEqual, loEqual : std_logic;

begin
RECUR:	if N > 1 generate 
i1: ENTITY WORK.MagComU generic map ( N => N/2 )
						port map( A => A(N-1 downto N/2) , B => B(N-1 downto N/2) , ALessThanB => hiLessThan, AEqualB => hiEqual);

i2: ENTITY WORK.MagComU generic map ( N => N/2 )
						port map( A => A((N/2)-1 downto 0) , B => B((N/2)-1 downto 0) , ALessThanB => loLessThan, AEqualB => loEqual);
						
							ALessThanB <= (hiEqual and loLessThan) or hiLessThan;
							AEqualB <= hiEqual and loEqual;
End Generate Recur;

	
STOP:	if N = 1 generate
							ALessThanB <= not A(0) and B(0);
							AEqualB <= A(0) xnor B(0);
End Generate Stop;

							
end architecture Behaviour;