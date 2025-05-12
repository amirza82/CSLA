library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( I0 : in  STD_LOGIC;
           I1 : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC;
           cout : out  STD_LOGIC);
end full_adder;

architecture Structural of full_adder is
signal xor0, and0, and1 : STD_LOGIC;
begin
	xor0 <= I0 xor I1;
	s <= cin xor xor0;
	and0 <= cin and xor0;
	and1 <= I0 and I1;
	cout <= and0 or and1;

end Structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_nbit_str is
    generic (n: integer:= 4);
    port(input0: in std_logic_vector (n-1 downto 0);
         input1: in std_logic_vector (n-1 downto 0);
         cin: in std_logic;
         sum: out std_logic_vector (n-1 downto 0);
         cout: out std_logic );
end adder_nbit_str;

architecture Behavioral of adder_nbit_str is
    component full_adder
        Port ( I0 : in  STD_LOGIC;
               I1 : in  STD_LOGIC;
               cin : in  STD_LOGIC;
               s : out  STD_LOGIC;
               cout : out  STD_LOGIC);
    end component;
    signal carry : std_logic_vector (n downto 0) := (others => '0');
begin
    carry(0) <= cin;
    cout <= carry(n);
    gen_adder: for i in 0 to n-1 generate
        addr: full_adder port map ( I0 => input0(i),
                                    I1 => input1(i),
                                    cin => carry(i),
                                    s => sum(i),
                                    cout => carry(i + 1));
    end generate;

end Behavioral;
