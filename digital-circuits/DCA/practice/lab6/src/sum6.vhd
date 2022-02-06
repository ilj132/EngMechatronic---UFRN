entity somador6bits is
    port(
        A,B: in bit_vector (5 downto 0);
        O: out bit_vector (5 downto 0);
        cout: out bit
    );
    end somador6bits;

    architecture logic of somador6bits is
        component somador3bits is
            port(
                A, B: in bit_vector(2 downto 0);
                O: out bit_vector(2 downto 0);
                cout: out bit
            );
        end component;

        signal RES0,RES1,RES2,RES3: bit_vector(2 downto 0);
        signal carry: bit_vector(1 downto 0);
    begin

        S0: somador3bits port map(A(2 downto 0), B(2 downto 0), RES1, RES0(0));
        S1: somador3bits port map(A(5 downto 3), RES0, RES2, carry(0));
        S2: somador3bits port map(RES2, B(5 downto 3), RES3, carry(1));

        cout <= RES0(0) or carry(1);
        O(2 downto 0) <= RES1;
        O(5 downto 3) <= RES3;

    end logic;