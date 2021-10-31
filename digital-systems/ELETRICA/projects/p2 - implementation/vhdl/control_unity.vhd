library ieee;
use ieee.std_logic_1164.all;

entity CONTROL_UNITY is
	port (DATA : in std_logic_vector(15 downto 0);
		RST, CLK, ULA_Z, ULA_CARRY : in std_logic;
		MEM_ADDR, D_ADDR: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); 
		W_ADDR, RP_ADDR, RQ_ADDR: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		ULA_SW : out std_logic_vector(2 downto 0);
		D_RD, D_WR, MUX_SW, W_WR, RP_RD, RQ_RD: OUT STD_LOGIC
	);
end CONTROL_UNITY; 	

architecture logica of CONTROL_UNITY is

	COMPONENT PC is
		port( PC_clr, PC_inc, PC_ld : in STD_LOGIC;
			clk : in STD_LOGIC;
			IR : in STD_LOGIC_VECTOR(7 downto 0);
			IR_out : out STD_LOGIC_VECTOR(7 downto 0));
	end COMPONENT;

	COMPONENT IR is
        port( data : in std_logic_vector(15 downto 0);
            clk, clr, en_IR : in std_logic;
            O: out std_logic_vector(15 downto 0));
    end COMPONENT;

	COMPONENT T_DATA is
	    PORT(IR: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	    	PULO, D_ADDR: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    	W_ADDR, RP_ADDR, RQ_ADDR: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	    	IR_HLT, IR_LDR, IR_STR, IR_MOV, IR_ADD, IR_SUB, IR_AND, IR_OR, IR_NOT, IR_XOR, IR_CMP, IR_JMP, IR_JNC, IR_JC, IR_JNZ, IR_JZ: OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT BLOCKCON is
	    port(CLK, RST, IR_HLT, IR_LDR, IR_STR, IR_MOV, IR_ADD, IR_SUB, IR_AND, IR_OR, IR_NOT, IR_XOR, IR_CMP, IR_JMP, IR_JNC, IR_JC, IR_JNZ, IR_JZ, ULA_Z, ULA_CARRY : in std_logic;
			W_WR, RP_RD, RQ_RD, MUX_SW, D_RD, D_WR, PC_CLR, ENABLE, PC_LD: out std_logic;
			ULA_SW: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
	end COMPONENT;

	signal PC_clr, PC_ld, EN : std_logic;
	signal PULO: std_logic_vector(7 downto 0);
	signal IR_DATA : std_logic_vector(15 downto 0);

	signal IR_HLT, IR_LDR, IR_STR, IR_MOV, IR_ADD, IR_SUB, IR_AND, 
		IR_OR, IR_NOT, IR_XOR, IR_CMP, IR_JMP, IR_JNC, IR_JC, IR_JNZ, IR_JZ : std_logic;


	begin

		DEF_OUT: BLOCKCON PORT MAP(CLK, RST, IR_HLT, IR_LDR, IR_STR, IR_MOV, IR_ADD, IR_SUB, IR_AND, IR_OR, 
				IR_NOT, IR_XOR, IR_CMP, IR_JMP, IR_JNC, IR_JC, IR_JNZ, IR_JZ, ULA_Z, ULA_CARRY,W_WR, RP_RD,
				RQ_RD, MUX_SW, D_RD, D_WR, PC_CLR, EN, PC_ld, ULA_SW);

		DEF_PC: PC PORT MAP(PC_clr, EN, PC_ld, CLK, PULO, MEM_ADDR);

		DEF_IR: IR PORT MAP(DATA, CLK, RST, EN, IR_DATA);

		DEF_DATA: T_DATA PORT MAP(IR_DATA, PULO, D_ADDR, W_ADDR, RP_ADDR, RQ_ADDR, IR_HLT, IR_LDR, IR_STR, IR_MOV, IR_ADD, IR_SUB, IR_AND, IR_OR, IR_NOT, IR_XOR, IR_CMP, IR_JMP, IR_JNC, IR_JC, IR_JNZ, IR_JZ);

	
	end logica;