library ieee;
use ieee.std_logic_1164.all;

entity somador8bits is
	port( A, B: in STD_LOGIC_VECTOR(7 downto 0);
		O: out STD_LOGIC_VECTOR(7 downto 0);
		Carry: out STD_LOGIC
	);
end somador8bits;

architecture ckt of somador8bits is
	
	component Meio_somador is
		port( A, B : in STD_LOGIC;
	 	  S, Carry : out STD_LOGIC);
	end component;

	component Somador_Completo is
		port( As, Bs, CIs : in STD_LOGIC;
		  	  Ss, COs : out STD_LOGIC);
	end component;

	signal vai1 : STD_LOGIC_VECTOR(6 downto 0);
	
	begin
	S0: Meio_somador port map (A(0), B(0), O(0), vai1(0));
	S1: Somador_Completo port map (A(1), B(1), vai1(0), O(1), vai1(1));
	S2: Somador_Completo port map (A(2), B(2), vai1(1), O(2), vai1(2));
	S3: Somador_Completo port map (A(3), B(3), vai1(2), O(3), vai1(3));
	S4: Somador_Completo port map (A(4), B(4), vai1(3), O(4), vai1(4));
	S5: Somador_Completo port map (A(5), B(5), vai1(4), O(5), vai1(5));
	S6: Somador_Completo port map (A(6), B(6), vai1(5), O(6), vai1(6));
	S7: Somador_Completo port map (A(7), B(7), vai1(6), O(7), Carry);
	
end ckt;