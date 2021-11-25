entity AND_3 is 
  port(A, B, C: in bit;
  S: out bit);
end AND_3;

architecture logic of AND_3 is

  begin
    S <= A and B and C;
end logic;