--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
            -- M U X    2 x 1    L O G I C O
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
entity MUX2x1logico is
  port(I0, I1, S: in bit;
          O: out bit);
end MUX2x1logico;

architecture hardware of MUX2x1logico is

begin
  -- saida
  O <= (I0 and (not S)) or (I1 and S);

end hardware;

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
  -- M U X    2 x 1    C O M P O R T A M E N T A L
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
entity MUX2x1comp is
  port(I0, I1, S: in bit;
          O: out bit);
end MUX2x1comp;

architecture hardware of MUX2x1comp is

begin
  -- saida
  with S select
    O <= I0 when '0', I1 when '1';
end hardware;

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
  -- M U X    4 x 1    C O M P O R T A M E N T A L 
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
entity MUX4x1comp is
    port(I0, I1, I2, I3: in bit;
            S: in bit_vector(1 downto 0);
            O: out bit);
  end MUX4x1comp;
  
  architecture hardware of MUX4x1comp is
  
  begin
    -- saida
    with S select
      O <= I0 when "00",
        I1 when "01",
        I2 when "10",
        I3 when OTHERS;
  end hardware;
  
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
    -- M U X    4 x 1    C O M P O R T A M E N T A L 2
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
  entity MUX4x1comp2 is
    port(
      I: in bit_vector(3 downto 0);
      S: in bit_vector(1 downto 0);
      O: out bit
    );
  end MUX4x1comp2;
  
  architecture hardware of MUX4x1comp2 is
    
    component MUX2x1comp is
      port(I0, I1, S: in bit;
            O: out bit);
    end component;
  
    signal O1, O2: bit;
  
  begin
    -- saida
    
    M1: MUX2x1comp port map(I(0), I(1), S(0), O1);
    M2: MUX2x1comp port map(I(2), I(3), S(0), O2);
    M3: MUX2x1comp port map(O1, O2, S(1), O);
  
  end hardware;