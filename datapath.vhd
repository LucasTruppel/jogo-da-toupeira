library ieee;
use ieee.std_logic_1164.all;

entity datapath is 
port (btn3, btn2, btn1, CLK_500Hz, r1: in std_logic;
      state: in std_logic_vector(1 downto 0);
      sw_entra: in std_logic_vector(7 downto 0);
      h0, h1, h2: out std_logic_vector(6 downto 0);
      led_out: out std_logic_vector (7 downto 0);
      end_game, end_round: out std_logic);
end datapath;

architecture arqdata of datapath is
signal toup, score: std_logic_vector(7 downto 0);
signal sai_h2s0, sai_h2s2, sai_h1s2, sai_h1s3, d7seg: std_logic_vector(6 downto 0);
signal trial: std_logic_vector(4 downto 0);
signal entra_h00e0, entra_h00e1, entra_h02e1, sai_h0s0, sai_h0s2, sai_h0s3, sai_m0: std_logic_vector(3 downto 0);
signal seq, nivel: std_logic_vector(1 downto 0);
signal pace, setup_sel, enable_nivel, enable_seq, comp_score, acerto, state_01, state_10, enable_score, reset_toup, tc7: std_logic;

-- Contador rodada
signal enable_trial, tcn3: std_logic;
signal seq1_toup, seq2_toup, seq3_toup, seq4_toup: std_logic_vector(7 downto 0);
signal trial2to0: std_logic_vector(2 downto 0);
signal trial4to3: std_logic_vector(1 downto 0);

--Divisor frequência de clock
signal clock_reset, CLK_0_25Hz, CLK_0_5Hz, CLK_0_75Hz, CLK_1Hz, CLK_1_25Hz, CLK_1_5Hz, CLK_2Hz: std_logic;
signal clk_sel,ckproc_sel: std_logic_vector(2 downto 0);


component Counter_toup is
port(CLK, E, R: in std_logic;
     tc: out std_logic:= '0';
     saida_toup: out std_logic_vector(2 downto 0)
);
end component;

component Counter_trial is
port(CLK, E, R: in std_logic;
     tc: out std_logic:= '1';
     saida_trial: out std_logic_vector(1 downto 0)
);
end component;

component seq1 is
port(address : in std_logic_vector(4 downto 0);
     data : out std_logic_vector(7 downto 0)
);
end component;

component seq2 is
port(address : in std_logic_vector(4 downto 0);
     data : out std_logic_vector(7 downto 0)
);
end component;

component seq3 is
port(address : in std_logic_vector(4 downto 0);
     data : out std_logic_vector(7 downto 0)
);
end component;

component seq4 is
port(address : in std_logic_vector(4 downto 0);
     data : out std_logic_vector(7 downto 0)
);
end component;

component mux8_1x4 is
port(e00:  in std_logic_vector(7 downto 0);
     e01:  in std_logic_vector(7 downto 0);
     e10:  in std_logic_vector(7 downto 0);
     e11:  in std_logic_vector(7 downto 0);
     sel:  in std_logic_vector(1 downto 0);
     saida:  out std_logic_vector(7 downto 0)
);
end component;

component comparator is
port(A,B: in std_logic_vector(7 downto 0); 
     igual: out std_logic
);
end component;

component ComparatorSync is
port(entrada, CLK: in std_logic;
	 saida: out std_logic
);
end component;

component Counter_score is
port(CLK: in std_logic;
     E, R: in std_logic;
     data: in std_logic_vector(1 downto 0);
     score: out std_logic_vector(7 downto 0)
);
end component;

component demux is
port(ent, sel: in std_logic;
     out0, out1: out std_logic
);
end component;

component flipflopt is
port(clk,T,enable: in std_logic;
	 Q: out std_logic
);
end component;

component Counter_2bits is
port(CLK: in std_logic;
     E: in std_logic;
     saida_contagem: out std_logic_vector(1 downto 0)
);
end component;

component logica_trial is
    port (N, T: in std_logic_vector(1 downto 0); 
          clk_sel: out std_logic_vector(2 downto 0));
    end component; 

component mux3_1x2 is
    port (sel: in std_logic;
          ent0, ent1: in std_logic_vector(2 downto 0);
          saida: out std_logic_vector(2 downto 0));
    end component;
 
component FSM_clock is
    port (clk_500Hz: in std_logic;
		  reset: in std_logic;
		  CLK_0_25Hz, CLK_0_5Hz, CLK_0_75Hz, CLK_1Hz, CLK_1_25Hz, CLK_1_5Hz, CLK_2Hz: out std_logic);
    end component;

component mux1_1x8 is
    port (sel: in std_logic_vector(2 downto 0);
          ent0, ent1, ent2, ent3, ent4, ent5, ent6, ent7: in std_logic;
          ss: out std_logic);
    end component;

component mux2_1x4 is
port(sel: in std_logic;
    ent0, ent1: in std_logic_vector(3 downto 0);
    saida: out std_logic_vector(3 downto 0));
