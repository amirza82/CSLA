library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity port_bec_nbit is 
generic (n:integer);
port (
    B : in std_logic_vector(n-1 downto 0);
    X : out std_logic_vector(n-1 downto 0)
);
end port_bec_nbit;

architecture bec_nbit of port_bec_nbit is 
component port_bec_1bit
 port ( A,B : in std_logic;
        C,F : out std_logic);
end component;
signal bit_transfer : std_logic_vector (n-2 downto 0) := (others => '0');
begin
    X(0) <= not B(0);
    bit_transfer(0) <= B(0);
    gen_bec: for i in 1 to n-2 generate
        bec_one_bit: port_bec_1bit port map(
            A => B(i),
            B => bit_transfer(i-1),
            C => X(i),
            F => bit_transfer(1)
        );
    end generate;
end bec_nbit;


