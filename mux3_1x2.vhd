-- Multiplexador 2x1 de 3 bit.

library ieee;
use ieee.std_logic_1164.all;

entity mux3_1x2 is
port(sel: in std_logic;
    ent0, ent1: in std_logic_vector(2 downto 0);
    saida: out std_logic_vector(2 downto 0));
end mux3_1x2;

architecture arc of mux3_1x2 is
begin
saida <= ent0 when sel = '0' else
		ent1;
end arc;
