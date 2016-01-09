----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.10.2015 22:40:53
-- Design Name: 
-- Module Name: contar_tb - Behavioral
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

entity contar_tb is
end contar_tb;

architecture Behavioral of contar_tb is

component contar
   Port (CLOCK: in STD_LOGIC;
      RESET: in STD_LOGIC;
      TICK: in STD_LOGIC;
      D1: out STD_LOGIC_VECTOR(3 downto 0);
      D2: out STD_LOGIC_VECTOR(3 downto 0);
      D3: out STD_LOGIC_VECTOR(3 downto 0);
      D4: out STD_LOGIC_VECTOR(3 downto 0);
      VAL: out STD_LOGIC_VECTOR(10 downto 0));
end component;

signal clock,reset,tick:std_logic:='0';
signal d1,d2,d3,d4:std_logic_vector(3 downto 0);
signal val: std_logic_vector(10 downto 0);

begin

uut: contar
   port map(clock,reset,tick,d1,d2,d3,d4,val);
   
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
    wait for 10ns;
    reset<='0';
    for i in 0 to 500 loop
        tick<=not tick;
        wait for 10ns;
    end loop;
wait;
end process;
end Behavioral;
