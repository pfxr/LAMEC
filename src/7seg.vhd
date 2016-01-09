----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.09.2015 15:57:22
-- Design Name: 
-- Module Name: 7seg - Behavioral
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segmentos is
    Port ( ENTRADA : in STD_LOGIC_VECTOR (3 downto 0);
           SELECT_DISP: in STD_LOGIC_VECTOR(1 downto 0);
           DISP: out STD_LOGIC_VECTOR(3 downto 0);
           SAIDA : out STD_LOGIC_VECTOR (7 downto 0));
end segmentos;

architecture Behavioral of segmentos is
 type rom is array(0 to 9) of std_logic_vector(6 downto 0); 
 constant digitos: rom:=("0000001","1001111","0010010","0000110","1001100","0100100","0100000","0001111","0000000","0000100");

begin
process(ENTRADA)
begin
    SAIDA<=digitos(conv_integer(ENTRADA))&'1';
    if(ENTRADA>"1001") then
        SAIDA<="01100001";
    end if;
end process;
DISP<= "0111" when SELECT_DISP="11" else
       "1011" when SELECT_DISP="10" else
       "1101" when SELECT_DISP="01" else
       "1110";
end Behavioral;
