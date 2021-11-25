entity OR_4 is 
  port(A, B, C, D: in bit;
  S: out bit);
end OR_4;

architecture logic of OR_4 is

  begin
    S <= A or B or C or D;
end logic;