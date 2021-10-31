library ieee;
use ieee.std_logic_1164.all;

entity Timers_2_5 is
port (
	clk, b_on 	:	in std_logic;
	timer2s, timer5s:	out std_logic
);
end Timers_2_5;

architecture hardware of Timers_2_5 is
begin
process(clk, b_on)
variable counter	:	integer range 0 to 5;
begin
	if (clk = '1' and b_on = '1') then
		counter := counter + 1;
	elsif (b_on = '0') then
		counter := 0;
		
	end if;

	if (counter > 1 and counter < 4) then
		timer2s <= '1';
	else timer2s <= '0';
	end if;

	if (counter = 4) then
		timer5s <= '1';
	else timer5s <= '0';
	end if;


end process;
end hardware;