library ieee;
use ieee.std_logic_1164.all;

entity MUX21_16 is
	port (A, B : in STD_LOGIC_VECTOR(15 downto 0);
		  S: in STD_LOGIC;
		  O: out STD_LOGIC_VECTOR(15 downto 0));
end MUX21_16;

architecture ckt of MUX21_16 is

begin

	O(0) <= (B(0) and S) or (A(0) and (not S));
	O(1) <= (B(1) and S) or (A(1) and (not S));
	O(2) <= (B(2) and S) or (A(2) and (not S));
	O(3) <= (B(3) and S) or (A(3) and (not S));
	O(4) <= (B(4) and S) or (A(4) and (not S));
	O(5) <= (B(5) and S) or (A(5) and (not S));
	O(6) <= (B(6) and S) or (A(6) and (not S));
	O(7) <= (B(7) and S) or (A(7) and (not S));
    O(8) <= (B(8) and S) or (A(8) and (not S));
    O(9) <= (B(9) and S) or (A(9) and (not S));
    O(10) <= (B(10) and S) or (A(10) and (not S));
    O(11) <= (B(11) and S) or (A(11) and (not S));
    O(12) <= (B(12) and S) or (A(12) and (not S));
    O(13) <= (B(13) and S) or (A(13) and (not S));
    O(14) <= (B(14) and S) or (A(14) and (not S));
    O(15) <= (B(15) and S) or (A(15) and (not S));

end ckt;
