entity MUX21 is
    port(I0, I1, S: in bit;
         O: out bit
         );
   end MUX21;
   
   architecture logic of MUX21 is
   
   begin
     -- saida
     with S select
       O <= I0 when '0', I1 when '1';
   end logic;