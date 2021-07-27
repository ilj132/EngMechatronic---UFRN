library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CONT_ESC is
	port (CLK,LOAD,CLEAR: IN STD_LOGIC;
		SAIDA: OUT STD_LOGIC_VECTOR (4 DOWNTO 0));
end entity;

architecture logica of CONT_ESC is

	SIGNAL COUNT : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL S_COUNT : INTEGER RANGE 0 TO 24;

begin
	PROCESS (CLK)
	VARIABLE COUNTER : INTEGER RANGE 0 TO 24;
	BEGIN 
		IF (CLEAR = '1') THEN
			COUNTER := 0;
		ELSIF (CLK = '1' and CLK'event AND LOAD = '1' AND COUNTER < 24)  THEN 
			COUNTER := COUNTER + 1;
		END IF;
		S_COUNT <= COUNTER;
	END PROCESS;
	SAIDA <= std_logic_vector(to_unsigned(S_COUNT, COUNT'LENGTH));
end logica;