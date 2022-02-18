entity half_add is
    port (
        A, B: in bit;
        S, cout: out bit
    );
end half_add;

architecture logic of half_add is
    
begin
    S <= A xor B;
    cout <= A and B;
end logic;
    