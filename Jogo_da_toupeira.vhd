library ieee;
use ieee.std_logic_1164.all;

entity Jogo_da_toupeira is
	port
	(
	    CLK_500Hz: in std_logic;
		KEY: in std_logic_vector(3 downto 0);
		SW: in std_logic_vector(17 downto 0);
		LEDR: out std_logic_vector(17 downto 0);
		HEX0,HEX1,HEX2: out std_logic_vector(6 downto 0)
	);
end Jogo_da_toupeira;

architecture arc of Jogo_da_toupeira is
signal btn0, btn1, btn2, btn3, end_game, end_round, r1: std_logic;
signal state: std_logic_vector(1 downto 0);


component ButtonSync is
port(KEY0, KEY1, KEY2, KEY3, CLK: in std_logic;
     BTN0, BTN1, BTN2, BTN3: out std_logic
);
end component;

component datapath is
port(btn3, btn2, btn1, CLK_500Hz, r1: in std_logic;
     state: in std_logic_vector(1 downto 0);
     sw_entra: in std_logic_vector(7 downto 0);
     h0, h1, h2: out std_logic_vector(6 downto 0);
     led_out: out std_logic_vector (7 downto 0);
     end_game, end_round: out std_logic
);
end component;

component controle is
port(CLK_500Hz, btn3, btn0, end_game, end_round: in std_logic;
     r1: out std_logic;
     state: out std_logic_vector(1 downto 0)
);
end component;

begin

bt: ButtonSync port map (KEY(0), KEY(1), KEY(2), KEY(3), CLK_500Hz, btn0, btn1, btn2, btn3);
ct: controle port map (CLK_500Hz, btn3, btn0, end_game, end_round, r1, state);
dp: datapath port map (btn3, btn2, btn1, CLK_500Hz, r1, state, SW(7 downto 0), HEX0, HEX1, HEX2, LEDR(7 downto 0), end_game, end_round);

end arc;
