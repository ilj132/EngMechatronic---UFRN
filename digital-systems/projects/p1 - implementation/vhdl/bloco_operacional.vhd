library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bloco_op is
port (clk, rst_w, rst_r, memory, rw, display, rst_b, hc_r, hc_w, b_next, b_back, rec_i, b_on,b_play,led_r_i,led_p_i: in std_logic;
	msg_w: in std_logic_vector (7 downto 0);
	rec_o, mu, comp_eq, m, f, t60, t5, t2, b_block, led_m, led_f, led_p, led_r: out std_logic;
	dsp: out std_logic_vector (4 downto 0);
	dsp1,dsp2: out std_logic_vector(3 downto 0);
	msg_r: out std_logic_vector(7 downto 0));
end entity;

architecture ckt of bloco_op is 
	component blocor is
    		port (
		en, clk, rst_b, memory, rw: in std_logic;
		data_i: in std_logic_vector (7 downto 0);
		rec_block: out std_logic;
		data_o: out std_logic_vector(7 downto 0)
		);
	end component;
	component Timer_60 is 
		port (
		clk, b_on, b_play, b_next, b_back	 :	in std_logic;
		timer60s :	out std_logic
		);
	end component;

	component Timers_2_5 is
		port (
		clk, b_on 	:	in std_logic;
		timer2s, timer5s:	out std_logic
		);
	end component;
	component CONT_ESC is
		port (
		CLK,LOAD,CLEAR: IN STD_LOGIC;
		SAIDA: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
		);
	end component;
	component decod_bcd_8bit is
		port(bin: in STD_LOGIC_VECTOR(5 downto 0);
		bcd: out STD_LOGIC_VECTOR (7 downto 0)
		);
	end component;
	component CONT_L is
	port (CLK,LOAD,CLEAR, N, B: IN STD_LOGIC;
		CONT_W: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		COMP_EQ: OUT STD_LOGIC;
		SAIDA: OUT STD_LOGIC_VECTOR (4 DOWNTO 0));
	end component;

signal cont_w,cont_r,mux_rw,s_dsp:std_logic_vector(4 downto 0);
signal dmux, sb_block : std_logic_vector (24 downto 0);
signal ss_msg_r ,ss_dsp: std_logic_vector (5 downto 0);
signal s_msg_r, s_binbcd : std_logic_vector (7 downto 0);
signal enable: std_logic_vector (24 downto 0);

