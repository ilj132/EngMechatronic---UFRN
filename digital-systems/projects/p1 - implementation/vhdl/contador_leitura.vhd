library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CONT_L is
	port (CLK,LOAD,CLEAR, N, B: IN STD_LOGIC;
		CONT_W: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		COMP_EQ: OUT STD_LOGIC;
		SAIDA: OUT STD_LOGIC_VECTOR (4 DOWNTO 0));
end entity;

architecture logica of CONT_L is

	SIGNAL COUNT : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL CNT_W : INTEGER RANGE 0 TO 24;

begin

	PROCESS (CLK,LOAD,CLEAR)
	VARIABLE COUNTER : INTEGER RANGE 0 TO 24;
	BEGIN 
		CNT_W <= to_integer(unsigned(CONT_W));
		
		IF (CLEAR = '1' AND CLK = '1' and CLK'event) THEN
			COUNTER := 0;
		ELSIF (CLK = '1' and CLK'event AND LOAD = '1' and N = '0' and B ='0' and (COUNTER < CNT_W))  THEN 
			COUNTER := COUNTER + 1;
		ELSIF (CLK = '1' and CLK'event AND LOAD = '1' and N = '1' and(COUNTER < CNT_W))  THEN 
			COUNTER := COUNTER + 1;
		ELSIF (CLK = '1' and CLK'event AND LOAD = '1' and B = '1' and (COUNTER /= 0))  THEN 
			COUNTER := COUNTER - 1;
		END IF;

		SAIDA <= std_logic_vector(to_unsigned(COUNTER, COUNT'LENGTH));
		
		IF (COUNTER = CNT_W) THEN
			COMP_EQ <= '1';
		ELSE
			COMP_EQ <= '0';
		END IF;

	END PROCESS;
end logica;
