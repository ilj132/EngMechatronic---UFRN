--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
                -- U L A
  --=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--
  library ieee;
  use ieee.std_logic_1164.all;

  entity ULA is
    port(A, B: in STD_LOGIC_VECTOR(7 downto 0);
            S: in STD_LOGIC_VECTOR(2 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0);
            C, Z: out STD_LOGIC);
  end ULA;
  
  architecture hardware of ULA is
    
  -- Somador
  component ADD8 is
    port(A, B: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0);
            CO: out STD_LOGIC);
  end component;
  
  -- Subtrator
  component SUB is
    port(A, B: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0);
            CO: out STD_LOGIC);
  end component;
  
  -- AND8
  component AND8 is
    port(A, B: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0));
  end component;
  
  -- OR8
  component OR8 is
    port(A, B: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0));
  end component;
  
  -- XOR8
  component XOR8 is
    port(A, B: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0));
  end component;
  
  -- NOT8
  component NOT8 is
    port(A: in STD_LOGIC_VECTOR(7 downto 0);
            O: out STD_LOGIC_VECTOR(7 downto 0));
  end component;
  
  -- CMP_8STD_LOGICS
  component CMP is
    port(A, Q: in STD_LOGIC_VECTOR(7 downto 0);
     AigualQ: OUT STD_LOGIC_VECTOR(7 downto 0));
  end component;
  
  component MUX8 IS
  PORT(I0, I1, I2, I3, I4, I5, I6, I7: in STD_LOGIC;
    S: in STD_LOGIC_VECTOR(2 downto 0);
    O: out STD_LOGIC);
  END component;
  
  component MUX8_8 IS
  port(I0, I1, I2, I3, I4, I5, I6, I7: in STD_LOGIC_VECTOR(7 DOWNTO 0);
    S: in STD_LOGIC_VECTOR(2 downto 0);
    O: out STD_LOGIC_VECTOR(7 DOWNTO 0));
  END component;
  
  component ZERO is                  
    port(O: in STD_LOGIC_VECTOR(7 downto 0);
            Z: out STD_LOGIC);
  end component;
  
    signal O_ADD, O_SUB, O_AND8, O_OR8, O_XOR8, O_NOT8, O_CMP, O_AUX, AUX_CO, MOV: STD_LOGIC_VECTOR(7 downto 0); -- Resultado de cada operaÃ§Ã£o
    
  begin
  
    AUX_CO(7 downto 3)<= "00000";
    AUX_CO(0) <= '0';
    O<= O_AUX;

    SOMA: ADD8 port map(A, B, O_ADD, AUX_CO(1));
    SUBTRACAO: SUB port map(A, B, O_SUB, AUX_CO(2));
    PORTAAND: AND8 port map(A, B, O_AND8);
    PORTAOR: OR8 port map(A, B, O_OR8);
    PORTAXOR: XOR8 port map(A, B, O_XOR8);
    PORTANOT: NOT8 port map(A, O_NOT8);
    PORTCMP: CMP port map(A, B, O_CMP);
  
    SAIDA0: MUX8_8 port map(MOV, O_ADD, O_SUB, O_AND8, O_OR8, O_NOT8, O_XOR8, O_CMP,  S, O_AUX);
    
    CARRYOUT: MUX8 port map(AUX_CO(0), AUX_CO(1), AUX_CO(2), AUX_CO(3), AUX_CO(4), AUX_CO(5), AUX_CO(6), AUX_CO(7), S, C);
    CARRYZERO: ZERO port map(O_AUX, Z);
    
  end hardware;
  
  