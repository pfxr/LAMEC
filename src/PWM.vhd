----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.09.2015 22:54:22
-- Design Name: 
-- Module Name: PWM - Behavioral
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

entity PWM is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           ENTRADA : in STD_LOGIC_VECTOR (7 downto 0);
           SAIDA : out STD_LOGIC);
end PWM;

architecture Behavioral of PWM is
    signal count:std_logic_vector(7 downto 0):=(others=>'0');
begin

process(CLOCK,RESET)
begin
    if RESET='1' then
        count<=(others=>'0');
    elsif rising_edge(CLOCK) then
        count<=std_logic_vector(unsigned(count)+1);
    end if;
end process;

process(ENTRADA,count)
begin
    if(count<ENTRADA) then
        SAIDA<='1';
    else
        SAIDA<='0';
    end if;
end process;
end Behavioral;
