--====================--
-- REGISTRADOR 4 BITS --
--====================--

entity reg4 is
    port(clk, I0, I1, I2, I3: in bit;
        Q0, Q1, Q2, Q3: out bit);
end reg4;

architecture logic of reg4 is

    component ffd is
        port(clk, D: in bit;
            q: out bit);
    end component;

begin

    ffd0: ffd port map(clk, I0, Q0);
    ffd1: ffd port map(clk, I1, Q1);
    ffd2: ffd port map(clk, I2, Q2);
    ffd3: ffd port map(clk, I3, Q3);

end logic;