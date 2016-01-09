----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:24:50 11/11/2008 
-- Design Name: 
-- Module Name:    bin_to_bcd - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;


entity bin_to_bcd is

    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           start : in  STD_LOGIC;						   -- start conversion signal
           bin : in  STD_LOGIC_VECTOR (12 downto 0);  -- binary to be converted
           done_tick : out  STD_LOGIC;					   -- signals conversion end
			  ready : out  STD_LOGIC;						   -- ready for next conversion
           bcd0 : out  STD_LOGIC_VECTOR (3 downto 0); -- least significant BCD digit
           bcd1 : out  STD_LOGIC_VECTOR (3 downto 0);
           bcd2 : out  STD_LOGIC_VECTOR (3 downto 0);
           bcd3 : out  STD_LOGIC_VECTOR (3 downto 0));-- most significant BCD digit
end bin_to_bcd;

architecture Behavioral of bin_to_bcd is

	type state_type is (idle, op, done);					-- user-defined enumerated data type for state assignment
	signal state_reg, state_next: state_type;
	
	signal p2s_reg, p2s_next: std_logic_vector (12 downto 0);
	signal n_reg, n_next: unsigned (3 downto 0);
	signal bcd3_reg, bcd2_reg, bcd1_reg, bcd0_reg: unsigned (3 downto 0);    -- BCD digit registers
	signal bcd3_next, bcd2_next, bcd1_next, bcd0_next: unsigned(3 downto 0); -- BCD next digit registers value
	signal bcd3_tmp, bcd2_tmp, bcd1_tmp, bcd0_tmp: unsigned(3 downto 0);		 -- BCD temporary calculation values

begin

-- state and data registers

	process (clk, reset)
	begin
		if reset='1' then
			state_reg <= idle;
			p2s_reg <= (others=> '0');
			n_reg <= (others=> '0');
			bcd3_reg <= (others=> '0');
			bcd2_reg <= (others=> '0');
			bcd1_reg <= (others=> '0');
			bcd0_reg <= (others=> '0');
		elsif (clk'event and clk= '1') then
			state_reg <= state_next;
			p2s_reg <= p2s_next;
			n_reg <= n_next;
			bcd3_reg <= bcd3_next;
			bcd2_reg <= bcd2_next;
			bcd1_reg <= bcd1_next;
			bcd0_reg <= bcd0_next;
		end if;
	end process;

-- fsmd next-state logic / data path operations

	process (state_reg,start,p2s_reg,n_reg,n_next,bin,
				bcd0_reg,bcd1_reg,bcd2_reg,bcd3_reg,
				bcd0_tmp,bcd1_tmp,bcd2_tmp,bcd3_tmp)
	begin
		state_next <= state_reg;
		ready <= '0';										-- invalid output BCD digits; conversion in progress
		done_tick <= '0';									
		p2s_next <= p2s_reg;
		bcd0_next <= bcd0_reg;
		bcd1_next <= bcd1_reg;
		bcd2_next <= bcd2_reg;
		bcd3_next <= bcd3_reg;
		n_next <= n_reg;
		
		case state_reg is
			when idle =>
				ready <= '1';								-- valid output BCD digits available
				
				if start='1' then							-- start conversion
						state_next <= op;
						bcd3_next <= (others=> '0');
						bcd2_next <= (others=> '0');
						bcd1_next <= (others=> '0');
						bcd0_next <= (others=> '0');
						n_next <="1101"; 					-- index
						p2s_next <= bin; 					-- input shift register
						state_next <= op;
				end if;
				
			when op =>															 -- shift in binary bit
					p2s_next <= p2s_reg (11 downto 0) & '0';
					bcd0_next <= bcd0_tmp(2 downto 0) & p2s_reg(12); -- shift 4 BCD digits
					bcd1_next <= bcd1_tmp(2 downto 0) & bcd0_tmp(3);
					bcd2_next <= bcd2_tmp(2 downto 0) & bcd1_tmp(3);
					bcd3_next <= bcd3_tmp(2 downto 0) & bcd2_tmp(3);
					n_next <= n_reg - 1;
					
					if (n_next=0) then
							state_next <= done;
					end if;
					
			when done =>
				state_next <= idle;				
				done_tick <= '1';					-- conversion done
		end case;
		
	end process;

-- data path function units
-- four BCD adjustment circuits

	bcd0_tmp <= bcd0_reg + 3 when bcd0_reg > 4 else
					bcd0_reg;
	bcd1_tmp <= bcd1_reg + 3 when bcd1_reg > 4 else
					bcd1_reg;
	bcd2_tmp <= bcd2_reg + 3 when bcd2_reg > 4 else
					bcd2_reg;
	bcd3_tmp <= bcd3_reg + 3 when bcd3_reg > 4 else
					bcd3_reg;

-- Output

	bcd0 <= std_logic_vector(bcd0_reg);
	bcd1 <= std_logic_vector(bcd1_reg);
	bcd2 <= std_logic_vector(bcd2_reg);
	bcd3 <= std_logic_vector(bcd3_reg);


end Behavioral;

