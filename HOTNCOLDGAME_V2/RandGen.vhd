library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RandGen is
Port ( clock : in STD_LOGIC;
       reset : in STD_LOGIC;
       enable : in STD_LOGIC;
       Random : out integer);


end RandGen;

architecture Behavioral of RandGen is

signal temp: STD_LOGIC_VECTOR(8 downto 0) := "000000001";

begin

PROCESS(clock)
variable first : STD_LOGIC := '0';
BEGIN

IF rising_edge(clock) THEN
   
	IF (reset='1') THEN  
    temp <= "000000001"; 
	end if;
	
   IF enable = '1' THEN
      
		for i in 0 to 99 loop
			first := temp(4) XOR temp(3) XOR temp(2) XOR temp(0);
			temp <= first & temp(8 downto 1);
		end loop;
		
	END IF;

END IF;
END PROCESS;

Random <= to_integer(unsigned(temp));

end Behavioral;