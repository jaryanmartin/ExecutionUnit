library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux is 
    port (
        in_1   : in std_logic;  -- Input 1
        in_2   : in std_logic;  -- Input 2
        sel    : in std_logic;  -- Selector
        output : out std_logic  -- Output
    );
end entity Mux;

architecture Behaviour of Mux is
begin
    -- Process for Multiplexer Logic
    process(in_1, in_2, sel)
    begin
        if sel = '0' then
            output <= in_1;  -- Select input 1
        else
            output <= in_2;  -- Select input 2
        end if;
    end process;
end architecture Behaviour;
