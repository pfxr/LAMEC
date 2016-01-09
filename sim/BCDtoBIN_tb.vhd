----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2015 17:35:24
-- Design Name: 
-- Module Name: BCDtoBIN_tb - Behavioral
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

entity BCDtoBIN_tb is
end BCDtoBIN_tb;



architecture Behavioral of BCDtoBIN_tb is

component BCDtoBIN
Port ( CLOCK : in STD_LOGIC;
       RESET : in STD_LOGIC;
       D1 : in STD_LOGIC_VECTOR (3 downto 0);
       D2 : in STD_LOGIC_VECTOR (3 downto 0);
       D3 : in STD_LOGIC_VECTOR (3 downto 0);
       D4 : in STD_LOGIC_VECTOR (3 downto 0);
       RES : out STD_LOGIC_VECTOR (13 downto 0));
end component;

    signal clock,reset:std_logic;
    signal d1,d2,d3,d4:std_logic_vector(3 downto 0);
    signal res:std_logic_vector(13 downto 0);
begin

uut: BCDtoBIN
    port map(clock,reset,d1,d2,d3,d4,res);

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
    d1<="0100"; --4
    d2<="0101"; --5
    d3<="1000"; --8
    d4<="0001"; --1
    wait;
end process;
end Behavioral;
