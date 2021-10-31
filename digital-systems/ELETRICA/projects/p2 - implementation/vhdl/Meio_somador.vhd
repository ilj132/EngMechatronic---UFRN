library ieee;
use ieee.std_logic_1164.all;

entity Meio_somador is
	port( A, B : in STD_LOGIC;
	  S, Carry : out STD_LOGIC);
end Meio_somador;

architecture ckt of Meio_somador is

begin
	
	S <= A xor B;
	Carry <= A and B;
	
end ckt;