library ieee;
use ieee.std_logic_1164.all;

ENTITY REG16 IS
    PORT( I: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        CLK, CLR, EN: IN STD_LOGIC;
        O: OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END REG16;

ARCHITECTURE CKT OF REG16 IS

COMPONENT ffd IS
    port ( clk ,D ,P , C : IN STD_LOGIC ;
    q : OUT STD_LOGIC );
END COMPONENT;

COMPONENT MUX21 is
    port(A, B, S: in STD_LOGIC;
       O: out STD_LOGIC);
 end COMPONENT;

SIGNAL CLEAR:STD_LOGIC;
SIGNAL Q,D: STD_LOGIC_VECTOR(15 DOWNTO 0);

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
    MUX8:  MUX21 PORT MAP(Q(8), I(8), EN, D(8));
    MUX9:  MUX21 PORT MAP(Q(9), I(9), EN, D(9));
    MUX10:  MUX21 PORT MAP(Q(10), I(10), EN, D(10));
    MUX11:  MUX21 PORT MAP(Q(11), I(11), EN, D(11));
    MUX12:  MUX21 PORT MAP(Q(12), I(12), EN, D(12));
    MUX13:  MUX21 PORT MAP(Q(13), I(13), EN, D(13));
    MUX14:  MUX21 PORT MAP(Q(14), I(14), EN, D(14));
    MUX15:  MUX21 PORT MAP(Q(15), I(15), EN, D(15));


    FFD0: ffd PORT MAP (CLK, D(0), '1', CLEAR, Q(0));
    FFD1: ffd PORT MAP (CLK, D(1), '1', CLEAR, Q(1));
    FFD2: ffd PORT MAP (CLK, D(2), '1', CLEAR, Q(2));
    FFD3: ffd PORT MAP (CLK, D(3), '1', CLEAR, Q(3));
    FFD4: ffd PORT MAP (CLK, D(4), '1', CLEAR, Q(4));
    FFD5: ffd PORT MAP (CLK, D(5), '1', CLEAR, Q(5));
    FFD6: ffd PORT MAP (CLK, D(6), '1', CLEAR, Q(6));
    FFD7: ffd PORT MAP (CLK, D(7), '1', CLEAR, Q(7));
    FFD8: ffd PORT MAP (CLK, D(8), '1', CLEAR, Q(8));
    FFD9: ffd PORT MAP (CLK, D(9), '1', CLEAR, Q(9));
    FFD10: ffd PORT MAP (CLK, D(10), '1', CLEAR, Q(10));
    FFD11: ffd PORT MAP (CLK, D(11), '1', CLEAR, Q(11));
    FFD12: ffd PORT MAP (CLK, D(12), '1', CLEAR, Q(12));
    FFD13: ffd PORT MAP (CLK, D(13), '1', CLEAR, Q(13));
    FFD14: ffd PORT MAP (CLK, D(14), '1', CLEAR, Q(14));
    FFD15: ffd PORT MAP (CLK, D(15), '1', CLEAR, Q(15));



    O<= Q;

END CKT;