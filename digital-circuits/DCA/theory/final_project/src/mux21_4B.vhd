entity MUX21_4B is
    port(I0, I1: in bit_vector(3 downto 0);
        S: in bit;
        O: out bit_vector(3 downto 0)
        );
   end MUX21_4B;
   
   architecture logic of MUX21_4B is
   
   begin
     -- saida
     with S select
       O <= I0 when '0', I1 when '1';
   end logic;