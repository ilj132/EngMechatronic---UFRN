library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity s_ram is
port ( 
clk 		: in std_logic ;
en 		: in std_logic ;
rw			: in std_logic ;
addr 		: in std_logic_vector (3 downto 0);
datain 	: in std_logic_vector (7 downto 0);
dataout 	: out std_logic_vector (7 downto 0));
end s_ram ;

architecture logica of s_ram is

type ram is array (0 to 9) of std_logic_vector (7 downto 0);
signal memoria : ram ; 
signal r_addr : std_logic_vector (0 to 3);

begin

process ( clk )
	begin
		if rising_edge ( clk ) then
			if (en = '1' and rw = '1') then
				memoria ( to_integer ( unsigned ( addr ))) <= datain;
			elsif (en = '1' and rw = '0') then
				--r_addr <= addr ;
				dataout <= memoria (to_integer(unsigned(addr)));
			end if;
		end if;
end process ;
		--dataout <= memoria (to_integer(unsigned(r_addr)));
end logica ;
