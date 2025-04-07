library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity port_bec_1bit is port (
    A,B : in std_logic;
    C,F : out std_logic
);
end port_bec_1bit;


architecture bec_1bit of port_bec_1bit is 
begin
    C <= B xor A;
    F <= B and A;
end bec_1bit;