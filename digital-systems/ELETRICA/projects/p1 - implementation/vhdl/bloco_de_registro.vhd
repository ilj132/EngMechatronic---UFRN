library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.ALL;

entity blocor is
port (en, clk, rst_b, memory, rw: in std_logic;
	data_i: in std_logic_vector (7 downto 0);
	rec_block: out std_logic;
	data_o: out std_logic_vector(7 downto 0));
end entity;

architecture ckt of blocor is 
	component contador10 is
    	port(clk, en, clr:    in std_logic;
        	b_block: out std_logic;
        	o: out std_logic_vector (3 downto 0));
end component;
	component s_ram is 
		port (clk,en,memory,rw	 : in std_logic ;
			addr : in std_logic_vector (3 downto 0);
			datain : in std_logic_vector (7 downto 0);
			dataout : out std_logic_vector (7 downto 0));
end component;

 signal	sig_addr: std_logic_vector(3 downto 0);
 signal S_data_o : std_logic_vector(7 downto 0);


begin

z1: contador10 port map(clk,en,rst_b,rec_block,sig_addr);

z2: s_ram port map (clk,en,memory,rw,sig_addr,data_i,  dataout => data_o);

	
end ckt;