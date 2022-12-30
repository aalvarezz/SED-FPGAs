library ieee;
use ieee.std_logic_1164.all;

entity tb_luces is
end tb_luces;

architecture tb of tb_luces is

    component luces
        port (RST          : in std_logic;
              CLK          : in std_logic;
              LEDS_FP      : in std_logic_vector (3 downto 0);
              LEDS_FSM     : in std_logic;
              LEDS_CP      : in std_logic_vector (1 downto 0);
              LEDS_OUT     : out std_logic_vector (15 downto 0);
              LEDS_OUT_BGR : out std_logic_vector (2 downto 0));
    end component;

    signal RST          : std_logic;
    signal CLK          : std_logic;
    signal LEDS_FP      : std_logic_vector (3 downto 0);
    signal LEDS_FSM     : std_logic;
    signal LEDS_CP      : std_logic_vector (1 downto 0);
    signal LEDS_OUT     : std_logic_vector (15 downto 0);
    signal LEDS_OUT_BGR : std_logic_vector (2 downto 0);

    constant k      : time := 10 ns;

begin

    uut : luces
    port map (RST          => RST,
              CLK          => CLK,
              LEDS_FP      => LEDS_FP,
              LEDS_FSM     => LEDS_FSM,
              LEDS_CP      => LEDS_CP,
              LEDS_OUT     => LEDS_OUT,
              LEDS_OUT_BGR => LEDS_OUT_BGR);

    clock: process
    begin 
        CLK<='0';
        wait for k/10;
        CLK<='1';
        wait for k/10;
    end process;

    stimuli : process
    begin
        -- Inicio
        RST <= '0';
        LEDS_FP <= (others => '0');
        LEDS_FSM <= '0';
        LEDS_CP <= (others => '0');
        wait for k;
        
        RST <= '1';
        wait for k;

        -- Leds FP
        
        --FP mete un 1
        LEDS_FSM <= '0';
        
        LEDS_FP(0) <= '1';
        LEDS_FP(1) <= '0';
        LEDS_FP(2) <= '0';
        LEDS_FP(3) <= '0';
        wait for k;
        
        --FP mete un 2
        LEDS_FSM <= '0';
        
        LEDS_FP(0) <= '1';
        LEDS_FP(1) <= '1';
        LEDS_FP(2) <= '0';
        LEDS_FP(3) <= '0';
        wait for k;
        
        --FP mete un 3
        LEDS_FSM <= '0';
        
        LEDS_FP(0) <= '1';
        LEDS_FP(1) <= '1';
        LEDS_FP(2) <= '1';
        LEDS_FP(3) <= '0';
        wait for k;
        
        --FP mete un 4
        LEDS_FSM <= '0';
        
        LEDS_FP(0) <= '1';
        LEDS_FP(1) <= '1';
        LEDS_FP(2) <= '1';
        LEDS_FP(3) <= '1';
        wait for 4*k;
        
        --CP indica verde
        LEDS_FSM <= '0';
        
        LEDS_CP(0) <= '1';
        LEDS_CP(1) <= '0';
        wait for k;
        
        --CP indica rojo
        LEDS_FSM <= '0';
        
        LEDS_CP(0) <= '0';
        LEDS_CP(1) <= '1';
        wait for 4*k;
        
        --Compruebo que la FSM no deja que lleguen instrucciones de FP
        --Deberían encenderse todos
        --Falta añadir que se apaguen los de CP
        LEDS_FSM <= '1';
        
        LEDS_FP(0) <= '1';
        LEDS_FP(1) <= '1';
        LEDS_FP(2) <= '0';
        LEDS_FP(3) <= '0';
        wait for 4*k;

    end process;

end tb;