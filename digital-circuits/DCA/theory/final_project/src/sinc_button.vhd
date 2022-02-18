ENTITY LOGIC_BS IS 
    PORT(Q1, Q0, T: IN BIT;
        D1, D0, PRESS: OUT BIT);
END LOGIC_BS;

ARCHITECTURE CKT OF LOGIC_BS IS

BEGIN

D1 <= (NOT Q1 AND Q0) OR (Q1 AND NOT Q0 AND T);
D0 <= NOT Q1 AND NOT Q0 AND T;
PRESS <= NOT Q1 AND Q0;

END CKT;

ENTITY BS IS
    PORT(CLK, T: IN BIT;
        PRESS: OUT BIT);
END BS;

ARCHITECTURE CKT OF BS IS

COMPONENT ffd is
    PORT ( clk ,D ,P , C : IN BIT ;
		q : OUT BIT );
END COMPONENT;

COMPONENT LOGIC_BS IS 
    PORT(Q1, Q0, T: IN BIT;
        D1, D0, PRESS: OUT BIT);
END COMPONENT;

SIGNAL Q1,Q0,D1,D0:BIT;

BEGIN

LOGIC: LOGIC_BS PORT MAP (Q1, Q0, T, D1, D0, PRESS);
FFD1: ffd PORT MAP(CLK, D1, '1', '1', Q1);
FFD2: ffd PORT MAP(CLK, D0, '1', '1', Q0);

END CKT;