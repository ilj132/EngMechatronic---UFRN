entity SUB_4B is
    port (
        A, B: in bit_vector(3 downto 0);
        O: out bit_vector(3 downto 0);
        cout: out bit
    );
end SUB_4B;

architecture logic of SUB_4B is

    component full_add
    port (
        A, B, cin: in bit;
        S, cout: out bit
    );
    end component;

signal carry: bit_vector(2 downto 0);
signal AUX_B: bit_vector(3 downto 0);

begin
    AUX_B <= not B;

    S0: full_add port map(A(0), AUX_B(0), '1', O(0), carry(0));
    S1: full_add port map(A(1), AUX_B(1), carry(0), O(1), carry(1));
    S2: full_add port map(A(2), AUX_B(2), carry(1), O(2), carry(2));
    S3: full_add port map(A(3), AUX_B(3), carry(2), O(3), cout);
end logic;

