library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Architecture Structure of Adder is
	Signal G, P : std_logic_vector( N-1 downto 0 );
	Signal IC : std_logic_vector( N downto 0 );

Begin
Top:	entity work.GPnet generic map ( N => N )
				port map( A => A, B => B, G => G, P => P );
Mid:	entity work.Cnet generic map ( N => N )
				port map ( G => G, P => P, Cin => Cin, OC => IC );
Bot: entity work.Snet generic map ( N => N )
				port map ( P => P, C => IC(N-1 downto 0), S => S );
		
		Cout <= IC(N);
		Ovfl <= IC(N) xor IC(N-1);

End Architecture Structure;