----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:46:28 10/18/2018 
-- Design Name: 
-- Module Name:    lab3 - Behavioral 
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
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClkDiv is
 Port ( MCLK : in STD_LOGIC;
		  HUNDREDHZCLOCK : out STD_LOGIC;
		  Power : IN STD_LOGIC);
		  
end ClkDiv;

architecture Behavioral of ClkDiv is

SIGNAL COUNTER : STD_LOGIC_VECTOR(18 DOWNTO 0) := "0000000000000000000";

begin

CLK_PROCESS: PROCESS(MCLK, Power)

	BEGIN
	if Power = '1' then
		if (MCLK'EVENT AND MCLK = '1') then
			if COUNTER <= "0111101000010010000" then
					COUNTER <= COUNTER + 1;
			else 
					COUNTER <= "0000000000000000000";
			end if;
		end if;
	end if;
	
	END PROCESS;
	
	HUNDREDHZCLOCK <= '1' WHEN COUNTER = "0011110100001001000" else '0';

end Behavioral;

