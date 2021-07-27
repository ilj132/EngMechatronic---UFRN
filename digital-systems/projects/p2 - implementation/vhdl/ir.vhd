library ieee;
use ieee.std_logic_1164.all;

entity IR is
	port( data : in std_logic_vector(15 downto 0);
		clk, clr, en_IR : in std_logic;
		O: out std_logic_vector(15 downto 0));
end IR;

architecture ckt of IR is

component FFD2 is
	port( clk, D, P, C : in STD_LOGIC;
			  en : in STD_LOGIC;
		    q, qn : out STD_LOGIC);
end component;


COMPONENT MUX21_16 is
	port (A, B : in STD_LOGIC_VECTOR(15 downto 0);
		  S: in STD_LOGIC;
		  O: out STD_LOGIC_VECTOR(15 downto 0));
end COMPONENT;


signal Q, D, qn: std_logic_vector(15 downto 0);


begin
	
	M0: MUX21_16 port map(Q, data, en_IR, D);
	
   	FFD0: FFD2 PORT MAP (clk, D(0),   '0', clr, en_IR,Q(0), qn(0));
    FFD1: FFD2 PORT MAP (clk, D(1),   '0', clr, en_IR,Q(1), qn(1));
    FFD_2: FFD2 PORT MAP (clk, D(2),  '0', clr, en_IR,Q(2), qn(2));
    FFD3: FFD2 PORT MAP (clk, D(3),   '0', clr, en_IR,Q(3), qn(3));
    FFD4: FFD2 PORT MAP (clk, D(4),   '0', clr, en_IR,Q(4), qn(4));
    FFD5: FFD2 PORT MAP (clk, D(5),   '0', clr, en_IR,Q(5), qn(5));
    FFD6: FFD2 PORT MAP (clk, D(6),   '0', clr, en_IR,Q(6), qn(6));
    FFD7: FFD2 PORT MAP (clk, D(7),   '0', clr, en_IR,Q(7), qn(7));
    FFD8: FFD2 PORT MAP (clk, D(8),   '0', clr, en_IR,Q(8), qn(8));
    FFD9: FFD2 PORT MAP (clk, D(9),   '0', clr, en_IR,Q(9), qn(9));
    FFD10: FFD2 PORT MAP (clk, D(10), '0', clr, en_IR,Q(10), qn(10));
    FFD11: FFD2 PORT MAP (clk, D(11), '0', clr, en_IR,Q(11), qn(11));
    FFD12: FFD2 PORT MAP (clk, D(12), '0', clr, en_IR,Q(12), qn(12));
    FFD13: FFD2 PORT MAP (clk, D(13), '0', clr, en_IR,Q(13), qn(13));
    FFD14: FFD2 PORT MAP (clk, D(14), '0', clr, en_IR,Q(14), qn(14));
    FFD15: FFD2 PORT MAP (clk, D(15), '0', clr, en_IR,Q(15), qn(0));
	
	O (15 downto 0)<= Q(15 downto 0);
	
end ckt;