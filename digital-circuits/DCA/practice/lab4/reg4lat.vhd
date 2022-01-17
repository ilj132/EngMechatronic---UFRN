ENTITY latch_D_4BITS IS
    PORT (
      D3, D2, D1, D0: IN  bit;
      EN: IN  bit;
      Q3, Q2, Q1, Q0: OUT bit
    );
END latch_D_4BITS;

ARCHITECTURE logic OF latch_D_4BITS IS
  
  COMPONENT latch_D IS
    PORT (
      D: IN  bit;
      EN: IN  bit;
      Q: OUT bit
    );
  END COMPONENT;
  
SIGNAL Qaux3, Qaux2, Qaux1, Qaux0 : bit;
  
BEGIN

  S3: latch_D port map(D3, EN, Q3);
  S2: latch_D port map(D2, EN, Q2);
  S1: latch_D port map(D1, EN, Q1);
  S0: latch_D port map(D0, EN, Q0);
    
END logic;