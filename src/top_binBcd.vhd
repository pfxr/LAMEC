----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:03:21 11/04/2015 
-- Design Name: 
-- Module Name:    top_binBcd - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_binBcd is
    Port ( CLOCK: in  STD_LOGIC                    ;
           RESET: in  STD_LOGIC                    ;
		   BIN  : in  STD_LOGIC_VECTOR(12 downto 0);
		   DONE : OUT STD_LOGIC                    ;
		   DIG0 : out STD_LOGIC_VECTOR(3 downto 0) ;
		   DIG1 : out STD_LOGIC_VECTOR(3 downto 0) ;
		   DIG2 : out STD_LOGIC_VECTOR(3 downto 0) ;
		   DIG3 : out STD_LOGIC_VECTOR(3 downto 0)
	 );
end top_binBcd;

architecture Behavioral of top_binBcd is
	type estado is (IDDLE,CALCULATE);
	signal state_reg, state_next:estado;

	
	signal dig_0,dig_1,dig_2,dig_3,dig0_aux,dig1_aux,dig2_aux,dig3_aux: STD_LOGIC_VECTOR(3 downto 0):=(others=>'0');
	signal lastbin: STD_LOGIC_VECTOR(12 downto 0):=(others=>'0');
	signal start,ready: STD_LOGIC:='0'; 
	
begin

	binbcd_unit: entity work.bin_to_bcd (Behavioral)
	port map (clk=>CLOCK,reset=>RESET,start=>start,bin=>BIN,done_tick=>OPEN,ready=>ready,
					bcd0=>dig_0,bcd1=>dig_1,bcd2=>dig_2,bcd3=>dig_3);

	
	process(CLOCK,RESET)
	begin
		if (RESET='1') then 
			state_reg<=IDDLE;
		elsif rising_edge(CLOCK) then
			state_reg<=state_next;
		end if;
	end process;

	PROCESS(CLOCK,state_reg,BIN,ready,lastbin,DIG0_aux,DIG1_aux,DIG2_aux,DIG3_aux,dig_0,dig_1,dig_2,dig_3)
	begin
		DONE<='0';
		start<='0';
		lastbin<=lastbin;
		DIG0_aux<=DIG0_aux;
		DIG1_aux<=DIG1_aux;
		DIG2_aux<=DIG2_aux;
		DIG3_aux<=DIG3_aux;
		state_next<=state_reg;
    if rising_edge(CLOCK) then
	 case state_reg is
	 	when IDDLE=>
	 		if BIN/=lastbin then
	 			lastbin<=bin;
	 			state_next<=CALCULATE;
	 			start<='1';
	 		end if;
	 		
	 	when CALCULATE=>
	 		if READY='1' then
	 			DONE<='1';
	 			DIG0_aux<=dig_0;
	 			DIG1_aux<=dig_1;
	 			DIG2_aux<=dig_2;
	 			DIG3_aux<=dig_3;
	 			state_next<=IDDLE;
	 		end if;
	 end case;
	end if;
	end process;
	
	DIG0<=DIG0_aux;
	DIG1<=DIG1_aux;
	DIG2<=DIG2_aux;
	DIG3<=DIG3_aux;
		
end Behavioral;

