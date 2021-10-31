library ieee;
use ieee.std_logic_1164.all;

ENTITY MUX8_8 IS
	port(I0, I1, I2, I3, I4, I5, I6, I7: in STD_LOGIC_VECTOR(7 DOWNTO 0);
		S: in STD_LOGIC_VECTOR(2 downto 0);
		O: out STD_LOGIC_VECTOR(7 DOWNTO 0));
END MUX8_8;

ARCHITECTURE CKT OF MUX8_8 IS

COMPONENT MUX8 IS
	port(I0, I1, I2, I3, I4, I5, I6, I7: in STD_LOGIC;
		S: in STD_LOGIC_VECTOR(2 downto 0);
		O: out STD_LOGIC);
END COMPONENT;

BEGIN

	BIT0: MUX8 PORT MAP (I0(0), I1(0), I2(0), I3(0), I4(0), I5(0), I6(0), I7(0), S, O(0));
	BIT1: MUX8 PORT MAP (I0(1), I1(1), I2(1), I3(1), I4(1), I5(1), I6(1), I7(1), S, O(1));
	BIT2: MUX8 PORT MAP (I0(2), I1(2), I2(2), I3(2), I4(2), I5(2), I6(2), I7(2), S, O(2));
	BIT3: MUX8 PORT MAP (I0(3), I1(3), I2(3), I3(3), I4(3), I5(3), I6(3), I7(3), S, O(3));
	BIT4: MUX8 PORT MAP (I0(4), I1(4), I2(4), I3(4), I4(4), I5(4), I6(4), I7(4), S, O(4));
	BIT5: MUX8 PORT MAP (I0(5), I1(5), I2(5), I3(5), I4(5), I5(5), I6(5), I7(5), S, O(5));
	BIT6: MUX8 PORT MAP (I0(6), I1(6), I2(6), I3(6), I4(6), I5(6), I6(6), I7(6), S, O(6));
	BIT7: MUX8 PORT MAP (I0(7), I1(7), I2(7), I3(7), I4(7), I5(7), I6(7), I7(7), S, O(7));

END CKT;