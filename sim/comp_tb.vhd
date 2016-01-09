----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2015 17:04:44
-- Design Name: 
-- Module Name: comp_tb - Behavioral
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

entity comp_tb is
end comp_tb;

architecture Behavioral of comp_tb is

component comp
    Port ( CLOCK    : in STD_LOGIC                     ;
           RPS      : in STD_LOGIC_VECTOR  (7 downto 0);
           SETPOinterrupt : in STD_LOGIC_VECTOR  (7 downto 0);
           RES      : out STD_LOGIC_VECTOR (7 downto 0);
           POS      : out STD_LOGIC                   );
end component;

signal rps,setpointerrupt,res : std_logic_vector(7 downto 0);
signal pos,clock        : std_logic                   ;

begin

uut: comp
port map( CLOCK   =>clock    ,
          RPS     =>rps      ,
          SETPOinterrupt=>setpointerrupt ,
          RES     =>res      ,
          POS     =>pos
        );

process
begin
    clock<='0';
    wait for 5 ns;
    clock<='1';
    wait for 5ns;
end process;         
           
process
begin
    setpointerrupt<="10000000";
    rps     <="00000000";
    wait for 1 ms;
    setpointerrupt<="10000000";
    rps     <="00101010";
    wait for 1 ms;
    setpointerrupt<="10000000";
    rps     <="10000001";
    wait;
end process;
end Behavioral;
