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

architecture behavioral of mux2_1_nbit_tb is
	component mux2_1_nbit
	generic (n: integer);
	port (
	a : in  std_logic_vector (n-1 downto 0);
	b : in  std_logic_vector (n-1 downto 0);
	s : in  std_logic;
	o : out std_logic_vector (n-1 downto 0)
	     );
end behavioral;
