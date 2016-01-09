----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2015 22:32:56
-- Design Name: 
-- Module Name: RX_tb - Behavioral
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

entity RX_tb is
end RX_tb;

architecture Behavioral of RX_tb is

component RX_Unit
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           RX : in STD_LOGIC;
           DATA : out STD_LOGIC_VECTOR (7 downto 0)
          );
end component;

signal clock : std_logic;
signal reset : std_logic;
signal rx    : std_logic;
signal data  : std_logic_vector(7 downto 0);

begin

uut: RX_Unit
    port map( CLOCK => clock ,
              RESET => reset ,
              RX    => rx    ,
              DATA  => data );


process
begin
    clock<='1';
    wait for 5ns;
    clock<='0';
    wait for 5ns;
end process;

process
begin
    reset<='1';
    wait for 20ns;
    reset<='0';
    rx<='0';
    wait for 1ms;
    rx<='1';
    wait;
end process;



end Behavioral;
