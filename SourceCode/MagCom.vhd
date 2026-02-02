library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MagCom is
    Generic ( N : natural := 64 );
    Port (
        A, B : in std_logic_vector(N-1 downto 0);
        ALessThanB, AEqualB, ALessThanBU, AEqualBU : out std_logic
    );
end entity MagCom;

architecture Behaviour of MagCom is

    component MagComU is
        Generic ( N : natural := 64 );
        Port (
            A, B : in std_logic_vector(N-1 downto 0);
            ALessThanB, AEqualB : out std_logic
        );
    end component;

    -- Declare the component instance signals for use in the process
    signal internal_ALessThanB, internal_AEqualB : std_logic;

begin
    -- Instantiate the component outside the process block
    MagComU_inst1 : MagComU
        generic map ( N => N )
        port map (
            A => A,
            B => B,
            ALessThanB => internal_ALessThanB,
            AEqualB => internal_AEqualB
        );
	ALessThanBU <= internal_ALessThanB;
	AEqualBU <= internal_AEqualB;

    process(A, B)
    begin
        if A(N-1) = '0' and B(N-1) = '0' then
            ALessThanB <= internal_ALessThanB;
            AEqualB <= internal_AEqualB;
        elsif A(N-1) = '0' and B(N-1) = '1' then
            ALessThanB <= '0';
            AEqualB <= '0';
        elsif A(N-1) = '1' and B(N-1) = '0' then
            ALessThanB <= '1';
            AEqualB <= '0';
        elsif A(N-1) = '1' and B(N-1) = '1' then
            ALessThanB <= not internal_ALessThanB;
            AEqualB <= internal_AEqualB;
        end if;
    end process;

end architecture Behaviour;
