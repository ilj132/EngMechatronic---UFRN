library ieee;
use ieee.std_logic_1164.all;

ENTITY CPU is
    PORT(RST, CLK: IN STD_LOGIC);
END CPU;


ARCHITECTURE CKT OF CPU is

    COMPONENT MEM_INST is
        port (
            clk : in std_logic ;
            addr : in std_logic_vector ( 7 downto 0);
            data : out std_logic_vector (15 downto 0));
    end COMPONENT;

    COMPONENT MEM_DATA is
        port (
          clk : in std_logic ;
          we : in std_logic ;
          addr : in std_logic_vector ( 7 downto 0);
          datai : in std_logic_vector (7 downto 0);
          datao : out std_logic_vector (7 downto 0));
      end COMPONENT;

    COMPONENT BLOCKOP IS 
        PORT(R_DATA: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            W_ADDR, RP_ADDR, RQ_ADDR: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            ULA_SW: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            CLK, MUX_SW, W_WR, RP_RD, RQ_RD,clr: IN STD_LOGIC;
            W_DATA, S: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            ULA_Z, ULA_CARRY: OUT STD_LOGIC);
    END COMPONENT;
COMPONENT CONTROL_UNITY is
        port (DATA : in std_logic_vector(15 downto 0);
            RST, CLK, ULA_Z, ULA_CARRY : in std_logic;
            MEM_ADDR, D_ADDR: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); 
            W_ADDR, RP_ADDR, RQ_ADDR: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            ULA_SW : out std_logic_vector(2 downto 0);
            D_RD, D_WR, MUX_SW, W_WR, RP_RD, RQ_RD: OUT STD_LOGIC);
    end COMPONENT; 

    SIGNAL DATA: STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL W_DATA, S, MEM_ADDR, D_ADDR, R_DATA: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL W_ADDR, RP_ADDR, RQ_ADDR: STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL ULA_SW: STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL D_WR, MUX_SW, W_WR, RP_RD, RQ_RD, ULA_Z, ULA_CARRY, D_RD, nMUX_SW: STD_LOGIC;


    BEGIN 
    
    nMUX_SW<=not MUX_SW;
        DADOS: MEM_DATA         PORT MAP(CLK, D_WR, D_ADDR, W_DATA, R_DATA);
        INST: MEM_INST          PORT MAP(CLK, MEM_ADDR, DATA);
        OP_BLOCK: BLOCKOP       PORT MAP(R_DATA, W_ADDR, RP_ADDR, RQ_ADDR, ULA_SW, CLK, nMUX_SW, W_WR, RP_RD, RQ_RD,RST,W_DATA, S, ULA_Z, ULA_CARRY);
        CONTROL: CONTROL_UNITY  PORT MAP(DATA, RST, CLK, ULA_Z, ULA_CARRY, MEM_ADDR, D_ADDR, W_ADDR, RP_ADDR, RQ_ADDR, ULA_SW, D_RD, D_WR, MUX_SW, W_WR, RP_RD, RQ_RD);
        

    END CKT;