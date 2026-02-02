library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;



entity CSA_Block is 
	 Generic ( N : natural := 64 );
    Port (
		S    : out std_logic_vector(N-1 downto 0);
      P, G : in std_logic_vector(N-1 downto 0);
		Cin  : in std_logic;
		Cout  : out std_logic

    );
end entity CSA_Block ;

architecture hierarchical of CSA_Block is
constant NumOfFAs : natural := integer(N);
--constant block_size : natural := N  / NumOfBlocks; 
signal	Group_p : std_logic;
signal	internal_c :std_logic_vector (NumOfFAs downto 0); 
begin

	internal_C(0) <= Cin;
	--Generate a SkipCNet
	SKipCnet: entity work.SkipCNet
	 Generic map ( N => NumOfFAs )
		port map (
		C => internal_c 
		);

-- Generate NumOfBlocks FA_SkipCarry instances\

	FAs: for i in NumOfFAs downto 1 generate
		begin 
			FAs_inst: entity work.FA_SkipCarry
			port map ( 					  
				S => S(NumOfFAs-i),	
				P => P(NumOfFAs-i), 
				G => G(NumOfFAs-i),
				Cin => internal_c(NumOfFAs-i),
			   Cout => internal_c(NumOfFAs-i+1)	
			);

	end generate FAs;
	
process (P)
    variable tmp : std_logic := '1'; -- Initialize to '1', the identity for AND
begin
    for I in P'range loop
        tmp := tmp and P(I); -- Perform AND operation on all bits of P
    end loop;
    Group_P <= tmp; -- Assign the result to the output signal
end process;


	--Generate a MUX
	MUX: entity work.Mux
		port map (
			in_1 => Cin,
			in_2 => internal_c(NumOfFAs),
			sel => Group_P ,
			output => Cout 
		);

end architecture ;			