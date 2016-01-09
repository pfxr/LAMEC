----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2015 18:33:12
-- Design Name: 
-- Module Name: count - Behavioral
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

entity count is
    generic(LIMIT: STD_LOGIC_VECTOR(7 downto 0):="11111111");
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           TICK : in STD_LOGIC;
           CONT : out STD_LOGIC_VECTOR (7 downto 0);
           SAIDA: out STD_LOGIC);
end count;

architecture Behavioral of count is

signal tick_count:std_logic_vector(7 downto 0);
signal last_tick:std_logic:='0';

begin

CONT<=tick_count;

process(tick_count,CLOCK)
begin
    if rising_edge(CLOCK) then
        if tick_count<LIMIT then
            SAIDA<='0';
        elsif tick_count=LIMIT then
            SAIDA<='1';
        end if;
    end if;
end process;

process(CLOCK,RESET,tick_count)
begin
    if RESET='1' or tick_count>LIMIT then
        tick_count<=(others=>'0');
    elsif rising_edge(CLOCK) then
        if TICK='1' and last_tick='0' then
            tick_count<=std_logic_vector(unsigned(tick_count)+1);
            last_tick<='1';
        elsif TICK='0' then
            last_tick<='0';
        end if;
   end if;
end process;

end Behavioral;
