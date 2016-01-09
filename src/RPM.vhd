----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2015 18:15:37
-- Design Name: 
-- Module Name: RPM - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RPS is
    Port ( CLOCK : in  STD_LOGIC                    ;
           RESET : in  STD_LOGIC                    ;
           SEL   : in  STD_LOGIC                    ;
           TICK  : in  STD_LOGIC                    ;
           R     : out STD_LOGIC_VECTOR(7 downto 0));
end RPS;

architecture Behavioral of RPS is
    
signal rot             : std_logic_vector (7 downto  0) :=(others=>'0');
signal conta           : std_logic_vector (7 downto  0) :=(others=>'0');
signal cont_sel        : std_logic_vector (26 downto 0) :=(others=>'0');
signal interrupt_timer : std_logic                      :=         '0' ;
signal flag            : std_logic                      :=         '0' ;
signal rst_cont        : std_logic                      :=         '0' ; 
signal tick_voltas     : std_logic                      :=         '0' ;
    
begin

process (SEL)
begin
    if SEL='0' then
        cont_sel<="000001011111010111100001000";
    else
        cont_sel<="000000000000000000000000000";
    end if;
end process;


contador_enc:entity work.count(Behavioral)
generic map(LIMIT => "11111111" )
port    map(CLOCK => CLOCK       ,
            RESET => rst_cont    ,
            TICK  => TICK        ,
            CONT  => conta       ,
            SAIDA => tick_voltas);
         


timer: entity work.clock_divide(Behavioral)
port    map(CLOCK  => CLOCK                     ,
            RESET  => RESET                     ,
            BITS   => cont_sel                  ,
            SAIDA  => interrupt_timer                );
         
process(interrupt_timer,CLOCK,RESET)
begin
        if RESET='1' then
            rot<=(others=>'0');
        elsif rising_edge(interrupt_timer) then
            rot<=conta;
        end if;
end process;

R        <= rot                ;
rst_cont <= RESET or interrupt_timer ;


end Behavioral;
