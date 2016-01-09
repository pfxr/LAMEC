----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.10.2015 21:15:46
-- Design Name: 
-- Module Name: shift_digito - Behavioral
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

entity shift_digito is
    Port (CLOCK:in STD_LOGIC;
          RESET: in STD_LOGIC;
          TIMER_IN:in STD_LOGIC;
          SHIFT: out STD_LOGIC_VECTOR(1 downto 0) );
end shift_digito;

architecture Behavioral of shift_digito is

signal sr:std_logic_vector(1 downto 0):=(others=>'0');
signal last_shift:std_logic:='0';

begin

SHIFT<=sr;

process(CLOCK,RESET)
begin
    if rising_edge(CLOCK) then
        if RESET='1' then 
            sr<=(others=>'0');
        elsif TIMER_IN='1' and last_shift='0' then
            sr<=std_logic_vector(unsigned(sr)+1);
            last_shift<='1';
        elsif TIMER_IN='0' then
            last_shift<='0';
        end if;
    end if;
end process;



end Behavioral;
