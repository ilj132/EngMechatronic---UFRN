ENTITY REG IS
    PORT( I: IN BIT;
        CLK, CLR, EN: IN BIT;
        O: OUT BIT);
END REG;

ARCHITECTURE CKT OF REG IS

COMPONENT ffd IS
    port ( clk ,D ,P , C : IN BIT ;
    q : OUT BIT );
END COMPONENT;

COMPONENT MUX21 is
    port(A, B, S: in bit;
       O: out bit);
 end COMPONENT;

SIGNAL CLEAR:BIT;
SIGNAL Q,D: BIT;

BEGIN

    CLEAR <= NOT CLR;

    MUX1:  MUX21 PORT MAP(Q, I, EN, D);

    FFD1: ffd PORT MAP (CLK, D, '1', CLEAR, Q);

    O<= Q;

END CKT;