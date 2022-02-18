entity REG4 is
	port(A: in bit_vector(3 downto 0);
		ld, clk, clr: in bit;
		S: out bit_vector(3 downto 0));
end REG4;

architecture logic of REG4 is

component MUX21 is
	port(I0, I1, S: in bit;
         O: out bit
         );
end component;

component ffd is
	port ( clk ,D ,P , C : IN BIT;
		q: OUT BIT );
END component;
  
SIGNAL CLEAR: BIT;
  signal D, Q:bit_vector (3 downto 0);
  
  begin
  
    CLEAR <= NOT clr;

  MUX1: MUX21 port map (Q(0), A(0), ld, D(0));
  MUX2: MUX21 port map (Q(1), A(1), ld, D(1));
  MUX3: MUX21 port map (Q(2), A(2), ld, D(2));
  MUX4: MUX21 port map (Q(3), A(3), ld, D(3));
  
  FFD1: ffd port map (clk, D(0), '1', CLEAR, Q(0));
  FFD2: ffd port map (clk, D(1), '1', CLEAR, Q(1));
  FFD3: ffd port map (clk, D(2), '1', CLEAR, Q(2));
  FFD4: ffd port map (clk, D(3), '1', CLEAR, Q(3));
  
  S<=Q;
  
end logic;