library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


entity FA_SkipCarry is
    Port (
	     S  : out std_logic;
        P, G : in std_logic;
		  Cin  : in std_logic;
        Cout : out std_logic
    );
end entity FA_SkipCarry;

architecture behavior of FA_SkipCarry is
begin
	S <= P xor Cin;
   Cout <= G or (P and Cin); 
end architecture;