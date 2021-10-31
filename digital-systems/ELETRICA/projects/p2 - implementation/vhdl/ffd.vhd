library ieee;
use ieee.std_logic_1164.all;

ENTITY ffd IS
	port ( clk ,D ,P , C : IN STD_LOGIC ;
		q : OUT STD_LOGIC );
END ffd ;

ARCHITECTURE ckt OF ffd IS
	SIGNAL qS : STD_LOGIC;
BEGIN

    PROCESS ( clk ,P ,C )
	    BEGIN
	    IF P = '0' THEN qS <= '1';
	    ELSIF C = '0' THEN qS <= '0';
	    ELSIF clk = '1' AND clk ' EVENT THEN
	    qS <= D ;
	    END IF;
    END PROCESS ;
q <= qS ;

END ckt ;