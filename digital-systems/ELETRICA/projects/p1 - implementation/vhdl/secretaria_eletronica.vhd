library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sec_ele is
	port (clk,b_on,b_play,b_next,b_back,rec_i,rst: in std_logic;
		msg: in std_logic_vector (7 downto 0);
		led_o,led_m,led_f,led_p,led_r: out std_logic;
		display1,display2: out std_logic_vector (3 downto 0);
		msg_s: out std_logic_vector (7 downto 0));
end entity;

architecture ckt of sec_ele is

component bloco_op is
port (clk, rst_w, rst_r, memory, rw, display, rst_b, hc_r, hc_w, b_next, b_back, rec_i, b_on,b_play,led_r_i,led_p_i: in std_logic;
	msg_w: in std_logic_vector (7 downto 0);
	rec_o, mu, comp_eq, m, f, t60, t5, t2, b_block, led_m, led_f, led_p, led_r: out std_logic;
	dsp: out std_logic_vector (4 downto 0);
	dsp1,dsp2: out std_logic_vector(3 downto 0);
	msg_r: out std_logic_vector(7 downto 0)
	);
end component;

component mde_b is
    port ( CLK , RST , B_ON, PLAY, MU, COMP_EQ, REC, M, B_BLOCK, F, T60, T5, T2: in std_logic ;
        LED_O, LED_R, LED_P, RST_W, RST_R, RST_B, DISPLAY, HC_R, HC_W, MEMORY, RW: out std_logic );
end component;

signal s_led_r,s_rec_o,s_led_p,s_mu,s_comp_eq,s_m,s_b_block,s_f,s_t60,s_t5,s_t2,s_rst_w,s_rst_r,s_rst_b,s_display,s_hc_r,s_hc_w,s_memory,s_rw : std_logic;
signal s_dsp : std_logic_vector (4 downto 0);
begin

	MDE1: mde_b port map (clk, rst, b_on, b_play, s_mu, s_comp_eq, s_rec_o, s_m, s_b_block, s_f, s_t60, s_t5, s_t2,
				led_o, s_led_r, s_led_p, s_rst_w, s_rst_r, s_rst_b, s_display, s_hc_r, s_hc_w, s_memory, s_rw);

	Bloco_op1: bloco_op port map (clk, s_rst_w, s_rst_r, s_memory, s_rw, s_display, s_rst_b, s_hc_r, s_hc_w, b_next,
		b_back, rec_i, b_on, b_play,s_led_r,s_led_p, msg, s_rec_o, s_mu, s_comp_eq, s_m, s_f, s_t60, s_t5, s_t2, s_b_block, led_m, led_f,
		led_p,led_r,s_dsp, display1, display2, msg_s);

		led_p <= s_led_p;


end ckt;