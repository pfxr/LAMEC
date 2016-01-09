----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2015 18:45:34
-- Design Name: 
-- Module Name: TX_Unit - Behavioral
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

entity TX_Unit is
  Port ( 
    CLOCK: IN STD_LOGIC;
    RESET: IN STD_LOGIC;
    START: IN STD_LOGIC;
    BUSY: OUT STD_LOGIC;
    DATA: IN STD_LOGIC_VECTOR(7 downto 0);
    TX: OUT STD_LOGIC  
  );
end TX_Unit;

architecture Behavioral of TX_Unit is

signal prscl: integer range 0 to 868:=0;
signal index: integer range 0 to 9:=0;
signal datafll: std_logic_vector(9 downto 0);
signal tx_flag,busy_sig,tx_sig: std_logic:='0';


begin
TX<=tx_sig;
BUSY<=busy_sig;
process(CLOCK,tx_flag,START,DATA,tx_flag,prscl)
begin
    if rising_edge(CLOCK) then
        if RESET='1' then
            datafll<=(others=>'0');
            tx_flag<='0';
            busy_sig<='0';
            tx_sig<='0';
            index<=0;
            prscl<=0;
        elsif tx_flag='0' and START='1' then
            tx_flag<='1';
            busy_sig<='1';
            datafll(0)<='0';
            datafll(9)<='1';
            datafll(8 downto 1)<=DATA;
        elsif tx_flag='1' then
            if prscl<868 then
                prscl<=prscl+1;
            else
                prscl<=0;
            end if;
            if prscl=434 then
                tx_sig<=datafll(index);
                if index<9 then
                    index<=index+1;
                else
                    tx_flag<='0';
                    busy_sig<='0';
                    index<=0;
                end if;
            end if;
        end if;
    end if;
end process; 

end Behavioral;
