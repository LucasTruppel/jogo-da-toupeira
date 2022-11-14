library IEEE;
use IEEE.std_logic_1164.all;

entity comparator is
port (
    A,B: in std_logic_vector(7 downto 0); 
    igual: out std_logic);
end comparator;

architecture arc of comparator is
signal comp0, comp1, comp2, comp3, comp4, comp5, comp6, comp7: std_logic; 

begin
    comp0 <= A(0) xnor B(0);
    comp1 <= A(1) xnor B(1);
    comp2 <= A(2) xnor B(2);
    comp3 <= A(3) xnor B(3);
    comp4 <= A(4) xnor B(4);
    comp5 <= A(5) xnor B(5);
    comp6 <= A(6) xnor B(6);
    comp7 <= A(7) xnor B(7);
    igual <= comp0 and comp1 and comp2 and comp3 and comp4 and comp5 and comp6 and comp7 ;   
end arc;