library ieee;
use ieee.std_logic_1164.all;

entity CSLA is
    port (
    A:    in  std_logic_vector (15 downto 0);
    B:    in  std_logic_vector (15 downto 0);
    cin:  in  std_logic;
    S:    out std_logic_vector (15 downto 0);
    cout: out std_logic
         );
end CSLA;

architecture str of CSLA is
    component SCS
        generic (n: integer);
        port (
        in0 : in  std_logic_vector (n-1 downto 0);
        in1 : in  std_logic_vector (n-1 downto 0);
        c0  : in  std_logic;
        c1  : in  std_logic;
        cin : in  std_logic;
        s   : out std_logic_vector (n-1 downto 0);
        cout: out std_logic
             );
    end component;

    component adder_nbit_str
        generic (n: integer);
        port (
        input0: in  std_logic_vector (n-1 downto 0);
        input1: in  std_logic_vector (n-1 downto 0);
        cin   : in  std_logic;
        sum   : out std_logic_vector (n-1 downto 0);
        cout  : out std_logic
             );
    end component;

    component port_bec_nbit
        generic (n: integer);
        port (
        B : in  std_logic_vector (n-1 downto 0);
        X : out std_logic_vector (n-1 downto 0);
        C : out std_logic
             );
    end component;
    signal g1c: std_logic;
    signal g2c: std_logic;
    signal g3c: std_logic;
    signal g4c: std_logic;

    signal g2RCAc: std_logic;
    signal g3RCAc: std_logic;
    signal g4RCAc: std_logic;
    signal g5RCAc: std_logic;

    signal g2BECc: std_logic;
    signal g3BECc: std_logic;
    signal g4BECc: std_logic;
    signal g5BECc: std_logic;

    signal g2c1: std_logic;
    signal g3c1: std_logic;
    signal g4c1: std_logic;
    signal g5c1: std_logic;

    signal g2RCAs: std_logic_vector (1 downto 0);
    signal g3RCAs: std_logic_vector (2 downto 0);
    signal g4RCAs: std_logic_vector (3 downto 0);
    signal g5RCAs: std_logic_vector (4 downto 0);

    signal g2BECx: std_logic_vector (1 downto 0);
    signal g3BECx: std_logic_vector (2 downto 0);
    signal g4BECx: std_logic_vector (3 downto 0);
    signal g5BECx: std_logic_vector (4 downto 0);

    signal g2s: std_logic_vector (1 downto 0);
    signal g3s: std_logic_vector (2 downto 0);
    signal g4s: std_logic_vector (3 downto 0);
    signal g5s: std_logic_vector (4 downto 0);
begin

    g2c1 <= g2RCAc or g2BECc;
    g3c1 <= g3RCAc or g3BECc;
    g4c1 <= g4RCAc or g4BECc;
    g5c1 <= g5RCAc or g5BECc;

    -- G1
    RCA1: adder_nbit_str generic map (n => 2)
                         port    map (input0 => A(1 downto 0),
                                      input1 => B(1 downto 0),
                                      cin    => cin,
                                      sum    => S(1 downto 0),
                                      cout   => g1c);

    -- G2
    RCA2:  adder_nbit_str generic map (n => 2)
                          port    map (input0 => A(3 downto 2),
                                       input1 => B(3 downto 2),
                                       cin    => '0',
                                       sum    => g2RCAs,
                                       cout   => g2RCAc);
    BEC2: port_bec_nbit generic map (n => 2)
                        port    map (B => g2RCAs,
                                     X => g2BECx,
                                     C => g2BECc);
    SCS2: SCS generic map (n => 2)
              port    map (in0 => g2RCAs,
                           in1 => g2BECx,
                           c0  => g2RCAc,
                           c1  => g2c1,
                           cin => g1c,
                           s   => S(3 downto 2),
                           cout=> g2c);

    -- G3
    RCA3:  adder_nbit_str generic map (n => 3)
                          port    map (input0 => A(6 downto 4),
                                       input1 => B(6 downto 4),
                                       cin    => '0',
                                       sum    => g3RCAs,
                                       cout   => g3RCAc);
    BEC3: port_bec_nbit generic map (n => 3)
                        port    map (B => g3RCAs,
                                     X => g3BECx,
                                     C => g3BECc);
    SCS3: SCS generic map (n => 3)
              port    map (in0 => g3RCAs,
                           in1 => g3BECx,
                           c0  => g3RCAc,
                           c1  => g3c1,
                           cin => g2c,
                           s   => S(6 downto 4),
                           cout=> g3c);

    -- G4
    RCA4:  adder_nbit_str generic map (n => 4)
                          port    map (input0 => A(10 downto 7),
                                       input1 => B(10 downto 7),
                                       cin    => '0',
                                       sum    => g4RCAs,
                                       cout   => g4RCAc);
    BEC4: port_bec_nbit generic map (n => 4)
                        port    map (B => g4RCAs,
                                     X => g4BECx,
                                     C => g4BECc);
    SCS4: SCS generic map (n => 4)
              port    map (in0 => g4RCAs,
                           in1 => g4BECx,
                           c0  => g4RCAc,
                           c1  => g4c1,
                           cin => g3c,
                           s   => S(10 downto 7),
                           cout=> g4c);

    -- G5
    RCA5:  adder_nbit_str generic map (n => 5)
                          port    map (input0 => A(15 downto 11),
                                       input1 => B(15 downto 11),
                                       cin    => '0',
                                       sum    => g5RCAs,
                                       cout   => g5RCAc);
    BEC5: port_bec_nbit generic map (n => 5)
                        port    map (B => g5RCAs,
                                     X => g5BECx,
                                     C => g5BECc);
    SCS5: SCS generic map (n => 5)
              port    map (in0 => g5RCAs,
                           in1 => g5BECx,
                           c0  => g5RCAc,
                           c1  => g5c1,
                           cin => g4c,
                           s   => S(15 downto 11),
                           cout=> cout);

end str;


library ieee;
use ieee.std_logic_1164.all;

entity tb_csla is
end tb_csla;

architecture bhv of tb_csla is
    component CSLA
        port (
        A:    in  std_logic_vector (15 downto 0);
        B:    in  std_logic_vector (15 downto 0);
        cin:  in  std_logic;
        S:    out std_logic_vector (15 downto 0);
        cout: out std_logic
             );
    end component;
        signal tb_A:    std_logic_vector (15 downto 0);
        signal tb_B:    std_logic_vector (15 downto 0);
        signal tb_cin:  std_logic;
        signal tb_S:    std_logic_vector (15 downto 0);
        signal tb_cout: std_logic;
begin

    test: CSLA port map (A    => tb_A,
                         B    => tb_B,
                         cin  => tb_cin,
                         S    => tb_S,
                         cout => tb_cout);

    process begin
        tb_A <= "0000010000000000";
        tb_B <= "0000111000000000";
        tb_cin <= '1';
        wait for 10 ns;
        tb_A <= "0010000000001000";
        tb_B <= "0000000000111000";
        tb_cin <= '0';
        wait for 10 ns;
        tb_A <= "0000000001111100";
        tb_B <= "0000000001111110";
        tb_cin <= '1';
        wait for 10 ns;
        tb_A <= "0000000001000001";
        tb_B <= "0000000000000001";
        tb_cin <= '1';
        wait for 10 ns;
        tb_A <= "0000000000000001";
        tb_B <= "0000000000000011";
        tb_cin <= '0';
        wait for 10 ns;
        tb_A <= "1100000000000001";
        tb_B <= "0100000000000000";
        tb_cin <= '0';
        wait for 10 ns;
        wait;
    end process;
end bhv;
