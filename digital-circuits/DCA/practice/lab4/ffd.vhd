--=============--
-- FLIP-FLOP D --
--=============--

entity ffd is
    port(clk, D: in bit;
        q: out bit);
end ffd;

architecture logic of ffd is
    
    signal qS: bit;

begin
process(clk)
begin
    if clk = '1' and clk'event then 
        qS <= D;
    end if;
end process;
q<=qS;
end logic;