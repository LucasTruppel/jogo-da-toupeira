library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity Counter_2bits is port ( 
  CLK: in std_logic;
  E: in std_logic;
  saida_contagem: out std_logic_vector(1 downto 0));
end Counter_2bits;

architecture circ of Counter_2bits is
  signal cnt: std_logic_vector(1 downto 0) := "00";
begin
  process(CLK)
  begin
    if (CLK'event and CLK = '1') then
        if (cnt < "11" and E = '1') then
            cnt <= cnt + "01";
        elsif (cnt >= "11" and E = '1') then
            cnt <= "00";
        end if;
    end if;
  end process;
  saida_contagem <= cnt;
end circ;
