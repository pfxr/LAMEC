----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2015 23:32:56
-- Design Name: 
-- Module Name: Write - Behavioral
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

entity Write is
  Port (
    CLOCK: in STD_LOGIC;
    RESET: in STD_LOGIC;
    GO   : in STD_LOGIC;
    TX   : out STD_LOGIC;
    UNI  : in STD_LOGIC_VECTOR(3 downto 0);
    DEZ  : in STD_LOGIC_VECTOR(3 downto 0);
    CEN  : in STD_LOGIC_VECTOR(3 downto 0) );
end Write;

architecture Behavioral of Write is

type fsm_tx is(espera,escreve,terminou);
signal actual_tx,proximo_tx:fsm_tx;

type nome is (inicio,P,F,X,fim);
signal actual,proximo:nome;

signal data,proximo_data:std_logic_vector(7 downto 0);
signal en,rx,tx_busy,tx_start:std_logic:='0';
signal d0,d1,d2 : std_logic_vector(7 downto 0);
begin

UART: entity work.UART(Behavioral)
    PORT MAP(CLOCK=>CLOCK,
             RESET=>RESET,
             WORD=>data,
             ENABLE=>en,
             TX_B=>tx_busy,
             UART_TX=>TX,
             UART_RX=>rx);


process(actual_tx,actual,CLOCK)
begin
    if rising_edge(CLOCK) then
        if actual_tx=espera and actual/=fim then
            en<='1';
        else
            en<='0';
        end if;
    end if;
end process; 
  


process(CLOCK,actual_tx,tx_busy,actual)
begin  
    if rising_edge(CLOCK) then
        case actual_tx is
            when espera=>
                if tx_busy='1' then
                    proximo_tx<=escreve;
                end if;
            when escreve=>
                if tx_busy='0' then                    
                    proximo_tx<=terminou;
                end if;
           when terminou=>
                    proximo_tx<=espera;
        end case;
    end if;
end process;            
process(actual,CLOCK)
begin
    if rising_edge(CLOCK) then
    case actual is
        when inicio=>
            proximo_data<=x"0A";
        when P=>
            proximo_data<=d2;
        when F=>
            proximo_data<=d1;
        when X=>
            proximo_data<=d0;
        when fim=>
            proximo_data<=x"0D";
    end case;
    end if;
end process; 
           
process(CLOCK,actual_tx)
begin
    if actual_tx=espera then
        tx_start<='1';
    else
        tx_start<='0';
    end if;
end process;
           
FSM_word:process(actual,actual_tx,CLOCK)
begin
    if rising_edge(CLOCK) then
        if actual_tx=terminou then
                if actual=inicio then
                    proximo<=P;
                elsif actual=P then
                    proximo<=F;
                elsif actual=F then
                    proximo<=X;
                elsif actual=X then
                    proximo<=fim;
                end if;
        elsif actual_tx=espera then
            if actual=fim then
                if GO='1' then
                    d0<=x"3"&UNI;
                    d1<=x"3"&DEZ;
                    d2<=x"3"&CEN;
                    proximo<=inicio;
                end if;
            end if;
        end if;
    end if;
end process;            
            
            
process(CLOCK,RESET,proximo)
begin
    if rising_edge(CLOCK) then
        if RESET='1' then
            --proximo<=inicio;
            actual<=inicio;
            actual_tx<=espera;
            --proximo_tx<=espera;
            data<=(others=>'0');
        else
            actual<=proximo;
            actual_tx<=proximo_tx;
            data<=proximo_data;
        end if;
    end if;
end process; 


end Behavioral;
