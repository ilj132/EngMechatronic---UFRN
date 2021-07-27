library ieee ;
use ieee.std_logic_1164.all;

--DE: DESLIGADO
--TI: TELA INICIAL
--RT: REPRODUÇÃO TOTAL
--RI:  REPRODUÇÃO INDIVIDUAL
--RE: REPOUSO
--OT: OUVIR TUDO
--OU: OUVIR UM
--RS: RESET
--GV: GRAVAR
--PR1: PROCESS_R1
--PR2: PROCESS_R2
--PW: PROCESS_W
--RC: RESET CONTADOR

entity mde_b is
    port ( CLK , RST , B_ON, PLAY, MU, COMP_EQ, REC, M, B_BLOCK, F, T60, T5, T2: in std_logic ;
        LED_O, LED_R, LED_P, RST_W, RST_R, RST_B, DISPLAY, HC_R, HC_W, MEMORY, RW: out std_logic );
end mde_b ;

architecture logica of mde_b is
    type state_type is (DE, TI, RT, RI, RE, OT, OU, RS, GV, PR1, PR2, PW, RC);
    signal y_present , y_next : state_type ;
begin
    process (B_ON, PLAY, MU, COMP_EQ, REC, M, B_BLOCK, F, T60, T5, T2, y_present )
    begin
        case y_present is
        when DE =>
            if B_ON = '0' then y_next <= DE;
            else y_next <= TI; end if;
        when TI =>
            if (B_ON = '0' and PLAY = '0' and MU = '0' and T60 = '0' and T5 = '0' and T2 = '0')  then y_next <= TI;
            elsif (B_ON = '0' and T5 = '0' and T2 = '1') then y_next <= RS;
            elsif (B_ON = '0' and T5 = '1' and T2 = '0') then y_next <= DE;
            elsif (B_ON = '0' and PLAY = '0' and MU = '0' and T60 = '1' and T5 = '0' and T2 = '0') then y_next <= RE;
            elsif (B_ON = '0' and PLAY = '0' and MU = '1' and M = '1' and T5 = '0' and T2 = '0') then y_next <= PR1;
            elsif (B_ON = '0' and PLAY = '1' and M = '1' and T5 = '0' and T2 = '0') then y_next <= RC;
            elsif (B_ON = '0' and M = '0' and T60 = '0' and T5 = '0' and T2 = '0') then y_next <= TI;
            elsif (B_ON = '1') THEN y_next <= RE; end if;
        when RT =>
            if (B_ON = '0' and COMP_EQ = '0') then y_next <= OT;
            elsif (B_ON = '0' and COMP_EQ = '1') then y_next <= TI;
            elsif (B_ON = '1') then y_next <= RE; end if;
        when RI =>
            if (B_ON = '0' and PLAY = '0' and MU = '0') then y_next <= RI;
            elsif (B_ON = '0' and PLAY = '0' and MU = '1') then y_next <= PR1 ;
            elsif (B_ON = '0' and PLAY = '1') then y_next <= OU ;
            elsif (B_ON = '1') then y_next <= RE; end if;
        when RE =>
            if (B_ON = '0' and REC = '0' and T5 = '0') then y_next <= RE;
            elsif (B_ON = '0' and REC = '0' and T5 = '1') then y_next <= DE;
            elsif (B_ON = '0' and REC = '1' and F = '0') then y_next <= GV;
            elsif (B_ON = '0' and REC = '1' and F = '1') then y_next <= RE;
            elsif (B_ON = '1' and REC = '0' and T5 = '0') then y_next <= TI;
            elsif (B_ON = '1' and REC = '1' and F = '0' and T5 = '0') then y_next <= GV;
            elsif (B_ON = '1' and REC = '1' and F = '1' and T5 = '0') then y_next <= TI; end if;
        when OT =>
            if B_BLOCK = '0' then y_next <= OT;
            else y_next <= PR2; end if;
        when OU =>
            if B_BLOCK = '0' then y_next <= OU;
            else y_next <= RI; end if;
        when RS =>
            y_next <= TI;
        when GV =>
            if B_BLOCK = '0' then y_next <= GV;
            else y_next <= PW; end if;
        when PR1 =>
            y_next <= RI;
        when PR2 =>
            y_next <= RT;
        when PW =>
            y_next <= RE;
        when RC =>
            y_next <= RT;
        end case;
    end process;
    
    process (CLK , RST )
    begin
        if RST = '1' then
            y_present <= DE ;
        elsif ( CLK'event and CLK = '1') then
            y_present <= y_next;
        end if;
    end process ;
    
    LED_O <= '0' when y_present = DE else '1';
    LED_R <= '1' when (y_present = GV) else '0';
    LED_P <= '1' when (y_present = RT or y_present = OT or y_present = OU or y_present = PR2 or y_present = RC) else '0';
    RST_W <= '1' when y_present = RS else '0';
    RST_R <= '1' when (y_present = RS or y_present = RC) else '0';
    RST_B <= '1' when (y_present = RT or y_present = RI or y_present = RS or y_present = PR1 or y_present = PR2 or y_present = RC) else '0';
    DISPLAY <= '0' when (y_present = DE or y_present = RE or y_present = GV or y_present = PW) else '1';
    HC_R <= '1' when (y_present = PR1 or y_present = PR2) else '0';
    HC_W <= '1' when y_present = PW else '0';
    MEMORY <= '1' when (y_present = OU or y_present = OT or y_present = GV) else '0';
    RW <= '1' when y_present = GV else '0';

end logica ;
