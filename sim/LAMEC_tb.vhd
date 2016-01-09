----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2015 22:40:14
-- Design Name: 
-- Module Name: LAMEC_tb - Behavioral
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

entity LAMEC_tb is
end LAMEC_tb;

architecture Behavioral of LAMEC_tb is

component LAMEC
  Port ( CLOCK   : in  STD_LOGIC                   ;
         RESET   : in  STD_LOGIC                   ;
         TICK    : in  STD_LOGIC                   ;
         SETPOINT: in  STD_LOGIC_VECTOR(7 downto 0);
         TX      : out STD_LOGIC                   ;
         PWM_O   : out STD_LOGIC         
       );
end component;

--Inputs
signal setpoint : std_logic_vector(7 downto 0) := (others=>'0');
signal clock    : std_logic                    :=   '0'        ; 
signal reset    : std_logic                    :=   '0'        ;
signal tick     : std_logic                    :=   '0'        ;
--Outputs
signal tx       : std_logic                    :=   '0'        ;
signal pwm_o    : std_logic                    :=   '0'        ;
--signals
signal times    :integer                       :=   1          ;
signal tempo    :integer                       :=   1          ;

begin

uut: LAMEC
    port map(CLOCK    =>clock      ,
             RESET    =>reset      ,
             TICK     => tick      ,
             SETPOINT => setpoint  ,
             TX       => tx        ,
             PWM_O    => pwm_o
             );
CLK:process
begin
    clock<='1';
    wait for 5ns;
    clock<='0';
    wait for 5ns;
end process;

stim_proc:process
begin
  reset<='1';
  wait for 10ns;
  reset<='0';
  setpoint<="00010010"; 		-- 18 RPS
  times   <=1  ;
  tempo   <=1  ;
  wait for 10ns;
  for I in 0 to 3 loop
        case I is
            when 0 =>
                times<=1;		--
                tempo<=15625;	-- 1 RPS
            when 1 =>
                times<=2;		--
                tempo<=7813;	-- 2 RPS
            when 2 =>
                times<=4;		--
                tempo<=3906;	-- 4RPS 
        end case;
  wait for 31250us;
  end loop;
  
wait;
end process;

process
constant period: time := 1us;
begin
loop
    for J in 0 to times loop 
       tick<='0';
       wait for tempo*period;
       tick<='1';
       wait for tempo*period;
    end loop; 
end loop; 
wait;
end process;

end Behavioral;
