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
        process(clk, en, clr)
        variable counter: integer range 0 to 10;
        begin
            if(en='1' and clk = '1') then
                counter := counter + 1;
            --elsif (en = '0') then
                --counter := 0;
            end if;

            if (counter = 10) then
                b_block <= '1';
            else b_block <= '0';
            end if;

            if(clr = '1') then
                counter:= 0;
            end if;

            o <= std_logic_vector(to_unsigned(counter, o'length));
        end process;
end logic;