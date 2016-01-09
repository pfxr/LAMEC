----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.09.2015 18:15:47
-- Design Name: 
-- Module Name: relogio - Behavioral
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

entity relogio is
    Port ( CLOCK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           D0    : in  STD_LOGIC_VECTOR(3 downto 0);   
           D1    : in  STD_LOGIC_VECTOR(3 downto 0);   
           D2    : in  STD_LOGIC_VECTOR(3 downto 0);   
           D3    : in  STD_LOGIC_VECTOR(3 downto 0);   
           SAIDAS: out STD_LOGIC_VECTOR(7 downto 0);
           DISP  : out STD_LOGIC_VECTOR(3 downto 0));
end relogio;

architecture Behavioral of relogio is

signal shift    : std_logic:='0'                             ;
signal sel      : std_logic_vector(1 downto 0)               ;
signal segmentos: std_logic_vector(3 downto 0):=(others=>'0');

begin
                   
shifter: entity work.clock_divide(Behavioral)
         port map(CLOCK=>CLOCK,
                 RESET=>RESET,
                 BITS=>"000000001111010000100100000",
                 SAIDA=>shift);
                  
segmento: entity work.segmentos(Behavioral)
         port map(ENTRADA=>segmentos,
                  SELECT_DISP=>sel,
                  DISP=>DISP,
                  SAIDA=>SAIDAS); 
                  

process(sel,D0,D1,D2,D3)
begin
    case sel is
        when "00" =>
            segmentos<=D0;
        when "01" =>
            segmentos<=D1;
        when "10" =>
            segmentos<=D2;
        when "11" =>
            segmentos<=D3;
        when others=>
            segmentos<="0000";
   end case;
end process;

process(CLOCK,sel,shift)
begin
    if rising_edge(CLOCK) then
        if RESET='1' then
            sel<=(others=>'0');
        else    
            if(shift='1') then
                sel<=std_logic_vector(unsigned(sel)+1);
            else 
                sel<=sel;
            end if;
        end if;
    end if;
end process;

end Behavioral;
