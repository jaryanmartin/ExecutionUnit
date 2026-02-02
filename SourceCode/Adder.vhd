library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder is
    Generic ( N : natural := 64 );
    Port (
        A, B : in std_logic_vector(N-1 downto 0);
        S    : out std_logic_vector(N-1 downto 0);
        Cin  : in std_logic;
        Cout : out std_logic;
        Ovfl : out std_logic
    );
end entity Adder;

architecture Behaviour of Adder is
    signal A_unsigned, B_unsigned : unsigned(N-1 downto 0);  -- Converted inputs
    signal Sunsigned : unsigned(N downto 0);                 -- N+1 bit sum
    signal Cin_extended : unsigned(0 to 0);                  -- 1-bit unsigned carry-in

    signal Sign_A, Sign_B, Sign_S : std_logic;  -- Track signs
    signal Carry_out_from_MSB : std_logic;      -- Carry out from MSB
begin
    -- Convert inputs to unsigned.
    A_unsigned <= unsigned(A);
    B_unsigned <= unsigned(B);

    -- Convert Cin to a 1-bit unsigned value explicitly.
    Cin_extended(0) <= '0' when Cin = '0' else '1';

    -- Perform the addition with explicitly extended operands.
    Sunsigned <= ("0" & A_unsigned) + ("0" & B_unsigned) + Cin_extended;

    -- Assign the lower N bits to the output sum.
    S <= std_logic_vector(Sunsigned(N-1 downto 0));

    -- Track the signs of the inputs and result.
    Sign_A <= A(N-1);  -- Sign bit of A
    Sign_B <= B(N-1);  -- Sign bit of B
    Sign_S <= S(N-1);  -- Sign bit of the result

    -- Calculate overflow: OVFL = (Sign_A xor Sign_B) = 0 AND (Sign_A xor Sign_S) = 1
    Ovfl <= (not (Sign_A xor Sign_B)) and (Sign_A xor Sign_S);

    -- Calculate Cout: Carry-out from the MSB (bit 63).
    Carry_out_from_MSB <= Sunsigned(N);

    -- Assign Cout.
    Cout <= Carry_out_from_MSB;
end architecture Behaviour;