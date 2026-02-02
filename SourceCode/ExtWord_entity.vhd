library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ExtWord_entity is
    Generic ( N : natural := 64 );
    Port (
            A      : in std_logic_vector(N-1 downto 0);
            ExtWord, upper : in std_logic;
            Result  : out std_logic_vector(N-1 downto 0)
    );
end entity ExtWord_entity;

architecture behavioral of ExtWord_entity is
    signal zeros : std_logic_vector(31 downto 0);
begin
    process (A, Result, ExtWord, upper)
    begin
		  if ExtWord = '0' then
            Result <= A;
        elsif upper = '0' then
				zeros <= (others => '0');
            Result <= zeros & A(31 downto 0);
        elsif upper = '1' then
				zeros <= (others => A(31));
            Result <= zeros & A(31 downto 0);
        end if;
    end process;
end architecture behavioral;