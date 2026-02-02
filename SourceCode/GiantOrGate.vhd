library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GiantOrGate is
    Generic ( N : natural := 64 );
    Port (
        A : in std_logic_vector(N-1 downto 0);
        B    : out std_logic
    );
end entity GiantOrGate;

architecture Behaviour of GiantOrGate is
			signal hi, lo : std_logic;

begin
--    B <= A(0) and A(1) and A(2) and A(3) and A(4) and A(5) and A(6) and A(7) and A(8) and A(9) and A(10) and A(11) and A(12) and A(13) and A(14) and A(15);

RECUR:	if N > 1 generate 
i1: ENTITY WORK.GiantOrGate generic map ( N => N/2 )
						port map( A => A(N-1 downto N/2) , B => hi);

i2: ENTITY WORK.GiantOrGate generic map ( N => N/2 )
						port map( A => A((N/2)-1 downto 0) , B => lo);
						
							B <= hi or lo;
End Generate Recur;

	
STOP:	if N = 1 generate
		B <= A(0);
End Generate Stop;

							
end architecture Behaviour;