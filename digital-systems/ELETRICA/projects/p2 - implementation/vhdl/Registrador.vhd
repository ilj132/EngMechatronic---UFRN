library ieee;
use ieee.std_logic_1164.all;

entity reg1 is 
	port( clk, D, reset, en : in STD_LOGIC;
			      S : out STD_LOGIC);
end reg1;

architecture ckt of reg1 is

component FFD2 is
	port( clk, D, P, C : in STD_LOGIC;
			en : in STD_LOGIC;
		     q, qn : out STD_LOGIC);
end component;

signal q, qn : STD_LOGIC;

begin
	FFD1 : FFD2 port map(clk, D, '0', reset, en, q, qn);
	S <= q;
end ckt;