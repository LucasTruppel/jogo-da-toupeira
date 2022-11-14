library ieee;
use ieee.std_logic_1164.all;

entity controle is port (
   CLK_500Hz, btn3, btn0, end_game, end_round: in std_logic;
   r1: out std_logic;
   state: out std_logic_vector(1 downto 0));
end controle;

architecture circ of controle is
   type STATES is (start, setup, play, next_round, the_end);
   signal EAtual, PEstado: STATES;
begin
	process(CLK_500Hz, btn0)
	begin
	    if (btn0 = '1') then
			EAtual <= start;
        elsif (CLK_500Hz'event AND CLK_500Hz = '1') then 
         	EAtual <= PEstado;
	    end if;
	end process;
    process(EAtual, btn0, btn3, end_round, end_game)
	begin
		case EAtual is
			when start =>
			    r1 <= '1';
			    state <= "00";
		        PEstado <= setup;
		    when setup =>
                r1 <= '0';
                state <= "00";
                if (btn3='0') then
		            PEstado <= setup;
		        elsif (btn3='1') then
		            PEstado <= play;
		        end if; 
		    when play =>
                r1 <= '0';
                state <= "01";
		        if (end_round='1') then
		            PEstado <= next_round;
		        elsif (end_game='1') then
		            PEstado <= the_end;
		        else
		            PEstado <= play;
		        end if;
		    when next_round =>
                r1 <= '0';
                state <= "10";
                if (btn3='0') then
		            PEstado <= next_round;
		        elsif (btn3='1') then
		            PEstado <= play;
		        end if;
		    when the_end =>
		        r1 <= '0';
                state <= "11";
                PEstado <= the_end;
		end case;
	end process;
end circ;