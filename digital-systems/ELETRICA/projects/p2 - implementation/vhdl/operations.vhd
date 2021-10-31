

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
        -- M E I O    S O M A D O R
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
library ieee;
use ieee.std_logic_1164.all;

entity HALF_ADD is
    port(A, B: in STD_LOGIC;
            S, CO: out STD_LOGIC);
  end HALF_ADD;
  
  architecture hardware of HALF_ADD is
  
  begin
    S <= A xor B;
    CO <= A and B;
  end hardware;
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
        -- S O M A D O R    C O M P L E T O
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
  library ieee;
  use ieee.std_logic_1164.all;

  entity COMP_ADD is
    port(A, B, CI: in STD_LOGIC;
            S, CO: out STD_LOGIC);
  end COMP_ADD;
  
  architecture hardware of COMP_ADD is
  
  begin
    S <= A xor B xor CI;
    CO <= (B and CI) or (A and CI) or (A and B);
  end hardware;
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
        -- S O M A D O R    D E     8   B I T S
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
  library ieee;
  use ieee.std_logic_1164.all;

  entity ADD8 is
    port(A, B: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0);
            CO: out STD_LOGIC);
  end ADD8;
  
  architecture hardware of ADD8 is
  
  component HALF_ADD is
    port(A, B: in STD_LOGIC;
        S, CO: out STD_LOGIC);
  end component;
  
  component COMP_ADD
    port(A, B, CI: in STD_LOGIC;
            S, CO: out STD_LOGIC);
  end component;
  
  signal VAI_UM: STD_LOGIC_VECTOR(6 downto 0);
  
  begin
    S0: HALF_ADD port map(A(0), B(0), O(0), VAI_UM(0));
    S1: COMP_ADD port map(A(1), B(1), VAI_UM(0), O(1), VAI_UM(1));
    S2: COMP_ADD port map(A(2), B(2), VAI_UM(1), O(2), VAI_UM(2));
    S3: COMP_ADD port map(A(3), B(3), VAI_UM(2), O(3), VAI_UM(3));
    S4: COMP_ADD port map(A(4), B(4), VAI_UM(3), O(4), VAI_UM(4));
    S5: COMP_ADD port map(A(5), B(5), VAI_UM(4), O(5), VAI_UM(5));
    S6: COMP_ADD port map(A(6), B(6), VAI_UM(5), O(6), VAI_UM(6));
    S7: COMP_ADD port map(A(7), B(7), VAI_UM(6), O(7), CO);
  end hardware;
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
        -- S U B T R A T O R    DE  8   B I T S
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
  library ieee;
  use ieee.std_logic_1164.all;

  entity SUB is
    port(A, B: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0);
            CO, Z: out STD_LOGIC);
  end SUB;
  
  architecture hardware of SUB is
  
  component COMP_ADD
    port(A, B, CI: in STD_LOGIC;
            S, CO: out STD_LOGIC);
  end component;
  
  signal VAI_UM: STD_LOGIC_VECTOR(6 downto 0);
  signal AUX_B: STD_LOGIC_VECTOR(7 downto 0);
  
  begin
    -- Como Ã© subtrator, entÃ£o inverte B e soma 1 (VAI_UM='1'). (Complemento de 2: A-B=A+B'+1)
  
    AUX_B(0) <= not B(0);
    AUX_B(1) <= not B(1);
    AUX_B(2) <= not B(2);
    AUX_B(3) <= not B(3);
    AUX_B(4) <= not B(4);
    AUX_B(5) <= not B(5);
    AUX_B(6) <= not B(6);
    AUX_B(7) <= not B(7);
  
    S0: COMP_ADD port map(A(0), AUX_B(0), '1', O(0), VAI_UM(0));
    S1: COMP_ADD port map(A(1), AUX_B(1), VAI_UM(0), O(1), VAI_UM(1));
    S2: COMP_ADD port map(A(2), AUX_B(2), VAI_UM(1), O(2), VAI_UM(2));
    S3: COMP_ADD port map(A(3), AUX_B(3), VAI_UM(2), O(3), VAI_UM(3));
    S4: COMP_ADD port map(A(4), AUX_B(4), VAI_UM(3), O(4), VAI_UM(4));
    S5: COMP_ADD port map(A(5), AUX_B(5), VAI_UM(4), O(5), VAI_UM(5));
    S6: COMP_ADD port map(A(6), AUX_B(6), VAI_UM(5), O(6), VAI_UM(6));
    S7: COMP_ADD port map(A(7), AUX_B(7), VAI_UM(6), O(7), CO);
  end hardware ;
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
                -- A N D
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
  library ieee;
  use ieee.std_logic_1164.all;

  entity AND8 is
    port(A, B: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0));
  end AND8;
  
  architecture hardware of AND8 is
  
  begin 
    O(0) <= A(0) and B(0);
    O(1) <= A(1) and B(1);
    O(2) <= A(2) and B(2);
    O(3) <= A(3) and B(3);
    O(4) <= A(4) and B(4);
    O(5) <= A(5) and B(5);
    O(6) <= A(6) and B(6);
    O(7) <= A(7) and B(7);
  end hardware;
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
                -- O R
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
  library ieee;
  use ieee.std_logic_1164.all;

  entity OR8 is
    port(A, B: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0));
  end OR8;
  
  architecture hardware of OR8 is
  
  begin
    O(0) <= A(0) or B(0);
    O(1) <= A(1) or B(1);
    O(2) <= A(2) or B(2);
    O(3) <= A(3) or B(3);
    O(4) <= A(4) or B(4);
    O(5) <= A(5) or B(5);
    O(6) <= A(6) or B(6);
    O(7) <= A(7) or B(7);
  end hardware;
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
                -- X O R
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
  library ieee;
  use ieee.std_logic_1164.all;

  entity XOR8 is
    port(A, B: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0));
  end XOR8;
  
  architecture hardware of XOR8 is
  
  begin
    O(0) <= A(0) xor B(0);
    O(1) <= A(1) xor B(1);
    O(2) <= A(2) xor B(2);
    O(3) <= A(3) xor B(3);
    O(4) <= A(4) xor B(4);
    O(5) <= A(5) xor B(5);
    O(6) <= A(6) xor B(6);
    O(7) <= A(7) xor B(7);
  end hardware;
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
                -- N O T
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
  library ieee;
  use ieee.std_logic_1164.all;

  entity NOT8 is
    port(A: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0));
  end NOT8;
  
  architecture hardware of NOT8 is
  
  begin
    O(0) <= not A(0);
    O(1) <= not A(1);
    O(2) <= not A(2);
    O(3) <= not A(3);
    O(4) <= not A(4);
    O(5) <= not A(5);
    O(6) <= not A(6);
    O(7) <= not A(7);
  end hardware;
  
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=---
  --=-=-comparador de magnitude para 8 STD_LOGICs-=-=--
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=---
  library ieee;
  use ieee.std_logic_1164.all;

  entity CMP is
    port(A, Q: in STD_LOGIC_VECTOR(7 downto 0);
     AigualQ: OUT STD_LOGIC_VECTOR(7 downto 0));
  end CMP;
    
    architecture main of CMP is
    
    
    signal A0eqQ0, A1eqQ1, A2eqQ2, A3eqQ3, A4eqQ4, A5eqQ5, A6eqQ6, A7eqQ7: STD_LOGIC;
    signal AeqQ: STD_LOGIC;
    
    begin
  
    A0eqQ0 <= (not(A(0) XOR Q(0)));
    A1eqQ1 <= (not(A(1) XOR Q(1)));
    A2eqQ2 <= (not(A(2) XOR Q(2)));
    A3eqQ3 <= (not(A(3) XOR Q(3)));
    
    A4eqQ4 <= (not(A(4) XOR Q(4)));
    A5eqQ5 <= (not(A(5) XOR Q(5)));
    A6eqQ6 <= (not(A(6) XOR Q(6)));
    A7eqQ7 <= (not(A(7) XOR Q(7)));
    
    AeqQ <= (A0eqQ0 AND A1eqQ1 AND A2eqQ2 AND A3eqQ3 AND A4eqQ4 AND A5eqQ5 AND A6eqQ6 AND A7eqQ7);
    
    AigualQ(0) <= AeqQ;
    AigualQ(7 downto 1) <= "0000000";
    
    end main;
    
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
            -- B I T    Z E R O
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
  library ieee;
  use ieee.std_logic_1164.all;

  entity ZERO is                          -- Checar se o vetor de saÃ­da da ULA Ã© nulo                    
    port(O: in STD_LOGIC_VECTOR(7 downto 0);
            Z: out STD_LOGIC);
  end ZERO;
  
  architecture hardware of ZERO is
  
  component NOT8 is
    port(A: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0));
  end component;
  
  signal NO: STD_LOGIC_VECTOR(7 downto 0);
  
  begin
    
    NOT_O: NOT8 port map(O, NO);
  
    Z <= (NO(0) and NO(1) and NO(2) and NO(3) and 
         NO(4) and NO(5) and NO(6) and NO(7));
  
  end hardware;