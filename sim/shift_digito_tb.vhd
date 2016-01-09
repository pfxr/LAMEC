library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_digito_tb is
end shift_digito_tb;




architecture Behavioral of shift_digito_tb is

component shift_digito
 Port (CLOCK:in STD_LOGIC;
      RESET: in STD_LOGIC;
      TIMER_IN:in STD_LOGIC;
      SHIFT: out STD_LOGIC_VECTOR(1 downto 0) );
end component;

signal clock,reset,timer_in:std_logic:='0';
signal shift:std_logic_vector(1 downto 0);

begin

uut: shift_digito
port map(clock,reset,timer_in,shift);

process 
begin
    clock<='0';
    wait for 5ns;
    clock<='1';
    wait for 5ns;
end process;

process
begin
    reset<='1';
    wait for 10ns;
    reset<='0';
    for I in 0 to 10 loop
        timer_in<=not timer_in;
        wait for 20ns;
    end loop;
wait;
end process;

end Behavioral;
