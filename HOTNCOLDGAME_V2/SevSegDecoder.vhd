----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:50:58 10/18/2018 
-- Design Name: 
-- Module Name:    SevSegDecoder - Behavioral 
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

ENTITY SevSegDecoder IS
 PORT ( INPUT : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  SEVSEG_BUS : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END SevSegDecoder;

ARCHITECTURE BEHAVIORAL OF SevSegDecoder IS

BEGIN

WITH INPUT SELECT SEVSEG_BUS <=
"0000001" WHEN "00000", --0
"1001111" WHEN "00001", --1
"0010010" WHEN "00010", --2 
"0000110" WHEN "00011", --3 
"1001100" WHEN "00100", --4 
"0100100" WHEN "00101", --5 
"0100000" WHEN "00110", --6 
"0001111" WHEN "00111", --7 
"0000000" WHEN "01000", --8 
"0000100" WHEN "01001", --9 
"0011000" WHEN "01010", --A (P)
"0100100" WHEN "01011", --B (S)
"1110110" WHEN "01100", --C (=)
"0100001" WHEN "01101", --D (G)
"0110000" WHEN "01110", --E
"1110001" WHEN "01111", --F (L)

"1100001" WHEN "10000", -- W Part 1
"1000011" WHEN "10001", -- W Part 2
"0001001" WHEN "10010", -- N Part 1 
"1000011" WHEN "10011", -- N Part 2
"1010101" WHEN "10100", -- !!!  
"0100100" WHEN "10101", --5 
"0100000" WHEN "10110", --6 
"0001111" WHEN "10111", --7 
"0000000" WHEN "11000", --8 
"0001100" WHEN "11001", --9 
"0011000" WHEN "11010", --A (P)
"0100100" WHEN "11011", --B (S)
"1110110" WHEN "11100", --C (=)
"0100001" WHEN "11101", --D (G)
"0110000" WHEN "11110", --E
"1110001" WHEN "11111", --F (L)
"1111111" WHEN OTHERS;
END BEHAVIORAL;

