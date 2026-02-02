library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity Adder is
    Generic ( N : natural := 64  );
    Port (
        S  : out std_logic_vector(N-1 downto 0);
        A, B : in std_logic_vector(N-1 downto 0);
        Cin  : in std_logic;
        Cout : out std_logic;
        Ovfl : out std_logic
    );
end entity Adder;

architecture hierarchical of Adder is

    constant NumOfBlocks : natural := integer(sqrt(real(N)));
    constant block_size : natural := N / NumOfBlocks; 
    signal internal_P: std_logic_vector(N-1 downto 0);
    signal internal_G: std_logic_vector(N-1 downto 0);
    signal internal_C: std_logic_vector(NumOfBlocks downto 0);

begin
    internal_C(0) <= Cin;
    Cout <= internal_C(NumOfBlocks);
    Ovfl <= internal_C(NumOfBlocks-1) xor Cout;

    -- Generate a GPnet Block
    GPNET: entity work.GPnet
        generic map ( N => N )
        port map (
            A => A,
            B => B,
            G => internal_G,
            P => internal_P
        );

    CSA_Blocks: for i in NumOfBlocks downto 1 generate
        constant start_index : integer := (i * block_size) - 1;
        constant end_index : integer := start_index - block_size + 1;

        signal S_slice: std_logic_vector(block_size-1 downto 0);
        signal P_slice: std_logic_vector(block_size-1 downto 0);
        signal G_slice: std_logic_vector(block_size-1 downto 0);

    begin
        S_slice <= S(start_index downto end_index);
        P_slice <= internal_P(start_index downto end_index);
        G_slice <= internal_G(start_index downto end_index);

        CSA_Block_inst: entity work.CSA_Block
            generic map ( N => block_size )
            port map (
                S => S(start_index downto end_index),    
                P => P_slice, 
                G => G_slice,
                Cin => internal_C(i-1),
                Cout => internal_C(i)
            );

    end generate CSA_Blocks;

end architecture hierarchical;
