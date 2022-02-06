entity hald_add is
    port (
        A, B: in bit;
        S, cout: out bit
    );
end hald_add;
  
architecture logic of hald_add is
  
begin
    S <= A xor B;
    cout <= A and B;
end logic;