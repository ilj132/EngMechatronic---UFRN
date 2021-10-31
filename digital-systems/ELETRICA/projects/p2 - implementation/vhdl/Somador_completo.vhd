library ieee;
use ieee.std_logic_1164.all;

entity Somador_Completo is
	port( As, Bs, CIs : in STD_LOGIC;
		  Ss, COs : out STD_LOGIC);
end Somador_Completo;

architecture ckt of Somador_Completo is

begin
	Ss <= As xor Bs xor CIs;
	COs <= (Bs and CIs) or (As and CIs) or (As and Bs);
end ckt;