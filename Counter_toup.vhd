library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity Counter_toup is port ( 
  CLK, E, R: in std_logic;
  tc: out std_logic:= '0';
  saida_toup: out std_logic_vector(2 downto 0));
end Counter_toup;

architecture circ of Counter_toup is
  signal cnt: std_logic_vector(2 downto 0) := "000";
  
begin
  process(CLK,R)
  begin
    if (R = '1') then
        cnt <= "000";
        tc <= '0';
    elsif (CLK'event and CLK = '1') then
        if (cnt < "110" and E = '1') then
            cnt <= cnt + "001";
            tc <= '0';
        elsif (cnt = "110" and E = '1') then
            cnt <= cnt + "001";
            tc <= '1';
        elsif (cnt >= "111" and E = '1') then
            cnt <= "000";
            tc <= '0';
        end if;
    end if;
  end process;
  saida_toup <= cnt;
end circ;