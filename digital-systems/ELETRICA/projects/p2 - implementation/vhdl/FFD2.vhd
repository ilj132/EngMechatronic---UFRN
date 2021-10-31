library ieee;
use ieee.std_logic_1164.all;

entity FFD2 is
	port( clk, D, P, C : in STD_LOGIC;
			en : in STD_LOGIC;
		     q, qn : out STD_LOGIC);
end FFD2;

architecture ckt of FFD2 is
	signal qS : STD_LOGIC;
	
	begin
		process (clk, P, C)
		begin
			if P = '1' THEN qS <= '1';
			elsif C = '1' THEN qS <= '0';
			elsif clk = '1' AND en = '1' AND clk'event THEN
				qS <= D;
			end if;
		end process;
	q <= qS;
	qn <= not qS;
END ckt;
