library ieee;
use ieee.std_logic_1164.all;

entity MUX21_8 is
	port (A, B : in STD_LOGIC_VECTOR(7 downto 0);
		  S: in STD_LOGIC;
		  O: out STD_LOGIC_VECTOR(7 downto 0) );
end MUX21_8;

architecture ckt of MUX21_8 is

begin

	O(0) <= (B(0) and S) or (A(0) and (not S));
	O(1) <= (B(1) and S) or (A(1) and (not S));
	O(2) <= (B(2) and S) or (A(2) and (not S));
	O(3) <= (B(3) and S) or (A(3) and (not S));
	O(4) <= (B(4) and S) or (A(4) and (not S));
	O(5) <= (B(5) and S) or (A(5) and (not S));
	O(6) <= (B(6) and S) or (A(6) and (not S));
	O(7) <= (B(7) and S) or (A(7) and (not S));

end ckt;
