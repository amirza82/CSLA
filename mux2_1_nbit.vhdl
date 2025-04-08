library ieee;
use ieee.std_logic_1164.all;

entity mux2_1_nbit is 
	generic (n: integer := 2);
	port (
	a : in  std_logic_vector (n-1 downto 0);
	b : in  std_logic_vector (n-1 downto 0);
	s : in  std_logic;
	o : out std_logic_vector (n-1 downto 0)
	     );
end mux2_1_nbit;

architecture structural of mux2_1_nbit is
begin
	o <= a when s='0' else
	     b;
end structural;

entity mux2_1_nbit_tb is
end mux2_1_nbit_tb;

library ieee;
use ieee.std_logic_1164.all;

architecture test of mux2_1_nbit_tb is
	component mux2_1_nbit
	generic (n: integer := 2);
	port (
	a : in  std_logic_vector (n-1 downto 0);
	b : in  std_logic_vector (n-1 downto 0);
	s : in  std_logic;
	o : out std_logic_vector (n-1 downto 0)
	     );
	end component;
	constant n : integer := 4;
	signal a : std_logic_vector (n-1 downto 0);
	signal b : std_logic_vector (n-1 downto 0);
	signal s : std_logic;
	signal o : std_logic_vector (n-1 downto 0);
begin
	mux: mux2_1_nbit generic map (n => n)
			 port    map (a => a,
				      b => b,
				      s => s,
				      o => o);

	process
	begin
		a <= "1111";
		b <= "0000";
		s <= '0';
		wait for 1 ns;
		s <= '1';
		wait for 1 ns;
		s <= '0';
		wait;
	end process;
end test;
