----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:11:53 11/19/2018 
-- Design Name: 
-- Module Name:    Comparator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Comparator is
Port ( Random : in integer;
		 Guess : in STD_LOGIC_VECTOR(8 downto 0);
		 enter : in std_logic;
		 clock : in std_logic;
		 led_out : out std_logic_vector(9 downto 0);
		 guessOut : out std_logic_vector(4 downto 0);
		 Power : IN STD_LOGIC;
		 reset : in std_logic);
		 
end Comparator;

architecture Behavioral of Comparator is

signal intGuess : integer;
signal interval : integer;
signal tempOut : std_logic_vector(9 downto 0) := "0000000000";
signal guessNumber : integer := 7;

begin

intGuess <= to_integer(unsigned(Guess));
interval <= abs(intGuess - Random);

process(clock, Power,guessNumber)
variable hold : std_logic;

begin
		
	
	IF rising_edge(clock) THEN
		if reset = '1' then
			guessNumber <= 7;
			tempOut <= "0000000000";
		end if;
			
			if (enter = '1' and guessNumber /= 0) then
				if hold = '0' then
					guessNumber <= guessNumber - 1;
				end if;
			
				if intGuess < Random then				
					if interval < 1  then
						tempOut <=  "1111111111";
						guessNumber <= 0;
					
					elsif interval < 10  then
						tempOut <=  "1111111110";
					
					elsif interval < 30  then
						tempOut <=  "1111111100";

					elsif interval < 50  then
						tempOut <=  "1111111000";

					elsif interval < 70  then
						tempOut <=  "1111110000";

					elsif interval < 100  then
						tempOut <=  "1111100000";

					elsif interval < 120  then
						tempOut <=  "1111000000";
				
					elsif interval < 150  then
						tempOut <=  "1110000000";
					
					elsif interval < 200  then
						tempOut <=  "1100000000";
					
					elsif interval < 250  then
						tempOut <=  "1000000000";
					else 
						tempOut <=  "0000000000";			
					end if;
					
				else
					
					if interval < 1  then
						tempOut <=  "1111111111";
						guessNumber <= 0;
					
					elsif interval < 10  then
						tempOut <=  "0111111111";
					
					elsif interval < 30  then
						tempOut <=  "0011111111";

					elsif interval < 50  then
						tempOut <=  "0001111111";

					elsif interval < 70  then
						tempOut <=  "0000111111";

					elsif interval < 100  then
						tempOut <=  "0000011111";

					elsif interval < 120  then
						tempOut <=  "0000001111";
				
					elsif interval < 150  then
						tempOut <=  "0000000111";
					
					elsif interval < 200  then
						tempOut <=  "0000000011";
					
					elsif interval < 250  then
						tempOut <=  "0000000001";
					else 
						tempOut <=  "0000000000";			
					end if;
				end if;
			end if;
			hold := enter;
		end if;
end process;


led_out <= tempOut WHEN Power = '1'  and reset = '0' ELSE
"0000000000";

guessOut <= std_logic_vector(to_unsigned(guessNumber,guessOut'length)); 

end Behavioral;

