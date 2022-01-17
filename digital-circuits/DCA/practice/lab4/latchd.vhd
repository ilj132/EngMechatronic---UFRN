ENTITY latch_D IS
    PORT (
      D: IN  bit;
      EN: IN  bit;
      Q: OUT bit
    );
END latch_D;

ARCHITECTURE logic OF latch_D IS
  
BEGIN

PROCESS(D, EN)
  BEGIN
    IF (EN = '1') THEN
        Q <= D;
    END IF;
END PROCESS;

END logic;
