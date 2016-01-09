----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2015 20:31:49
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port ( CLOCK  : in  STD_LOGIC                    ;
           RESET  : in  STD_LOGIC                    ;
           ENTRADA: in  STD_LOGIC_VECTOR(12 downto 0);
           SEG    : out STD_LOGIC_VECTOR(7 downto 0) ;
           SEL    : out STD_LOGIC_VECTOR(3 downto 0) ;
           UNI    : out STD_LOGIC_VECTOR(3 downto 0) ;
           DEZ    : out STD_LOGIC_VECTOR(3 downto 0) ;
           CEN    : out STD_LOGIC_VECTOR(3 downto 0) ;
           MIL    : out STD_LOGIC_VECTOR(3 downto 0));
end top;

architecture Behavioral of top is

signal unidades : std_logic_vector(3 downto 0);
signal dezenas  : std_logic_vector(3 downto 0);
signal centenas : std_logic_vector(3 downto 0);
signal milhares : std_logic_vector(3 downto 0);

signal segmentos: std_logic_vector(7 downto 0);
signal sele     : std_logic_vector(3 downto 0);

begin

SEG<=segmentos;
SEL<=sele     ;

UNI<=unidades;
DEZ<=dezenas ;
CEN<=centenas;
MIL<=milhares;

BCD: entity work.top_binBcd(Behavioral)
    port map(   CLOCK=> CLOCK         ,
                RESET=> RESET         ,
                BIN  => ENTRADA       ,
                DONE => open          ,
                DIG0 => unidades      ,
                DIG1 => dezenas       ,
                DIG2 => centenas      ,
                DIG3 => milhares    ) ;

seg7: entity work.relogio(Behavioral)
    port map( CLOCK  => CLOCK    ,
              RESET  => RESET    ,
              D0     => unidades ,
              D1     => dezenas  ,
              D2     => centenas ,
              D3     => milhares ,
              SAIDAS => segmentos,
              DISP   => sele    ); 
   
end Behavioral;