begin
P1: CONT_ESC port map(clk,hc_w,rst_w,cont_w);
P2: CONT_L port map(clk,hc_r,rst_r,b_next,b_back,cont_w,comp_eq,cont_r);

	PROCESS(clk)
	
		BEGIN
			IF (rw = '1') THEN
				mux_rw <= cont_w;
			ELSE
				mux_rw <= cont_r;
			END IF;
	
			IF (led_p_i = '1') THEN
				s_dsp <= cont_r;
			ELSE
				s_dsp <= cont_w;
			END IF;
	
			CASE (mux_rw) is
				when "00000" => dmux <= "0000000000000000000000001";		
				when "00001" => dmux <= "0000000000000000000000010";		
				when "00010" => dmux <= "0000000000000000000000100";		
				when "00011" => dmux <= "0000000000000000000001000";		
				when "00100" => dmux <= "0000000000000000000010000";		
				when "00101" => dmux <= "0000000000000000000100000";		
				when "00110" => dmux <= "0000000000000000001000000";		
				when "00111" => dmux <= "0000000000000000010000000";		
				when "01000" => dmux <= "0000000000000000100000000";		
				when "01001" => dmux <= "0000000000000001000000000";		
				when "01010" => dmux <= "0000000000000010000000000";		
				when "01011" => dmux <= "0000000000000100000000000";		
				when "01100" => dmux <= "0000000000001000000000000";		
				when "01101" => dmux <= "0000000000010000000000000";		
				when "01110" => dmux <= "0000000000100000000000000";		
				when "01111" => dmux <= "0000000001000000000000000";		
				when "10000" => dmux <= "0000000010000000000000000";		
				when "10001" => dmux <= "0000000100000000000000000";		
				when "10010" => dmux <= "0000001000000000000000000";		
				when "10011" => dmux <= "0000010000000000000000000";		
				when "10100" => dmux <= "0000100000000000000000000";		
				when "10101" => dmux <= "0001000000000000000000000";		
				when "10110" => dmux <= "0010000000000000000000000";		
				when "10111" => dmux <= "0100000000000000000000000";		
				when "11000" => dmux <= "1000000000000000000000000";
				when others => dmux <= "0000000000000000000000000";
			END CASE;

			CASE (mux_rw) is
				when "00000" => b_block <= sb_block(0);		
				when "00001" => b_block <= sb_block(1);		
				when "00010" => b_block <= sb_block(2);		
				when "00011" => b_block <= sb_block(3);
				when "00100" => b_block <= sb_block(4);		
				when "00101" => b_block <= sb_block(5);		
				when "00110" => b_block <= sb_block(6);		
				when "00111" => b_block <= sb_block(7);		
				when "01000" => b_block <= sb_block(8);		
				when "01001" => b_block <= sb_block(9);		
				when "01010" => b_block <= sb_block(10);		
				when "01011" => b_block <= sb_block(11);		
				when "01100" => b_block <= sb_block(12);		
				when "01101" => b_block <= sb_block(13);		
				when "01110" => b_block <= sb_block(14);		
				when "01111" => b_block <= sb_block(15);		
				when "10000" => b_block <= sb_block(16);		
				when "10001" => b_block <= sb_block(17);		
				when "10010" => b_block <= sb_block(18);		
				when "10011" => b_block <= sb_block(19);		
				when "10100" => b_block <= sb_block(20);		
				when "10101" => b_block <= sb_block(21);		
				when "10110" => b_block <= sb_block(22);		
				when "10111" => b_block <= sb_block(23);		
				when "11000" => b_block <= sb_block(24);
				when others => b_block <= '1';
			END CASE;

			IF(cont_w = "11000") then
				f <= '1';
				led_f <= '1';
			ELSE 
				f<= '0';
				led_f <= '0';
			END IF;
			IF(cont_w /= "00000") THEN
				m <= '1';
				led_m <= '1';
			ELSE
				m <= '0';
				led_m <= '0';
			END IF;
			IF (b_next='1' or b_back='1') THEN
				mu <= '1';
			ELSE
				mu <= '0';
			END IF;
					
	END PROCESS;

	enable(0) <= (dmux(0) and (led_p_i or led_r_i));
	enable(1) <= (dmux(1) and (led_p_i or led_r_i));
	enable(2) <= (dmux(2) and (led_p_i or led_r_i));
	enable(3) <= (dmux(3) and (led_p_i or led_r_i));
	enable(4) <= (dmux(4) and (led_p_i or led_r_i)) ;
	enable(5) <= (dmux(5) and (led_p_i or led_r_i)) ;
	enable(6) <= (dmux(6) and (led_p_i or led_r_i)) ;
	enable(7) <= (dmux(7) and (led_p_i or led_r_i)) ;
	enable(8) <= (dmux(8) and (led_p_i or led_r_i)) ;
	enable(9) <= (dmux(9) and (led_p_i or led_r_i)) ;
	enable(10) <= (dmux(10) and (led_p_i or led_r_i)) ;
	enable(11) <= (dmux(11) and (led_p_i or led_r_i)) ;
	enable(12) <= (dmux(12) and (led_p_i or led_r_i));
	enable(13) <= (dmux(13) and (led_p_i or led_r_i)) ;
	enable(14) <= (dmux(14) and (led_p_i or led_r_i)) ;
	enable(15) <= (dmux(15) and (led_p_i or led_r_i)) ;
	enable(16) <= (dmux(16) and (led_p_i or led_r_i));
	enable(17) <= (dmux(17) and (led_p_i or led_r_i)) ;
	enable(18) <= (dmux(18) and (led_p_i or led_r_i)) ;
	enable(19) <= (dmux(19) and (led_p_i or led_r_i)) ;
	enable(20) <= (dmux(20) and (led_p_i or led_r_i)) ;
	enable(21) <= (dmux(21) and (led_p_i or led_r_i)) ;
	enable(22) <= (dmux(22) and (led_p_i or led_r_i)) ;
	enable(23) <= (dmux(23) and (led_p_i or led_r_i)) ;
	enable(24) <= (dmux(24) and (led_p_i or led_r_i)) ;



	BR1: blocor port map (enable(0),clk,rst_b,memory,rw,msg_w,sb_block(0),s_msg_r);
	BR2: blocor port map (enable(1),clk,rst_b,memory,rw,msg_w,sb_block(1),s_msg_r);
	BR3: blocor port map (enable(2),clk,rst_b,memory,rw,msg_w,sb_block(2),s_msg_r);
	BR4: blocor port map (enable(3),clk,rst_b,memory,rw,msg_w,sb_block(3),s_msg_r);
	BR5: blocor port map (enable(4),clk,rst_b,memory,rw,msg_w,sb_block(4),s_msg_r);
	BR6: blocor port map (enable(5),clk,rst_b,memory,rw,msg_w,sb_block(5),s_msg_r);
	BR7: blocor port map (enable(6),clk,rst_b,memory,rw,msg_w,sb_block(6),s_msg_r);
	BR8: blocor port map (enable(7),clk,rst_b,memory,rw,msg_w,sb_block(7),s_msg_r);
	BR9: blocor port map (enable(8),clk,rst_b,memory,rw,msg_w,sb_block(8),s_msg_r);
	BR10: blocor port map (enable(9),clk,rst_b,memory,rw,msg_w,sb_block(9),s_msg_r);
	BR11: blocor port map (enable(10),clk,rst_b,memory,rw,msg_w,sb_block(10),s_msg_r);
	BR12: blocor port map (enable(11),clk,rst_b,memory,rw,msg_w,sb_block(11),s_msg_r);
	BR13: blocor port map (enable(12),clk,rst_b,memory,rw,msg_w,sb_block(12),s_msg_r);
	BR14: blocor port map (enable(13),clk,rst_b,memory,rw,msg_w,sb_block(13),s_msg_r);
	BR15: blocor port map (enable(14),clk,rst_b,memory,rw,msg_w,sb_block(14),s_msg_r);
	BR16: blocor port map (enable(15),clk,rst_b,memory,rw,msg_w,sb_block(15),s_msg_r);
	BR17: blocor port map (enable(16),clk,rst_b,memory,rw,msg_w,sb_block(16),s_msg_r);
	BR18: blocor port map (enable(17),clk,rst_b,memory,rw,msg_w,sb_block(17),s_msg_r);
	BR19: blocor port map (enable(18),clk,rst_b,memory,rw,msg_w,sb_block(18),s_msg_r);
	BR20: blocor port map (enable(19),clk,rst_b,memory,rw,msg_w,sb_block(19),s_msg_r);
	BR21: blocor port map (enable(20),clk,rst_b,memory,rw,msg_w,sb_block(20),s_msg_r);
	BR22: blocor port map (enable(21),clk,rst_b,memory,rw,msg_w,sb_block(21),s_msg_r);
	BR23: blocor port map (enable(22),clk,rst_b,memory,rw,msg_w,sb_block(22),s_msg_r);
	BR24: blocor port map (enable(23),clk,rst_b,memory,rw,msg_w,sb_block(23),s_msg_r);
	BR25: blocor port map (enable(24),clk,rst_b,memory,rw,msg_w,sb_block(24),s_msg_r);

	led_r <= led_r_i;
	led_p <= led_p_i;

	msg_r <= s_msg_r;

	ss_msg_r(0) <= s_msg_r(0);
	ss_msg_r(1) <= s_msg_r(1);
	ss_msg_r(2) <= s_msg_r(2);
	ss_msg_r(3) <= s_msg_r(3);
	ss_msg_r(4) <= s_msg_r(4);
	ss_msg_r(5) <= s_msg_r(5);

	dsp <= s_dsp;

	Timer60: Timer_60 port map (clk,b_on,b_play,b_next,b_back,t60);
	Timer5: Timers_2_5 port map (clk,b_on,t2,t5);
	
	ss_dsp(0) <= s_dsp(0);
	ss_dsp(1) <= s_dsp(1);
	ss_dsp(2) <= s_dsp(2);
	ss_dsp(3) <= s_dsp(3);
	ss_dsp(4) <= s_dsp(4);
	ss_dsp(5) <= '0';

	D7S1: decod_bcd_8bit port map(ss_dsp,s_binbcd);
 
	dsp1(0)<=s_binbcd(0);
	dsp1(1)<=s_binbcd(1);
	dsp1(2)<=s_binbcd(2);
	dsp1(3)<=s_binbcd(3);

	dsp2(0)<=s_binbcd(4);
	dsp2(1)<=s_binbcd(5);
	dsp2(2)<=s_binbcd(6);
	dsp2(3)<=s_binbcd(7);

	rec_o <=rec_i;

end ckt;
