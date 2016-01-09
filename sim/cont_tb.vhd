----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2015 17:20:10
-- Design Name: 
-- Module Name: cont_tb - Behavioral
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

entity cont_tb is
end cont_tb;

architecture Behavioral of cont_tb is

component cont
Port ( CLOCK: in STD_LOGIC;
       INC : in STD_LOGIC;
       RESET : in STD_LOGIC;
       COUNT : out STD_LOGIC_VECTOR (3 downto 0);
       INC_OUT: out STD_LOGIC);
end component;

signal clock,inc,reset,inc_out,en:std_logic:='0';
signal count:std_logic_vector(3 downto 0):=(others=>'0');
begin

uut:cont
    port map(CLOCK=>clock,
            INC=>inc,
            RESET=>reset,
            COUNT=>count,
            INC_OUT=>inc_out);

process
begin
    clock<='0';
    wait for 5ns;
    clock<='1';
    wait for 5ns;
    inc<=not inc;
end process;


process
begin
    reset<='1';
    wait for 10ns;
    reset<='0';
wait;
end process;
end Behavioral;
