----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2015 18:37:20
-- Design Name: 
-- Module Name: count_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity count_tb is
end count_tb;

architecture Behavioral of count_tb is
component count
Port ( CLOCK : in STD_LOGIC;
       RESET : in STD_LOGIC;
       TICK : in STD_LOGIC;
       CONT : out STD_LOGIC_VECTOR (13 downto 0));   
end component;

signal clock,reset,tick:std_logic;
signal cont:std_logic_vector(13 downto 0);

begin
uut: count
    port map(clock,reset,tick,cont);
    
process
begin
    clock<='0';
    wait for 5ns;
    clock<='1';
    wait for 5ns;
end process;


process
begin
    tick<='1';
    wait for 20ns;
    tick<='0';
    wait for 20ns;
end process;

process
begin
    reset<='1';
    wait for 10ns;
    reset<='0';
wait;
end process;
end Behavioral;
