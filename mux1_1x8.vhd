-- Multiplexador 8x1 de 1 bit.

library ieee;
use ieee.std_logic_1164.all;

entity mux1_1x8 is
port(
	sel: in std_logic_vector(2 downto 0);
    ent0, ent1, ent2, ent3, ent4, ent5, ent6, ent7: in std_logic;
    ss: out std_logic
);
end mux1_1x8;

architecture arc of mux1_1x8 is
begin
ss <= ent0 when sel = "000" else
	  ent1 when sel = "001" else
	  ent2 when sel = "010" else
	  ent3 when sel = "011" else
	  ent4 when sel = "100" else
	  ent5 when sel = "101" else
	  ent6 when sel = "110" else
	  ent7;
end arc;