library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity Counter_trial is port ( 
  CLK, E, R: in std_logic;
  tc: out std_logic:= '1';
  saida_trial: out std_logic_vector(1 downto 0));
end Counter_trial;

architecture circ of Counter_trial is
  signal cnt: std_logic_vector(1 downto 0) := "00";
  
begin
  process(CLK,R)
  begin
    if (R = '1') then
        cnt <= "00";
        tc <= '1';
    elsif (CLK'event and CLK = '1') then
        if (cnt < "11" and E = '1') then
            cnt <= cnt + "01";
            if (cnt = 10) then
                tc <= '0';
            elsif (cnt /= 10) then
                tc <= '1';
            end if;
        elsif (cnt >= "11" and E = '1') then
            cnt <= "00";
            tc <= '1';
        end if;
    end if;
  end process;
  saida_trial <= cnt;
end circ;