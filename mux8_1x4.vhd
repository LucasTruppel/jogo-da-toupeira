-- Multiplexador 4x1 de 8 bit.

library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux8_1x4 is
port (e00:  in std_logic_vector(7 downto 0);
      e01:  in std_logic_vector(7 downto 0);
      e10:  in std_logic_vector(7 downto 0);
      e11:  in std_logic_vector(7 downto 0);
      sel:  in std_logic_vector(1 downto 0);
      saida:  out std_logic_vector(7 downto 0) 
      );
end mux8_1x4;

architecture arc of mux8_1x4 is
begin 
  saida <= e00 when sel = "00" else
           e01 when sel = "01" else
           e10 when sel = "10" else
	       e11;
end arc;
