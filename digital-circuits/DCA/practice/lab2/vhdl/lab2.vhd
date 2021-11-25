entity lab2 is
  port(A,B,C: in bit;
    S2, S1: out bit);
end lab2;

architecture logic of lab2 is

  component AND_3
    port(A, B, C: in bit;
      S: out bit);
  end component;

  component OR_4
    port(A, B, C, D: in bit;
      S: out bit);
  end component;

  signal sig1,sig2: bit_vector(3 downto 0);
  signal nA,nB,nC: bit;
  
begin
  
  nA <= NOT A;
  nB <= NOT B;
  nC <= NOT C;

  SIGNAL1: AND_3 port map(nA, nB, C, sig1(0));
  SIGNAL2: AND_3 port map(nA, B, nC, sig1(1));
  SIGNAL3: AND_3 port map(A, nB, nC, sig1(2));
  SIGNAL4: AND_3 port map(A, B, C, sig1(3));

  SAIDA1: OR_4 port map (sig1(0), sig1(1), sig1(2), sig1(3), S1); 

  SIGNAL5: AND_3 port map('1', B, C, sig2(0));
  SIGNAL6: AND_3 port map(A, '1', C, sig2(1));
  SIGNAL7: AND_3 port map(A, B, '1', sig2(2));

  SAIDA2: OR_4 port map(sig2(0), sig2(1), sig2(2), '0', S2);

end logic;