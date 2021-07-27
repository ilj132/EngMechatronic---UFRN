library ieee;
use ieee.std_logic_1164.all;

ENTITY DEMUX16 IS
	PORT(I, EN: in STD_LOGIC;
		S: in STD_LOGIC_VECTOR(3 downto 0);
		LD: out STD_LOGIC_VECTOR(15 downto 0));
END DEMUX16;

ARCHITECTURE CKT OF DEMUX16 IS

BEGIN

	LD(0) <=  EN and I and (not S(3) and not S(2) and not S(1) and not S(0));
	LD(1) <=  EN and I and (not S(3) and not S(2) and not S(1) and S(0));
	LD(2) <=  EN and I and (not S(3) and not S(2) and S(1) and not S(0));
	LD(3) <=  EN and I and (not S(3) and not S(2) and S(1) and S(0));
	LD(4) <=  EN and I and (not S(3) and S(2) and not S(1) and not S(0));
	LD(5) <=  EN and I and (not S(3) and S(2) and not S(1) and S(0));
	LD(6) <=  EN and I and (not S(3) and S(2) and S(1) and not S(0));
	LD(7) <=  EN and I and (not S(3) and S(2) and S(1) and S(0));
	LD(8) <=  EN and I and (S(3) and not S(2) and not S(1) and not S(0));
	LD(9) <=  EN and I and (S(3) and not S(2) and not S(1) and S(0));
	LD(10) <= EN and I and (S(3) and not S(2) and S(1) and not S(0));
	LD(11) <= EN and I and (S(3) and not S(2) and S(1) and S(0));
	LD(12) <= EN and I and (S(3) and S(2) and not S(1) and not S(0));
	LD(13) <= EN and I and (S(3) and S(2) and not S(1) and S(0));
	LD(14) <= EN and I and (S(3) and S(2) and S(1) and not S(0));
	LD(15) <= EN and I and (S(3) and S(2) and S(1) and S(0));
	
END CKT;