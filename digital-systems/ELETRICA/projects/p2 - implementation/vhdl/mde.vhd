library ieee;
use ieee.std_logic_1164.all;

entity BLOCKCON is
    port(CLK, RST, IR_HLT, IR_LDR, IR_STR, IR_MOV, IR_ADD, IR_SUB, IR_AND, IR_OR, IR_NOT, IR_XOR, IR_CMP, IR_JMP, IR_JNC, IR_JC, IR_JNZ, IR_JZ, ULA_Z, ULA_CARRY : in std_logic;
		W_WR, RP_RD, RQ_RD, MUX_SW, D_RD, D_WR, PC_CLR, ENABLE, PC_LD: out std_logic;
		ULA_SW: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
);
end BLOCKCON;

architecture LOGICA of BLOCKCON is

	type st is (INICIO, BUSCA, DEC, S_HLT, S_LDR, S_STR, S_MOV, S_ADD, S_SUB, S_AND, S_OR, S_NOT, S_XOR, S_CMP, S_JMP, S_JNC, S_JC, S_JNZ, S_JZ);
	signal estado : st;

    begin
		process (CLK, RST)
		begin
	
	    	if RST = '1' then 
				estado <= INICIO;

	   		elsif (CLK'event AND CLK = '1') then
				case estado is

				when INICIO =>

					estado <= BUSCA;

				when BUSCA =>

					estado <= DEC;
			
				when DEC =>
					if    (IR_HLT = '1') then estado <= S_HLT;
					elsif (IR_LDR = '1') then estado <= S_LDR;
					elsif (IR_STR = '1') then estado <= S_STR;
					elsif (IR_MOV = '1') then estado <= S_MOV;
					elsif (IR_ADD = '1') then estado <= S_ADD;
					elsif (IR_SUB = '1') then estado <= S_SUB;
					elsif (IR_AND = '1') then estado <= S_AND;
					elsif (IR_OR = '1') then estado <= S_OR;
					elsif (IR_NOT = '1') then estado <= S_NOT;
					elsif (IR_XOR = '1') then estado <= S_XOR;
					elsif (IR_CMP = '1') then estado <= S_CMP;
					elsif (IR_JMP = '1') then estado <= S_JMP;
					elsif (IR_JNC = '1') then estado <= S_JNC;
					elsif (IR_JC = '1') then estado <= S_JC;
					elsif (IR_JNZ = '1') then estado <= S_JNZ;
					elsif (IR_JZ = '1') then estado <= S_JZ;
		    		end if;
			
				when S_HLT =>

					estado <= S_HLT;

				when S_LDR =>
			
			 		estado <= BUSCA;

				when S_STR =>
			
			 		estado <= BUSCA;
		
				when S_MOV =>

					estado <= BUSCA;
					
				when S_ADD =>

					estado <= BUSCA;
		
				when S_SUB =>

					estado <= BUSCA;

				when S_AND =>
			
					estado <= BUSCA;

				when S_OR =>
			
					estado <= BUSCA;

				when S_NOT =>

					estado <= BUSCA;

				when S_XOR =>

					estado <= BUSCA;
		
				when S_CMP =>

					estado <= BUSCA;
		
				when S_JMP =>

					estado <= BUSCA;
		
				when S_JNC =>

					if (ULA_CARRY = '1') then	estado <= BUSCA;
					else 						estado <= S_JMP;
					end if;

				when S_JC =>
					if (ULA_CARRY = '0') then 	estado <= BUSCA;
					else						estado <= S_JMP;
					end if;
		
				when S_JNZ =>

					if (ULA_Z = '0') then 	estado <= BUSCA;
					else 					estado <= S_JMP;
					end if;

				when S_JZ =>
					if (ULA_Z = '1') then 	estado <= BUSCA;
					else					estado <= S_JMP;
					end if;

				end case;
			end if;
		end process;
	
	with estado select
		W_WR	<= 	'0' WHEN INICIO, 
					'0' WHEN BUSCA, 
					'0' WHEN DEC, 
					'0' WHEN S_HLT, 
					'1' WHEN S_LDR, 
					'0' WHEN S_STR, 
					'1' WHEN S_MOV, 
					'1' WHEN S_ADD, 
					'1' WHEN S_SUB, 
					'1' WHEN S_AND, 
					'1' WHEN S_OR, 
					'1' WHEN S_NOT, 
					'1' WHEN S_XOR, 
					'1' WHEN S_CMP, 
					'0' WHEN S_JMP, 
					'0' WHEN S_JNC, 
					'0' WHEN S_JC, 
					'0' WHEN S_JNZ, 
					'0' WHEN S_JZ;

	with estado select
		RP_RD	<=	'0' WHEN INICIO, 
					'0' WHEN BUSCA, 
					'0' WHEN DEC, 
					'0' WHEN S_HLT, 
					'0' WHEN S_LDR, 
					'1' WHEN S_STR, 
					'0' WHEN S_MOV, 
					'1' WHEN S_ADD, 
					'1' WHEN S_SUB, 
					'1' WHEN S_AND, 
					'1' WHEN S_OR, 
					'0' WHEN S_NOT, 
					'1' WHEN S_XOR, 
					'1' WHEN S_CMP, 
					'0' WHEN S_JMP, 
					'0' WHEN S_JNC, 
					'0' WHEN S_JC, 
					'0' WHEN S_JNZ, 
					'0' WHEN S_JZ;

	with estado select
		RQ_RD	<= 	'0' WHEN INICIO, 
					'0' WHEN BUSCA, 
					'0' WHEN DEC, 
					'0' WHEN S_HLT, 
					'0' WHEN S_LDR, 
					'0' WHEN S_STR, 
					'1' WHEN S_MOV, 
					'1' WHEN S_ADD, 
					'1' WHEN S_SUB, 
					'1' WHEN S_AND, 
					'1' WHEN S_OR, 
					'1' WHEN S_NOT, 
					'1' WHEN S_XOR, 
					'1' WHEN S_CMP, 
					'0' WHEN S_JMP, 
					'0' WHEN S_JNC, 
					'0' WHEN S_JC, 
					'0' WHEN S_JNZ, 
					'0' WHEN S_JZ;

	with estado select
		MUX_SW	<= 	'0' WHEN INICIO, 
					'0' WHEN BUSCA, 
					'0' WHEN DEC, 
					'0' WHEN S_HLT, 
					'1' WHEN S_LDR, 
					'0' WHEN S_STR, 
					'0' WHEN S_MOV, 
					'0' WHEN S_ADD, 
					'0' WHEN S_SUB, 
					'0' WHEN S_AND, 
					'0' WHEN S_OR, 
					'0' WHEN S_NOT, 
					'0' WHEN S_XOR, 
					'0' WHEN S_CMP, 
					'0' WHEN S_JMP, 
					'0' WHEN S_JNC, 
					'0' WHEN S_JC, 
					'0' WHEN S_JNZ, 
					'0' WHEN S_JZ;

	with estado select
		D_RD	<= 	'0' WHEN INICIO, 
					'0' WHEN BUSCA, 
					'0' WHEN DEC, 
					'0' WHEN S_HLT, 
					'1' WHEN S_LDR, 
					'0' WHEN S_STR, 
					'0' WHEN S_MOV, 
					'0' WHEN S_ADD, 
					'0' WHEN S_SUB, 
					'0' WHEN S_AND, 
					'0' WHEN S_OR, 
					'0' WHEN S_NOT, 
					'0' WHEN S_XOR, 
					'0' WHEN S_CMP, 
					'0' WHEN S_JMP, 
					'0' WHEN S_JNC, 
					'0' WHEN S_JC, 
					'0' WHEN S_JNZ, 
					'0' WHEN S_JZ;

	with estado select
		D_WR	<= 	'0' WHEN INICIO, 
					'0' WHEN BUSCA, 
					'0' WHEN DEC, 
					'0' WHEN S_HLT, 
					'0' WHEN S_LDR, 
					'1' WHEN S_STR, 
					'0' WHEN S_MOV, 
					'0' WHEN S_ADD, 
					'0' WHEN S_SUB, 
					'0' WHEN S_AND, 
					'0' WHEN S_OR, 
					'0' WHEN S_NOT, 
					'0' WHEN S_XOR, 
					'0' WHEN S_CMP, 
					'0' WHEN S_JMP, 
					'0' WHEN S_JNC, 
					'0' WHEN S_JC, 
					'0' WHEN S_JNZ, 
					'0' WHEN S_JZ;

	with estado select
		PC_CLR	<= 	'1' WHEN INICIO, 
					'0' WHEN BUSCA, 
					'0' WHEN DEC, 
					'0' WHEN S_HLT, 
					'0' WHEN S_LDR, 
					'0' WHEN S_STR, 
					'0' WHEN S_MOV, 
					'0' WHEN S_ADD, 
					'0' WHEN S_SUB, 
					'0' WHEN S_AND, 
					'0' WHEN S_OR, 
					'0' WHEN S_NOT, 
					'0' WHEN S_XOR, 
					'0' WHEN S_CMP, 
					'0' WHEN S_JMP, 
					'0' WHEN S_JNC, 
					'0' WHEN S_JC, 
					'0' WHEN S_JNZ, 
					'0' WHEN S_JZ;
	with estado select
		ENABLE	<= 	'0' WHEN INICIO, 
					'1' WHEN BUSCA, 
					'0' WHEN DEC, 
					'0' WHEN S_HLT, 
					'0' WHEN S_LDR, 
					'0' WHEN S_STR, 
					'0' WHEN S_MOV, 
					'0' WHEN S_ADD, 
					'0' WHEN S_SUB, 
					'0' WHEN S_AND, 
					'0' WHEN S_OR, 
					'0' WHEN S_NOT, 
					'0' WHEN S_XOR, 
					'0' WHEN S_CMP, 
					'0' WHEN S_JMP, 
					'0' WHEN S_JNC, 
					'0' WHEN S_JC, 
					'0' WHEN S_JNZ, 
					'0' WHEN S_JZ;

	with estado select
		PC_LD	<= 	'0' WHEN INICIO, 
					'0' WHEN BUSCA, 
					'0' WHEN DEC, 
					'0' WHEN S_HLT, 
					'0' WHEN S_LDR, 
					'0' WHEN S_STR, 
					'0' WHEN S_MOV, 
					'0' WHEN S_ADD, 
					'0' WHEN S_SUB, 
					'0' WHEN S_AND, 
					'0' WHEN S_OR, 
					'0' WHEN S_NOT, 
					'0' WHEN S_XOR, 
					'0' WHEN S_CMP, 
					'1' WHEN S_JMP, 
					'0' WHEN S_JNC, 
					'0' WHEN S_JC, 
					'0' WHEN S_JNZ, 
					'0' WHEN S_JZ;

	with estado select
		ULA_SW	<= 	"000" WHEN INICIO, 
					"000" WHEN BUSCA, 
					"000" WHEN DEC, 
					"000" WHEN S_HLT, 
					"000" WHEN S_LDR, 
					"000" WHEN S_STR, 
					"000" WHEN S_MOV, 
					"001" WHEN S_ADD, 
					"010" WHEN S_SUB, 
					"011" WHEN S_AND, 
					"100" WHEN S_OR, 
					"101" WHEN S_NOT, 
					"110" WHEN S_XOR, 
					"111" WHEN S_CMP, 
					"000" WHEN S_JMP, 
					"000" WHEN S_JNC, 
					"000" WHEN S_JC, 
					"000" WHEN S_JNZ, 
					"000" WHEN S_JZ;

end LOGICA;
