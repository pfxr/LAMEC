library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity PID is
    Port ( CLOCK    : in  STD_LOGIC                    ;
           RESET    : in  STD_LOGIC                    ;
           SEL      : in  STD_LOGIC                    ;
           SETPOINT : in  STD_LOGIC_VECTOR (7 downto 0);
           RPS      : in  STD_LOGIC_VECTOR (7 downto 0);
           CONTROLO : out STD_LOGIC_VECTOR (7 downto 0);
           PWM_INIT : out STD_LOGIC)                   ;
end PID;

architecture Behavioral of PID is

type fsm_pid is( init
                ,ler
                ,calculo
                ,saida
                ,update);
                
signal proximo,actual:fsm_pid;

signal kp        : integer                                      ;
signal ki        : integer                                      ;
signal kd        : integer                                      ;
signal int_timer : std_logic                    :=          '0' ;
signal interrupt : std_logic                    :=          '0' ;
signal pos       : std_logic                    :=          '0' ;
signal sinal     : std_logic                    :=          '0' ;
signal error     : std_logic_vector(7 downto 0) := (others=>'0');
signal erro      : std_logic_vector(7 downto 0) := (others=>'0');
signal erro1     : std_logic_vector(7 downto 0) := (others=>'0');
signal erro2     : std_logic_vector(7 downto 0) := (others=>'0');
signal u1        : std_logic_vector(7 downto 0) := (others=>'0');
signal u2        : std_logic_vector(7 downto 0) := (others=>'0');
signal rps_act   : std_logic_vector(7 downto 0) := (others=>'0');
signal rps_ant   : std_logic_vector(7 downto 0) := (others=>'0');
signal prop      : std_logic_vector(13 downto 0):= (others=>'0');
signal int       : std_logic_vector(13 downto 0):= (others=>'0');
signal der       : std_logic_vector(13 downto 0):= (others=>'0');
begin

freq_amostragem: entity work.clock_divide(Behavioral)
port    map(CLOCK  => CLOCK        ,
            RESET  => RESET        ,
            BITS=>"000001011111010111100001000",
            SAIDA  => int_timer   );

ERRO_calc: entity work.comp(Behavioral)
port    map(CLOCK    => CLOCK         ,
            RPS      => RPS           ,
            SETPOINT => SETPOINT      ,
            RES      => error         ,
            POS      => pos          );
          

CONTROLO <= u1;

process(CLOCK,int_timer)
begin
    if rising_edge(CLOCK) then
        if int_timer='1' then
            interrupt<='1';
        else
            interrupt<='0';
       end if;
    end if;
end process;

process(actual,interrupt)
begin
        case actual is
            when init=>
                if interrupt='1' then
                   proximo<=ler;
                else
                   proximo<=init;
                end if;
            when ler=>
                proximo<=calculo;
            when calculo=>
                proximo<=saida;
            when saida=>
                proximo<=update;
            when update=>
                if interrupt='1' then
                    proximo<=ler;
                else
                    proximo<=update;
                end if;     
        end case;
end process;

process(actual,CLOCK,error,pos,RPS)
variable calc  : integer range -512 to 512 := 0   ;
variable PTerm : integer                   := 0   ;
variable ITerm : integer                   := 0   ;
variable DTerm : integer                   := 0   ;
variable PTerm1: std_logic_vector(13 downto 0)    ;
variable ITerm1: std_logic_vector(13 downto 0)    ;
variable DTerm1: std_logic_vector(13 downto 0)    ;
begin
    PWM_INIT<='0';
    if rising_edge(CLOCK) then
        case actual is
            when init=>
                if SEL='0' then
                    kp<=32 ;  --0.8*64;
                    ki<=2 ; --nao usado p/ causa do shift do erro; 
                    kd<=300 ; --180;
                 else
                    kp<=0;
                    ki<=0;
                    kd<=0;
                 end if;
            when ler=>
                erro    <= error;
                sinal   <= pos  ;
                rps_act <= RPS  ;
            when calculo=>
                if sinal='1' then
                    ITerm:= ITerm + (conv_integer(erro(7 downto 1)));
                elsif sinal='0' then
                    ITerm:= ITerm - (conv_integer(erro(7 downto 1)));
                end if;
                --if ITerm>255 then
                --    ITerm:=255;
                --elsif ITerm<0 then
                --    ITerm:=0;
                --else
                --    ITerm:=ITerm;
                --end if;
                ITerm1 := std_logic_vector(to_unsigned(ITerm,14));
                int<=ITerm1;--std_logic_vector(to_unsigned(ITerm1),14);
                
                DTerm:=kd* (conv_integer(rps_act) - conv_integer(rps_ant));      
                DTerm1 := std_logic_vector(to_unsigned(DTerm,14));    
                der<=DTerm1;--std_logic_vector(to_unsigned(DTerm1,8));
                if sinal='1' then
                    PTerm := integer(kp * conv_integer(erro));
                elsif sinal='0' then
                    PTerm := - integer(kp * conv_integer(erro));
                end if; 
                if PTerm<0 then 
                    PTerm:=0;
                elsif PTerm>255 then
                    --PTerm:=255;
                else
                    PTerm:=PTerm;
                end if;
                PTerm1:= std_logic_vector(to_unsigned(PTerm,14));   
                prop<=PTerm1;    
                calc := 0;      
                calc := calc + conv_integer(PTerm1(13 downto 8));
                calc := calc + conv_integer(ITerm1(13 downto 0)); 
                calc := calc + conv_integer(DTerm1(13 downto 8));  
                if calc>255 then
                    calc:=255;
                elsif calc<0 then
                    calc:=0;
                end if;
                
                u1   <=std_logic_vector(to_unsigned(calc,8));
            when saida=>
                PWM_INIT<='1';
            when update=>
                rps_ant<=rps_act;         
            end case;
    end if;
end process;

process(RESET,CLOCK)
begin
    if RESET='1' then
        actual<=init;
    elsif rising_edge(CLOCK) then
        actual<=proximo;
    end if;    
end process;

end Behavioral;
