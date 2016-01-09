----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.10.2015 22:23:14
-- Design Name: 
-- Module Name: contar - Behavioral
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

entity contar is
   Port (CLOCK: in STD_LOGIC;
         RESET: in STD_LOGIC;
         TICK: in STD_LOGIC;
         D1: out STD_LOGIC_VECTOR(3 downto 0);
         D2: out STD_LOGIC_VECTOR(3 downto 0);
         D3: out STD_LOGIC_VECTOR(3 downto 0);
         D4: out STD_LOGIC_VECTOR(3 downto 0));
end contar;

architecture Behavioral of contar is

signal digito1,digito2,digito3,digito4:std_logic_vector(3 downto 0):=(others=>'0');
signal inc_dez,inc_cent,inc_mil,inc_emp:std_logic:='0';
begin
D1<=digito1;
D2<=digito2;
D3<=digito3;
D4<=digito4;

cont_uni: entity work.cont(Behavioral)
    port map( CLOCK=>CLOCK,
              INC=>TICK,
              RESET=>RESET,
              COUNT=>digito1,
              INC_OUT=>inc_dez);

cont_dez: entity work.cont(Behavioral)
    port map(CLOCK=>CLOCK,
             INC=>inc_dez,
             RESET=>RESET,
             COUNT=>digito2,
             INC_OUT=>inc_cent);

cont_cent: entity work.cont(Behavioral)
    port map(CLOCK=>CLOCK,
             INC=>inc_cent,
             RESET=>RESET,
             COUNT=>digito3,
             INC_OUT=>inc_mil);
             
cont_mil: entity work.cont(Behavioral)
    port map(CLOCK=>CLOCK,
             INC=>inc_mil,
             RESET=>RESET,
             COUNT=>digito4,
             INC_OUT=>inc_emp);



end Behavioral;
