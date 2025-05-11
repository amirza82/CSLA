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
            F => bit_transfer(i)
        );
    end generate;
    X(n-1)<=bit_transfer(n-2) xor B(n-1);

end bec_nbit;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_port_bec_nbit is 
end tb_port_bec_nbit;

    architecture behavior of tb_port_bec_nbit is
        component port_bec_nbit
            generic (
                n : integer := 4              );
            port (
                B : in std_logic_vector(n-1 downto 0);
                X : out std_logic_vector(n-1 downto 0)
            );
        end component;


        constant N_BITS : integer := 4;
        signal B_tb : std_logic_vector(N_BITS-1 downto 0);
        signal X_tb : std_logic_vector(N_BITS-1 downto 0);

    begin
        uut: port_bec_nbit
        generic map (
            n => N_BITS
        )
        port map (
            B => B_tb,
            X => X_tb
        );

        stim_proc: process
        begin

            B_tb <= "0000";
            wait for 10 ns;

            B_tb <= "0001";
            wait for 10 ns;

            B_tb <= "0010";
            wait for 10 ns;

            B_tb <= "0101";
            wait for 10 ns;

            B_tb <= "0100";
            wait for 10 ns;

            B_tb <= "1111";
            wait for 10 ns;
            wait;
        end process;

    end behavior;
