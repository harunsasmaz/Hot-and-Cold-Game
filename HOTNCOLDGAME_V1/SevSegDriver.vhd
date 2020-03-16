----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:47:33 10/18/2018 
-- Design Name: 
-- Module Name:    segment - Behavioral 
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY SevSegDriver IS

 generic ( MSB : integer := 4
			 );

 PORT ( A : IN STD_LOGIC_VECTOR (MSB DOWNTO 0);
		  B : IN STD_LOGIC_VECTOR (MSB DOWNTO 0);
		  C : IN STD_LOGIC_VECTOR (MSB DOWNTO 0);
		  D : IN STD_LOGIC_VECTOR (MSB DOWNTO 0);
		  Win : 	IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		  CLK : IN STD_LOGIC;
		  SEV_SEG_DATA : OUT STD_LOGIC_VECTOR(MSB DOWNTO 0);
        SEV_SEG_DRIVER : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		  Power : IN STD_LOGIC);
		  
 
END SevSegDriver;

ARCHITECTURE BEHAVIORAL OF SevSegDriver IS

signal Player : std_logic_vector(MSB downto 0); -- := "1010";
signal equal  : std_logic_vector(MSB downto 0); -- := "1100";
signal G : std_logic_vector(MSB downto 0); -- := "1101";
signal L : std_logic_vector (MSB downto 0);
signal S : std_logic_vector (MSB downto 0);
signal E : std_logic_vector (MSB downto 0);
signal W1 : std_logic_vector (MSB downto 0);
signal W2 : std_logic_vector (MSB downto 0);
signal Mark : std_logic_vector (MSB downto 0);
signal N1 : std_logic_vector (MSB downto 0);

SIGNAL COUNTER : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

BEGIN

Player <= "01010";
equal <= "01100";
G <= "01101";
L <= "01111";
S <= "01011";
E <= "01110";
W1 <= "10000";
W2 <= "10001";
Mark <= "10100";
N1 <= "10010";

PROCESS_CLK : PROCESS(CLK)

BEGIN

	if rising_edge(CLK) then
		if COUNTER = "111" then
			COUNTER <= "000";
		else
			COUNTER <= COUNTER + 1;
		end if;
	end if;

END PROCESS;

SEV_SEG_DATA <=
G       WHEN COUNTER = "000" and D /= "00000" and Win /= "1111111111" ELSE
equal   WHEN COUNTER = "001" and D /= "00000" and Win /= "1111111111" ELSE
D		  WHEN COUNTER = "010" and D /= "00000" and Win /= "1111111111" ELSE
Player  WHEN COUNTER = "011" and D /= "00000" and Win /= "1111111111" ELSE
equal   WHEN COUNTER = "100" and D /= "00000" and Win /= "1111111111" ELSE
C 		  WHEN COUNTER = "101" and D /= "00000" and Win /= "1111111111" ELSE
B 		  WHEN COUNTER = "110" and D /= "00000" and Win /= "1111111111" ELSE
A 		  WHEN COUNTER = "111" and D /= "00000" and Win /= "1111111111" ELSE

W1      WHEN COUNTER = "000" and D /= "00000" and Win = "1111111111" ELSE
W2      WHEN COUNTER = "001" and D /= "00000" and Win = "1111111111" ELSE
"00001" WHEN COUNTER = "010" and D /= "00000" and Win = "1111111111" ELSE
N1      WHEN COUNTER = "011" and D /= "00000" and Win = "1111111111" ELSE
Mark    WHEN COUNTER = "100" and D /= "00000" and Win = "1111111111" ELSE
Mark 	  WHEN COUNTER = "101" and D /= "00000" and Win = "1111111111" ELSE
Mark 	  WHEN COUNTER = "110" and D /= "00000" and Win = "1111111111" ELSE
Mark	  WHEN COUNTER = "111" and D /= "00000" and Win = "1111111111" ELSE

L 		  WHEN COUNTER = "000" and D = "00000" and Win /= "1111111111" ELSE
"00000" WHEN COUNTER = "001" and D = "00000" and Win /= "1111111111" ELSE
S 		  WHEN COUNTER = "010" and D = "00000" and Win /= "1111111111" ELSE
E 		  WHEN COUNTER = "011" and D = "00000" and Win /= "1111111111" ELSE
L 		  WHEN COUNTER = "100" and D = "00000" and Win /= "1111111111" ELSE
"00000" WHEN COUNTER = "101" and D = "00000" and Win /= "1111111111" ELSE
S 		  WHEN COUNTER = "110" and D = "00000" and Win /= "1111111111" ELSE
E       WHEN COUNTER = "111" and D = "00000" and Win /= "1111111111" ELSE

W1 	  WHEN COUNTER = "000" and D = "00000" and Win = "1111111111" ELSE
W2      WHEN COUNTER = "001" and D = "00000" and Win = "1111111111" ELSE
"00001" WHEN COUNTER = "010" and D = "00000" and Win = "1111111111" ELSE
N1 	  WHEN COUNTER = "011" and D = "00000" and Win = "1111111111" ELSE
Mark 	  WHEN COUNTER = "100" and D = "00000" and Win = "1111111111" ELSE
Mark    WHEN COUNTER = "101" and D = "00000" and Win = "1111111111" ELSE
Mark 	  WHEN COUNTER = "110" and D = "00000" and Win = "1111111111" ELSE
Mark;

SEV_SEG_DRIVER <=
"01111111" WHEN COUNTER = "000" and Power /= '0' ELSE
"10111111" WHEN COUNTER = "001" and Power /= '0' ELSE
"11011111" WHEN COUNTER = "010" and Power /= '0' ELSE
"11101111" WHEN COUNTER = "011" and Power /= '0' ELSE
"11110111" WHEN COUNTER = "100" and Power /= '0' ELSE
"11111011" WHEN COUNTER = "101" and Power /= '0' ELSE
"11111101" WHEN COUNTER = "110" and Power /= '0' ELSE
"11111110" WHEN COUNTER = "111" and Power /= '0' ELSE
"11111111";

END BEHAVIORAL;

