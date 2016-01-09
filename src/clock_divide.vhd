----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.08.2015 23:27:33
-- Design Name: 
-- Module Name: clock_divide - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_divide is      
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           BITS:STD_LOGIC_VECTOR(26 downto 0):="010111110101111000010000000" ;
           SAIDA : out STD_LOGIC);
end clock_divide;

architecture Behavioral of clock_divide is
    signal contador: std_logic_vector(26 downto 0):=(others=>'0');
begin


process(CLOCK,RESET)
begin
    
    if(RESET='1') then
        contador<=(others=>'0');
        SAIDA<='0';
    elsif rising_edge(CLOCK) then
        SAIDA<='0';
            if(contador<BITS) then
                contador<=std_logic_vector(unsigned(contador)+1);
            else
                SAIDA<='1';
                contador<=(others=>'0');
            end if;  
    end if;
end process;

end Behavioral;
