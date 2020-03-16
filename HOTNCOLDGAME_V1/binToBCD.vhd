library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity binToBCD is

generic ( MSB : integer := 4
			 );
    Port ( 
			  binIn : in STD_LOGIC_VECTOR (8 downto 0);
           ones : out  STD_LOGIC_VECTOR (MSB downto 0);
           tens : out  STD_LOGIC_VECTOR (MSB downto 0);
           hundreds : out  STD_LOGIC_VECTOR (MSB downto 0)
          );
end binToBCD;

architecture Behavioral of binToBCD is

begin

bcd1: process(binIN)


  variable temp : STD_LOGIC_VECTOR (8 downto 0);
  
  variable bcd : UNSIGNED (15 downto 0) := (others => '0');
  
  begin

    bcd := (others => '0');   

    temp(8 downto 0) := binIN;
    
    for i in 0 to 8 loop
    
      if bcd(3 downto 0) > 4 then 
        bcd(3 downto 0) := bcd(3 downto 0) + 3;
      end if;
      
      if bcd(7 downto 4) > 4 then 
        bcd(7 downto 4) := bcd(7 downto 4) + 3;
      end if;
    
      if bcd(11 downto 8) > 4 then  
        bcd(11 downto 8) := bcd(11 downto 8) + 3;
      end if;

      bcd := bcd(14 downto 0) & temp(8);
    

      temp := temp(7 downto 0) & '0';
    
    end loop;

    ones <= '0' & STD_LOGIC_VECTOR(bcd(3 downto 0));
    tens <= '0' & STD_LOGIC_VECTOR(bcd(7 downto 4));
    hundreds <= '0' & STD_LOGIC_VECTOR(bcd(11 downto 8));
  
  end process bcd1;            
  
end Behavioral;
