library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART is
      Port (
        CLOCK: IN STD_LOGIC;
        RESET: IN STD_LOGIC;
        WORD: IN STD_LOGIC_VECTOR(7 downto 0); 
        ENABLE: IN STD_LOGIC;  
        TX_B: out STD_LOGIC;     
        UART_TX: OUT STD_LOGIC;
        UART_RX: IN STD_LOGIC     
       );
end UART;

architecture Behavioral of UART is

--signal tx_data: std_logic_vector(7 downto 0);
signal tx_start: std_logic:='0';
signal tx_busy:std_logic;
begin

TX: entity work.TX_Unit (Behavioral)
    Port map(CLOCK=>CLOCK,
             RESET=>RESET,
             START=>tx_start,
             BUSY=>tx_busy,
             DATA=>WORD,
             TX=>UART_TX);

TX_B<=tx_busy;

process(CLOCK,RESET,WORD,tx_busy)
begin
    if RESET='1' then
        tx_start<='0';
    elsif rising_edge(CLOCK) then
        if ENABLE='1' and tx_busy='0' then
            tx_start<='1';
        else
            tx_start<='0';
        end if;
   end if;
end process;



end Behavioral;
