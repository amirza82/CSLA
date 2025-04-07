entity mux2_1_nbit is 
	generic n: integer;
	port (
	a : in std_logic_vector;
	b : in std_logic_vector;
	s : in std_logic;
	b : out std_logic_vector;
	     );
