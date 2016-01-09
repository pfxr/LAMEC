----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2015 17:21:30
-- Design Name: 
-- Module Name: BCDtoBIN - Behavioral
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

entity BCDtoBIN is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           D1 : in STD_LOGIC_VECTOR (3 downto 0);
           D2 : in STD_LOGIC_VECTOR (3 downto 0);
           D3 : in STD_LOGIC_VECTOR (3 downto 0);
           D4 : in STD_LOGIC_VECTOR (3 downto 0);
           RES : out STD_LOGIC_VECTOR (13 downto 0));
end BCDtoBIN;

architecture Behavioral of BCDtoBIN is
    signal result:std_logic_vector(13 downto 0);
    
begin

process(CLOCK)
    variable  res:natural range 0 to 9999;
    variable mil: natural range 0 to 9000;
    variable cent: natural range 0 to 900;
    variable dez: natural range 0 to 90;
    variable uni:natural range 0 to 9;
begin
    if rising_edge(CLOCK) then
        uni:=conv_interrupteger(D1);
        dez:=conv_interrupteger(D2)*10;
        cent:=conv_interrupteger(D3)*100;
        mil:=conv_interrupteger(D4)*1000;
        res:=mil+cent+dez+uni;
        result<=std_logic_vector(to_unsigned(res,14));
    end if;
end process;

process(CLOCK,RESET)
begin
    if RESET='1' then
        RES<=(others=>'0');
    elsif rising_edge(CLOCK) then
        RES<=result;
    end if;
    
end process;

end Behavioral;
