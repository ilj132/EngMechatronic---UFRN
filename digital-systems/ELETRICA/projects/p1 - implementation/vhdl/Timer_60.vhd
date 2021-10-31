library ieee;
use ieee.std_logic_1164.all;

entity Timer_60 is
port (
	clk, b_on, b_play, b_next, b_back	 :	in std_logic;
	timer60s :	out std_logic
);
end Timer_60;

architecture hardware of Timer_60 is
begin
process(clk)
variable counter	:	integer range 0 to 80;

begin
	if (clk = '1' and b_on = '0' and b_play = '0' and b_next = '0' and b_back = '0') then
		counter := counter + 1;
	elsif (b_on = '1' or b_play = '1' or b_next = '1' or b_back = '1') then
		counter := 0;
		
	end if;

	if (counter > 59 and counter < 61) then
		timer60s <= '1';
	else
		timer60s <= '0';
	end if;

end process;
end hardware;