end component;

component mux2_1x7 is
port(sel: in std_logic;
    ent0, ent1: in std_logic_vector(6 downto 0);
    saida: out std_logic_vector(6 downto 0));
end component;

component mux2_1x8 is
port(sel: in std_logic;
    ent0, ent1: in std_logic_vector(7 downto 0);
    saida: out std_logic_vector(7 downto 0));
end component;

component mux4_1x4 is
port(
	sel: in std_logic_vector(1 downto 0);
    ent0, ent1, ent2, ent3: in std_logic_vector(3 downto 0);
    ss: out std_logic_vector(3 downto 0)
);
end component;

component mux4_1x7 is
port(
	sel: in std_logic_vector(1 downto 0);
    ent0, ent1, ent2, ent3: in std_logic_vector(6 downto 0);
    ss: out std_logic_vector(6 downto 0)
);
end component;

component bcd7seg is
port(
	bcd_in:  in std_logic_vector(3 downto 0);
    out_7seg:  out std_logic_vector(6 downto 0)
);
end component;

begin

-- Lógica combinacional
state_01 <= (not state(1)) and (state(0));
state_10 <= (state(1)) and (not state(0));
end_round <= (tcn3 and tc7) and (not pace);

-- Contador toupeira
reset_toup <= state_10 or r1;
contoup: Counter_toup port map (pace, state_01, reset_toup, tc7, trial2to0);
end_game <= (not tcn3) and tc7;

-- Contador rodada
enable_trial <= state_10 and btn3;
ct: Counter_trial port map (CLK_500Hz, enable_trial, r1, tcn3, trial4to3);
trial <= trial4to3 & trial2to0;
s1: seq1 port map (trial, seq1_toup);
s2: seq2 port map (trial, seq2_toup);
s3: seq3 port map (trial, seq3_toup);
s4: seq4 port map (trial, seq4_toup);
mu8b4: mux8_1x4 port map (seq1_toup, seq2_toup, seq3_toup, seq4_toup, seq, toup);
mu8b2: mux2_1x8 port map (state_01, "00000000", toup, led_out);

-- Divisor de frequência do clock
clock_reset <= r1 or btn3;
lt: logica_trial port map (nivel, trial(4 downto 3), clk_sel);
m2: mux3_1x2 port map (state(1),clk_sel,"001",ckproc_sel);
cl: FSM_clock port map (clk_500Hz, clock_reset, CLK_0_25Hz, CLK_0_5Hz, CLK_0_75Hz, CLK_1Hz, CLK_1_25Hz, CLK_1_5Hz, CLK_2Hz);
m8: mux1_1x8 port map (ckproc_sel, CLK_0_25Hz, CLK_0_5Hz, CLK_0_75Hz, CLK_1Hz, CLK_1_25Hz, CLK_1_5Hz, CLK_2Hz, CLK_2Hz, pace);

-- Score
cp: comparator port map (toup, sw_entra, comp_score);
cpsy: ComparatorSync port map (comp_score, CLK_500Hz, acerto);
enable_score <= acerto and state_01;
cscore: Counter_score port map (CLK_500Hz, enable_score, r1, trial(4 downto 3), score);

-- Select nível e seq
fp: flipflopt port map(CLK_500Hz, '1', btn1, setup_sel);
dm: demux port map(btn2, setup_sel, enable_nivel, enable_seq);
cn: Counter_2bits port map(CLK_500Hz, enable_nivel, nivel);
cseq: Counter_2bits port map(CLK_500Hz, enable_seq, seq);

-- HEX2 
m20: mux2_1x7 port map( setup_sel, "1000111", "1110001", sai_h2s0); --L, J
m22: mux2_1x7 port map( pace, "0001100", "0000110", sai_h2s2); --P, E
hs2: mux4_1x7 port map( state, sai_h2s0, "0001100", sai_h2s2, sai_h2s2, h2); --P

-- HEX1
ds1: bcd7seg port map (score(7 downto 4), d7seg);
m12: mux2_1x7 port map( pace, d7seg, "1000000", sai_h1s2); --apagado
m13: mux2_1x7 port map( pace, d7seg, "0101011", sai_h1s3); --n
hs1: mux4_1x7 port map( state,"1111111", d7seg, sai_h1s2, sai_h1s3, h1); --apagado

-- HEX0
entra_h00e0 <= "00" & nivel;
entra_h00e1 <= "00" & seq;
entra_h02e1 <= "00" & trial(4 downto 3);
m00: mux2_1x4 port map( setup_sel, entra_h00e0, entra_h00e1, sai_h0s0);
m02: mux2_1x4 port map( pace, score(3 downto 0), entra_h02e1, sai_h0s2);
m03: mux2_1x4 port map( pace, score(3 downto 0), "1101", sai_h0s3);
m0: mux4_1x4 port map( state, sai_h0s0, score(3 downto 0), sai_h0s2, sai_h0s3, sai_m0);
ds0: bcd7seg port map (sai_m0, h0);

end arqdata;
