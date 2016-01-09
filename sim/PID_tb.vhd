----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.11.2015 20:41:08
-- Design Name: 
-- Module Name: PID_tb - Behavioral
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

entity PID_tb is
end PID_tb;


architecture Behavioral of PID_tb is

component PID
    Port ( CLOCK    : in  STD_LOGIC                    ;
           RESET    : in  STD_LOGIC                    ;
           SETPOINT : in  STD_LOGIC_VECTOR (7 downto 0);
           RPS      : in  STD_LOGIC_VECTOR (7 downto 0);
           CONTROLO : out STD_LOGIC_VECTOR (7 downto 0);
           PWM_INIT : out STD_LOGIC)                   ;
end component;

signal clock,reset:std_logic;
signal setpoint: std_logic_vector(7 downto 0);
signal controlo,rps: std_logic_vector(7 downto 0);


begin

uut: PID
    port map(clock,reset,setpoint,rps,controlo);
process 
begin
    clock<='0';
    wait for 5ns;
    clock<='1';
    wait for 5ns;
end process;

stim_process:process
begin
    reset<='1';
    rps<="00000000";
    setpoint<="00010010";
    wait for 10ns;
    reset<='0';
    wait for 30ms;
    rps  <= "00001001";
    wait for 30ms;
    rps  <="00010000";
    wait for 30ms;
    rps  <="00010010";
    wait for 30ms;
    rps  <="00011010";
wait;
end process;

end Behavioral;
