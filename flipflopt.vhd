library ieee;
use ieee.std_logic_1164.all;

entity flipflopt is port (
	clk,T,enable: in std_logic;
	Q: out std_logic);
end flipflopt;

architecture circ of flipflopt is
signal QT: std_logic:= '0';
begin
	process(clk)
	begin
		if (clk'event and clk = '1') then
		    if (enable = '1') then
		        if (T = '0') then
			        QT <= QT;
		        elsif (T = '1') then
			        QT <= not QT;
			    end if;
			end if;
		end if;
	end process;
Q <= QT;
end circ;
