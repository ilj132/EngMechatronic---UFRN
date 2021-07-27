library ieee;
use ieee.std_logic_1164.all;

entity MUX21_4 is
    port(A, B : in STD_LOGIC_VECTOR(3 downto 0);
	 S : in STD_LOGIC;
       	 O: out STD_LOGIC_VECTOR(3 downto 0));

end MUX21_4;

architecture CKT of MUX21_4 is

begin

    O(3) <= (B(3) and S) or (A(3) and (not S));
    O(2) <= (B(2) and S) or (A(2) and (not S));
    O(1) <= (B(1) and S) or (A(1) and (not S));
    O(0) <= (B(0) and S) or (A(0) and (not S));

end CKT;