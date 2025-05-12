library ieee;
use ieee.std_logic_1164.all;

-- sum and carry select unit
entity SCS is
    generic (n: integer:= 4);
    port (
    in0 : in  std_logic_vector (n-1 downto 0);
    in1 : in  std_logic_vector (n-1 downto 0);
    c0  : in  std_logic;
    c1  : in  std_logic;
    cin : in  std_logic;
    s   : out std_logic_vector (n-1 downto 0);
    cout: out std_logic
         );
end SCS;

architecture str of SCS is
    component mux2_1_nbit
	generic (n: integer);
	port (
	a : in  std_logic_vector (n-1 downto 0);
	b : in  std_logic_vector (n-1 downto 0);
	s : in  std_logic;
	o : out std_logic_vector (n-1 downto 0)
	     );
    end component;
begin
    SUM_select: mux2_1_nbit generic map (n => n)
                         port    map (a => in0,
                                      b => in1,
                                      s => cin,
                                      o => s);

    Carry_select: mux2_1_nbit generic map (n => 1)
                            port    map (a(0) => c0,
                                         b(0) => c1,
                                         s => cin,
                                         o(0) => cout);
end str;
