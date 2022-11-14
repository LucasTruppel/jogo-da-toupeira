-----------------------------------
library ieee;
use ieee.std_logic_1164.all;
------------------------------------
entity seq2 is
  port ( address : in std_logic_vector(4 downto 0);
         data : out std_logic_vector(7 downto 0) );
end entity;

architecture Rom_Arch of seq2 is
  type memory is array (00 to 31) of std_logic_vector(7 downto 0);
  constant my_Rom : memory := (
	00 => "00001000",
	01 => "00000010",
   02 => "10000000",
	03 => "00010000",
	04 => "00000010",
	05 => "00000001",
	06 => "10000000",
	07 => "00100000",
	08 => "10000000",
	09 => "00000100",
   10 => "00000010",
	11 => "00000100",
	12 => "01000000",
	13 => "00000100",
	14 => "00100000",
	15 => "00001000",
   16 => "00000100",
	17 => "10000000",
   18 => "00000100",
	19 => "00001000",
	20 => "00010000",
	21 => "00000001",
	22 => "00100000",
	23 => "10000000",
   24 => "01000000",
	25 => "00000010",
   26 => "00000100",
	27 => "00010000",
	28 => "00001000",
	29 => "00100000",
	30 => "10000000",
	31 => "00000001");
	
begin
   process (address)
   begin
     case address is
       when "00000" => data <= my_rom(00);
       when "00001" => data <= my_rom(01);
       when "00010" => data <= my_rom(02);
       when "00011" => data <= my_rom(03);
       when "00100" => data <= my_rom(04);
       when "00101" => data <= my_rom(05);
       when "00110" => data <= my_rom(06);
       when "00111" => data <= my_rom(07);
       when "01000" => data <= my_rom(08);
       when "01001" => data <= my_rom(09);
	    when "01010" => data <= my_rom(10);
	    when "01011" => data <= my_rom(11);
       when "01100" => data <= my_rom(12);
	    when "01101" => data <= my_rom(13);
	    when "01110" => data <= my_rom(14);
	    when "01111" => data <= my_rom(15);
       when "10000" => data <= my_rom(16);
       when "10001" => data <= my_rom(17);
       when "10010" => data <= my_rom(18);
       when "10011" => data <= my_rom(19);
       when "10100" => data <= my_rom(20);
       when "10101" => data <= my_rom(21);
       when "10110" => data <= my_rom(22);
       when "10111" => data <= my_rom(23);
       when "11000" => data <= my_rom(24);
	    when "11001" => data <= my_rom(25);
	    when "11010" => data <= my_rom(26);
       when "11011" => data <= my_rom(27);
	    when "11100" => data <= my_rom(28);
	    when "11101" => data <= my_rom(29);
	    when "11110" => data <= my_rom(30);
       when others  => data <= my_rom(31);
       
       end case;
  end process;
end architecture Rom_Arch;