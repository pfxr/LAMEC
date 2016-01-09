----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2015 22:18:06
-- Design Name: 
-- Module Name: LAMEC - Behavioral
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

use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LAMEC is
  Port ( CLOCK     : in  STD_LOGIC                   ;
         RESET     : in  STD_LOGIC                   ;
         SEL       : in  STD_LOGIC                   ;
         TICK      : in  STD_LOGIC                   ;
         SETPOINT  : in  STD_LOGIC_VECTOR(7 downto 0);
         TX        : out STD_LOGIC                   ;
         PWM_O     : out STD_LOGIC                   ;
         SEGMENTOS : out STD_LOGIC_VECTOR(7 downto 0);
         DISP      : out STD_LOGIC_VECTOR(3 downto 0)
         );
end LAMEC;



architecture Behavioral of LAMEC is

signal rot       : std_logic_vector(7 downto 0) ;
signal u         : std_logic_vector(7 downto 0) ;
signal rbin      : std_logic_vector(12 downto 0);
signal init_uart : std_logic                    ;
signal uni       : std_logic_vector(3 downto 0) ;
signal dez       : std_logic_vector(3 downto 0) ;
signal cen       : std_logic_vector(3 downto 0) ;
signal mil       : std_logic_vector(3 downto 0) ;
begin

rbin<="00000" & rot;

RPM:entity work.RPS(Behavioral)
    port map( CLOCK => CLOCK
             ,RESET => RESET
             ,SEL   => SEL
             ,TICK  => TICK 
             ,R     => rot );

PID: entity work.PID(Behavioral)
    port map( CLOCK    => CLOCK
             ,RESET    => RESET
             ,SEL      => SEL
             ,SETPOINT => SETPOINT
             ,RPS      => rot
             ,CONTROLO => u
             ,PWM_INIT => init_uart
             );
           
PWM: entity work.PWM(Behavioral)
    port map( CLOCK  => CLOCK
             ,RESET  => RESET
             ,ENTRADA=> u
             ,SAIDA  => PWM_O);
             
UART:entity work.Write(Behavioral)
    port map( CLOCK   => CLOCK
             ,RESET   => RESET
             ,GO      => init_uart
             ,TX      => TX
             ,UNI     => uni
             ,DEZ     => dez
             ,CEN     => cen);

DISPLAY:entity work.top(Behavioral)
    port map( CLOCK    => CLOCK     
             ,RESET    => RESET     
             ,ENTRADA  => rbin        
             ,SEG      => SEGMENTOS 
             ,SEL      => DISP    
             ,UNI      => uni
             ,DEZ      => dez
             ,CEN      => cen
             ,MIL      => mil);


end Behavioral;
