library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--=====================--
-- DISPLAY 7 SEGMENTOS --
--=====================--

entity D7SEG is
   port (I: in std_logic_vector (3 downto 0);	
		O: out std_logic_vector (6 downto 0));	-- Vetor de saidas, com 7 posicoes, que representa os 7 segmentos do display que serão acesos 
end D7SEG;

architecture logic of D7SEG is
   signal A, B, C, D, NA, NB, NC, ND: std_logic;
begin
   A <= I(3);
   B <= I(2);
   C <= I(1);
   D <= I(0);

   NA <= not A;
   NB <= not B;
   NC <= not C;
   ND <= not D;
 
   O(0) <= C or A or (NB and ND) or (B and D);
   
   O(1) <= NB or (NC and ND) or (C and D);
   
   O(2) <= NC or D or B;

   O(3) <= (NB and ND) or (NB and C) or (C and ND) or (B and NC and D);

   O(4) <= (NB and ND) or (C and ND);

   O(5) <= A or (NC and ND) or (B and NC) or (B and ND);

   O(6) <= A or (NB and C) or (C and ND) or (B and NC);

end logic;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--===============--
-- BLOCO Bin-BCD --
--===============--

entity bloco_bin_bcd is
   port (A: in std_logic_vector (3 downto 0);
		S: out std_logic_vector(3 downto 0));
end bloco_bin_bcd;

architecture logic of bloco_bin_bcd is
begin

   S(0) <= (A(3) and (not A(0))) or ((not A(3)) and (not A(2)) and A(0)) or (A(2) and A(1) and (not A(0)));

   S(1) <= ((not A(2)) and A(1)) or (A(1) and A(0)) or (A(3) and (not A(0))); 

   S(2) <= (A(3) and A(0)) or (A(2) and (not A(1)) and (not A(0)));

   S(3) <= A(3) or (A(2) and A(0)) or (A(2) and A(1));

end logic;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--=================================--
-- DECODIFICADOR Bin-BCD (8 std_logics) --
--=================================--

entity decod_bcd_8bit is
	port(bin: in std_logic_vector(5 downto 0);
		bcd: out std_logic_vector (7 downto 0));
end decod_bcd_8bit;

architecture logic of decod_bcd_8bit is

component bloco_bin_bcd
	port(A: in std_logic_vector(3 downto 0);
			S: out std_logic_vector(3 downto 0));
end component;

	signal B1_A, B1_S, B2_A, B2_S, B3_A, B3_S, B4_A, B4_S, 
		B5_A, B5_S, B6_A, B6_S, B7_A, B7_S: std_logic_vector(3 downto 0);

begin
	B1_A(3) <= '0';
	B1_A(2) <= '0';
	B1_A(1) <= '0';
	B1_A(0) <= bin(5);
	
	B1: bloco_bin_bcd port map(B1_A, B1_S);
	
	B2_A(3) <= B1_S(2);
	B2_A(2) <= B1_S(1);
	B2_A(1) <= B1_S(0);
	B2_A(0) <= bin(4);
	
	B2: bloco_bin_bcd port map(B2_A, B2_S);
	
	B3_A(3) <= B2_S(2);
	B3_A(2) <= B2_S(1);
	B3_A(1) <= B2_S(0);
	B3_A(0) <= bin(3);
	
	B3: bloco_bin_bcd port map(B3_A, B3_S);
	
	B4_A(3) <= B3_S(2);
	B4_A(2) <= B3_S(1);
	B4_A(1) <= B3_S(0);
	B4_A(0) <= bin(2);
	
	B4: bloco_bin_bcd port map(B4_A, B4_S);
	
	B5_A(3) <= '0';
	B5_A(2) <= B1_S(3);
	B5_A(1) <= B2_S(3);
	B5_A(0) <= B3_S(3);
	
	B5: bloco_bin_bcd port map(B5_A, B5_S);
	
	B6_A(3) <= B4_S(2);
	B6_A(2) <= B4_S(1);
	B6_A(1) <= B4_S(0);
	B6_A(0) <= bin(1);
	
	B6: bloco_bin_bcd port map(B6_A, B6_S);
	
	B7_A(3) <= B5_S(2);
	B7_A(2) <= B5_S(1);
	B7_A(1) <= B5_S(0);
	B7_A(0) <= B4_S(3);
	
	B7: bloco_bin_bcd port map(B7_A, B7_S);
	
	
	bcd(7) <= B7_S(2);
	bcd(6) <= B7_S(1);
	bcd(5) <= B7_S(0);
	bcd(4) <= B6_S(3);
	bcd(3) <= B6_S(2);
	bcd(2) <= B6_S(1);
	bcd(1) <= B6_S(0);
	bcd(0) <= bin(0);
	
end logic;