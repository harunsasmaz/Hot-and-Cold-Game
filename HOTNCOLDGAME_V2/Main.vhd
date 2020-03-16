----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:36:50 11/19/2018 
-- Design Name: 
-- Module Name:    HotNCold - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HotNCold is

generic ( MSB : integer := 4 );

Port (Power : in std_logic;
		Guess : in std_logic_vector(8 downto 0);
		Enable : in std_logic; -- Generate a random integer
		Reset : in std_logic;
		enter : in std_logic; -- Enter the guess when player is ready
		CLK : in std_logic;
		Leds : out std_logic_vector(9 downto 0);
		Sevseg_digit : out std_logic_vector (6 downto 0);
		Sevseg_Control : out std_logic_vector (7 downto 0));
		
end HotNCold;


architecture Behavioral of HotNCold is


	COMPONENT RandGen
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		enable : IN std_logic;          
		Random : out integer
		);
	END COMPONENT;
	
	
	COMPONENT Comparator
	PORT(
		Random : IN integer;
		Guess : IN std_logic_vector(8 downto 0);
		enter : in std_logic;
		clock : in std_logic;
		led_out : OUT std_logic_vector(9 downto 0);
		guessOut : out std_logic_vector(MSB downto 0);
		Power : IN STD_LOGIC;
		reset : in std_logic
		);
	END COMPONENT;
	
	
	COMPONENT binToBCD
	PORT(
		binIN : IN std_logic_vector(8 downto 0);          
		ones : OUT std_logic_vector(MSB downto 0);
		tens : OUT std_logic_vector(MSB downto 0);
		hundreds : OUT std_logic_vector(MSB downto 0)
		);
	END COMPONENT;
	
	COMPONENT SevSegDecoder
	PORT(
		INPUT : IN std_logic_vector(MSB downto 0);          
		SEVSEG_BUS : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ClkDiv
	PORT(
		MCLK : IN std_logic;          
		HUNDREDHZCLOCK : OUT std_logic;
		Power : IN STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT SevSegDriver
	PORT (  A : IN STD_LOGIC_VECTOR (MSB DOWNTO 0);
		B : IN STD_LOGIC_VECTOR (MSB DOWNTO 0);
		C : IN STD_LOGIC_VECTOR (MSB DOWNTO 0);
		D : IN STD_LOGIC_VECTOR (MSB DOWNTO 0);
		Win : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		R_3 : IN STD_LOGIC_VECTOR (MSB DOWNTO 0);
	   R_2 : IN STD_LOGIC_VECTOR (MSB DOWNTO 0);
  	   R_1 : IN STD_LOGIC_VECTOR (MSB DOWNTO 0);
		CLK : IN STD_LOGIC;
		SEV_SEG_DATA : OUT STD_LOGIC_VECTOR(MSB DOWNTO 0);
		SEV_SEG_DRIVER : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		Power : IN STD_LOGIC);
 
	END COMPONENT;
	
-- Required signal list
signal tempRand : integer;
signal tempGuess : std_logic_vector(8 downto 0);
signal one : std_logic_vector(MSB downto 0);
signal ten : std_logic_vector(MSB downto 0);
signal hundred : std_logic_vector(MSB downto 0);
signal one_1 : std_logic_vector(MSB downto 0);
signal ten_1 : std_logic_vector(MSB downto 0);
signal hundred_1 : std_logic_vector(MSB downto 0);
signal hz : std_logic;
signal sevsegdata : std_logic_vector(MSB downto 0);
signal tempClock : std_logic;
signal guessCount : std_logic_vector(MSB downto 0);
signal tempLed : std_logic_vector (9 downto 0);
signal randomVect : std_logic_vector (8 downto 0);


begin


	tempClock <= CLK;
	randomVect <= std_logic_vector(to_unsigned(tempRand, randomVect'length));

	rand : RandGen PORT MAP(
		clock => tempClock,
		reset => Reset,
		enable => Enable,
		Random => tempRand
	);
	
	
	comp : Comparator PORT MAP(
		Random => tempRand,
		Guess => Guess,
		enter => enter,
		clock => hz,
		led_out => tempLed,
		guessOut => guessCount,
		Power => Power,
		reset => Reset
	);
	
	tempGuess <= Guess;
	
	binBCD1: binToBCD PORT MAP(
		binIN => tempGuess,
		ones => one,
		tens => ten,
		hundreds => hundred
		
	);
	
	binBCD2: binToBCD PORT MAP(
		binIN => randomVect,
		ones => one_1,
		tens => ten_1,
		hundreds => hundred_1	
	);
	
	clock : ClkDiv PORT MAP(
		MCLK => tempClock,
		HUNDREDHZCLOCK => hz,
		Power => Power
	);
	
	driver : SevSegDriver PORT MAP(one,ten,hundred, guessCount, tempLed, hundred_1, ten_1, one_1, hz, sevsegdata, Sevseg_Control, Power);
		
	decoder : SevSegDecoder PORT MAP(
		INPUT => sevsegdata,
		SEVSEG_BUS => Sevseg_digit
	);

Leds <= tempLed;
	
end Behavioral;