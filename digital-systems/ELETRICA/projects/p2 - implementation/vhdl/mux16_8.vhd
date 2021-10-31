library ieee;
use ieee.std_logic_1164.all;

entity MUX16_8 is
	port(I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15: in STD_LOGIC_VECTOR(7 DOWNTO 0);
		S: in STD_LOGIC_VECTOR(3 downto 0);
        EN: IN STD_LOGIC;
		O: out STD_LOGIC_VECTOR(7 DOWNTO 0));
end MUX16_8;

architecture ckt of MUX16_8 is

COMPONENT MUX16 IS
	port(EN, I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15: in STD_LOGIC;
		S: in STD_LOGIC_VECTOR(3 downto 0);
		O: out STD_LOGIC);
END COMPONENT;

begin

	BIT0: MUX16 PORT MAP (EN, I0(0), I1(0), I2(0), I3(0), I4(0), I5(0), I6(0), I7(0), I8(0), I9(0), I10(0), I11(0), I12(0), I13(0), I14(0), I15(0), S, O(0));
	BIT1: MUX16 PORT MAP (EN, I0(1), I1(1), I2(1), I3(1), I4(1), I5(1), I6(1), I7(1), I8(1), I9(1), I10(1), I11(1), I12(1), I13(1), I14(1), I15(1), S, O(1));
	BIT2: MUX16 PORT MAP (EN, I0(2), I1(2), I2(2), I3(2), I4(2), I5(2), I6(2), I7(2), I8(2), I9(2), I10(2), I11(2), I12(2), I13(2), I14(2), I15(2), S, O(2));
	BIT3: MUX16 PORT MAP (EN, I0(3), I1(3), I2(3), I3(3), I4(3), I5(3), I6(3), I7(3), I8(3), I9(3), I10(3), I11(3), I12(3), I13(3), I14(3), I15(3), S, O(3));
	BIT4: MUX16 PORT MAP (EN, I0(4), I1(4), I2(4), I3(4), I4(4), I5(4), I6(4), I7(4), I8(4), I9(4), I10(4), I11(4), I12(4), I13(4), I14(4), I15(4), S, O(4));
	BIT5: MUX16 PORT MAP (EN, I0(5), I1(5), I2(5), I3(5), I4(5), I5(5), I6(5), I7(5), I8(5), I9(5), I10(5), I11(5), I12(5), I13(5), I14(5), I15(5), S, O(5));
	BIT6: MUX16 PORT MAP (EN, I0(6), I1(6), I2(6), I3(6), I4(6), I5(6), I6(6), I7(6), I8(6), I9(6), I10(6), I11(6), I12(6), I13(6), I14(6), I15(6), S, O(6));
	BIT7: MUX16 PORT MAP (EN, I0(7), I1(7), I2(7), I3(7), I4(7), I5(7), I6(7), I7(7), I8(7), I9(7), I10(7), I11(7), I12(7), I13(7), I14(7), I15(7), S, O(7));

end ckt;