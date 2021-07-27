library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity s_ram is
port (clk,en,memory,rw: in std_logic ;
	addr : in std_logic_vector (3 downto 0);
	datain : in std_logic_vector (7 downto 0);
	dataout : out std_logic_vector (7 downto 0));
end s_ram ;

architecture logica of s_ram is

type ram is array (0 to 9) of std_logic_vector (7 downto 0);

signal memoria : ram := ( x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00");
signal r_addr : std_logic_vector (3 downto 0);


begin

process ( clk )
	begin
		
			if (clk'event and clk = '1' and en = '1' and memory = '1' and rw = '1') then
				memoria ( to_integer ( unsigned ( addr ))) <= datain;
			elsif (clk'event and clk = '1' and en = '1' and memory = '1' and rw = '0') then
				--dataout <= memoria (to_integer(unsigned(addr)));
				r_addr <= addr;
			end if;

		dataout <= memoria (to_integer(unsigned(r_addr)));
end process ;
 
end logica ;
