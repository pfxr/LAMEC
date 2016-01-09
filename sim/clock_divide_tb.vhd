----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.10.2015 00:01:06
-- Design Name: 
-- Module Name: clock_divide_tb - Behavioral
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

entity clock_divide_tb is
end clock_divide_tb;

architecture Behavioral of clock_divide_tb is

component clock_divide
    generic(
        BITS:STD_LOGIC_VECTOR(26 downto 0):="101111101011110000100000000"      
);
Port ( CLOCK : in STD_LOGIC;
       RESET : in STD_LOGIC;
       SAIDA : out STD_LOGIC);
end component;

signal clock,reset,saida:std_logic;

begin

uut: clock_divide
    generic map(BITS=>"101111101011110000100000000")
    port map(CLOCK=>clock,RESET=>reset,SAIDA=>saida);
    
    
process
begin
    clock<='0';
    wait for 5ns;
    clock<='1';
    wait for 5ns;
end process;

process
begin
    reset<='1';
    wait for 20ns;
    reset<='0';
    wait;
end process;

end Behavioral;
