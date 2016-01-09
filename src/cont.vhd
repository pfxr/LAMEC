----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2015 22:10:13
-- Design Name: 
-- Module Name: cont - Behavioral
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

entity cont is
    Port ( CLOCK: in STD_LOGIC;
           INC : in STD_LOGIC;
           RESET : in STD_LOGIC;
           COUNT : out STD_LOGIC_VECTOR (3 downto 0);
           INC_OUT: out STD_LOGIC);
end cont;

architecture Behavioral of cont is
    signal contador:std_logic_vector(3 downto 0):=(others=>'0');
    signal last_inc,init:std_logic:='0';
begin


COUNT<=contador;
process(CLOCK)
begin
    if rising_edge(CLOCK) then
        INC_OUT<=contador(3) and contador(0);
    end if;
end process;


process(INC,RESET,contador,last_inc,CLOCK)
begin
    if (RESET='1') or contador="1010" then
        contador<=(others=>'0');
    elsif rising_edge(CLOCK) then
        if(INC='1' and last_inc='0') then
            contador<=std_logic_vector(unsigned(contador)+1);
        end if;
        last_inc<=INC;
    end if;
end process;
end Behavioral;
