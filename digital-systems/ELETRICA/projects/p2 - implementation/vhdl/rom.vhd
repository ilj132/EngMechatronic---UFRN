library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MEM_INST is
    port (
        clk : in std_logic ;
        addr : in std_logic_vector ( 7 downto 0);
        data : out std_logic_vector (15 downto 0));
end MEM_INST;

architecture ckt of MEM_INST is
    type memoria_rom is array (0 to 255) of std_logic_vector (15 downto 0);
    signal ROM : memoria_rom := (0 => X"1000",
                                1 => X"1101",
                                2 => X"1202",
                                3 => X"1303",
                                4 => X"1404",
                                5 => X"5530",
                                6 => X"4664",
                                7 => X"4662",
                                8 => X"5551",
                                9 => X"4774",
                                10 => X"5551",
                                11 => X"4774",
                                12 => X"4772",
                                13 => X"4552",
                                others => X"0000");
    begin
    process (clk) begin
        if rising_edge(clk) then
            data <= ROM(conv_integer(addr ));
        end if;
    end process ;
end ckt;