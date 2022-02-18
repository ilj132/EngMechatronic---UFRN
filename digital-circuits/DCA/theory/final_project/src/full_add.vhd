entity full_add is
    port (
        A, B, cin: in bit;
        S, cout: out bit
    );
end full_add;

architecture logic of full_add is

begin
    S <= A xor B xor cin;
    cout <= (B and cin) or (A and cin) or (A and B);
end logic;