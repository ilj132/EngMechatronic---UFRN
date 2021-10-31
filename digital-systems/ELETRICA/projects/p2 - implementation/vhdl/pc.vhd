library ieee;
use ieee.std_logic_1164.all;

entity PC is
	port( PC_clr, PC_inc, PC_ld : in STD_LOGIC;
				clk : in STD_LOGIC;
				 IR : in STD_LOGIC_VECTOR(7 downto 0);
			     IR_out : out STD_LOGIC_VECTOR(7 downto 0));
end PC;

architecture ckt of PC is

	component MUX21_8
	port (A, B : in STD_LOGIC_VECTOR(7 downto 0);
		  S: in STD_LOGIC;
		  O: out STD_LOGIC_VECTOR(7 downto 0));
	end component;

	component reg1 is 
	port( clk, D, reset, en : in STD_LOGIC;
			      S : out STD_LOGIC);
	end component;
	
	component somador8bits is
	port( A, B: in STD_LOGIC_VECTOR(7 downto 0);
		O: out STD_LOGIC_VECTOR(7 downto 0);
		Carry: out STD_LOGIC
	);
	end component;
	
	
	signal en_reg, clr_reg, outSomador : STD_LOGIC;
	signal out_soma, out_reg, out_mux : STD_LOGIC_VECTOR(7 downto 0);
	
	begin
		en_reg <= PC_inc OR PC_ld;
		
		M0: MUX21_8 port map (out_soma, IR, PC_ld, out_mux);
		R0: reg1 port map (clk, out_mux(0), PC_clr, en_reg, out_reg(0));
		R1: reg1 port map (clk, out_mux(1), PC_clr, en_reg, out_reg(1));
		R2: reg1 port map (clk, out_mux(2), PC_clr, en_reg, out_reg(2));
		R3: reg1 port map (clk, out_mux(3), PC_clr, en_reg, out_reg(3));
		R4: reg1 port map (clk, out_mux(4), PC_clr, en_reg, out_reg(4));
		R5: reg1 port map (clk, out_mux(5), PC_clr, en_reg, out_reg(5));
		R6: reg1 port map (clk, out_mux(6), PC_clr, en_reg, out_reg(6));
		R7: reg1 port map (clk, out_mux(7), PC_clr, en_reg, out_reg(7));
		S0: somador8bits port map (out_reg, "00000001", out_soma, outSomador);

	IR_out(7 downto 0) <= out_reg(7 downto 0); 
end ckt;
