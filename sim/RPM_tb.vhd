----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2015 17:54:30
-- Design Name: 
-- Module Name: RPM_tb - Behavioral
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

entity RPM_tb is
end RPM_tb;

architecture Behavioral of RPM_tb is

component RPS
    Port ( CLOCK : in  STD_LOGIC                    ;
           RESET : in  STD_LOGIC                    ;
           TICK  : in  STD_LOGIC                    ;
           R     : out STD_LOGIC_VECTOR(7 downto 0));
end component;

signal clock,reset,tick: std_logic                    ; 
signal r               : std_logic_vector (7 downto 0);


begin

uut: RPS
	port map(clock,reset,tick,r);

process
begin
	clock<='0';
	wait for 5ns;
	clock<='1';
	wait for 5ns;
end process;

process
begin
	tick<='0';
	wait for 15625000 ns;
	tick<='1';
	wait for 15625000 ns;
end process;
process
begin
	reset<='1';
	wait for 10ns;
	reset<='0';
wait;
end process;
end Behavioral;
