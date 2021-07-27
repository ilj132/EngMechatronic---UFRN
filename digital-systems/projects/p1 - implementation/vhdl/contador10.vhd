library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador10 is
    port(clk, en, clr:    in std_logic;
        b_block: out std_logic;
        o: out std_logic_vector (3 downto 0));
end contador10;

architecture logic of contador10 is
    begin
        process(clk, clr)
        variable counter: integer range 0 to 9;
        begin

	    

            if(clr = '1' and clk'event and clk = '1') then
                counter := 0;
	    elsif (counter = 9 and clk'event and clk = '1' ) then
                counter := 0;
            elsif(en='1' and clk'event and clk = '1') then
                counter := counter + 1;
            end if;

            if (counter = 9 and clk'event and clk = '1') then
                b_block <= '1';
            else b_block <= '0';
            end if;

            o <= std_logic_vector(to_unsigned(counter, o'length));
        end process;
end logic;