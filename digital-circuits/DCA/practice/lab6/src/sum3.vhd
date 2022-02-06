entity somador3bits is
    port (
      A, B: in bit_vector(2 downto 0);
      O: out bit_vector(2 downto 0);
      cout: out bit
    );
end somador3bits;
   
architecture logic of somador3bits is
  
component hald_add is
    port (
        A, B: in bit;
        S, cout: out bit
    );
end component;
  
component full_add
    port (
        A, B, cin: in bit;
        S, cout: out bit
    );
end component;
  
signal carry: bit_vector(1 downto 0);
  
begin
    S0: hald_add port map(A(0), B(0), O(0), carry(0));
    S1: full_add port map(A(1), B(1), carry(0), O(1), carry(1));
    S2: full_add port map(A(2), B(2), carry(1), O(2), cout);
end logic;