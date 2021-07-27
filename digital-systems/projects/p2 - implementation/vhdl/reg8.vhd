library ieee;
use ieee.std_logic_1164.all;

ENTITY REG8 IS
    PORT( I: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        CLK, CLR, EN: IN STD_LOGIC;
        O: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END REG8;

ARCHITECTURE CKT OF REG8 IS

COMPONENT ffd IS
    port ( clk ,D ,P , C : IN STD_LOGIC ;
    q : OUT STD_LOGIC );
END COMPONENT;

COMPONENT MUX21 is
    port(A, B, S: in STD_LOGIC;
       O: out STD_LOGIC);
 end COMPONENT;

SIGNAL CLEAR:STD_LOGIC;
SIGNAL Q,D: STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    CLEAR <= NOT CLR;

    MUX0:  MUX21 PORT MAP(Q(0), I(0), EN, D(0));
    MUX1:  MUX21 PORT MAP(Q(1), I(1), EN, D(1));
    MUX2:  MUX21 PORT MAP(Q(2), I(2), EN, D(2));
    MUX3:  MUX21 PORT MAP(Q(3), I(3), EN, D(3));
    MUX4:  MUX21 PORT MAP(Q(4), I(4), EN, D(4));
    MUX5:  MUX21 PORT MAP(Q(5), I(5), EN, D(5));
    MUX6:  MUX21 PORT MAP(Q(6), I(6), EN, D(6));
    MUX7:  MUX21 PORT MAP(Q(7), I(7), EN, D(7));


    FFD0: ffd PORT MAP (CLK, D(0), '1', CLEAR, Q(0));
    FFD1: ffd PORT MAP (CLK, D(1), '1', CLEAR, Q(1));
    FFD2: ffd PORT MAP (CLK, D(2), '1', CLEAR, Q(2));
    FFD3: ffd PORT MAP (CLK, D(3), '1', CLEAR, Q(3));
    FFD4: ffd PORT MAP (CLK, D(4), '1', CLEAR, Q(4));
    FFD5: ffd PORT MAP (CLK, D(5), '1', CLEAR, Q(5));
    FFD6: ffd PORT MAP (CLK, D(6), '1', CLEAR, Q(6));
    FFD7: ffd PORT MAP (CLK, D(7), '1', CLEAR, Q(7));

    O<= Q;

END CKT;