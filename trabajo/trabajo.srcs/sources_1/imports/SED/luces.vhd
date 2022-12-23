library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity luces is
    port (
    RST          : in std_logic;
	CLK          : in std_logic;
	LEDS_FP      : in std_logic_vector(3 downto 0);
	LEDS_FSM     : in std_logic;
	LEDS_CP      : in std_logic_vector(1 downto 0);
    LEDS_OUT     : out std_logic_vector(15 downto 0);
	LEDS_OUT_BGR : out std_logic_vector(2 downto 0)
    );
end luces;

architecture BEHAVIORAL of luces is
begin

    process(RST, CLK)
    begin
        if RST = '0' then
            ASIGNACION0 : for k in 0 to 15 loop
                LEDS_OUT(k) <= '0';
            end loop ASIGNACION0;
            ASIGNACION1 : for k in 0 to 2 loop
                LEDS_OUT_BGR(k) <= '0';
            end loop ASIGNACION1;
        end if;
        
        if rising_edge(CLK) then
            if LEDS_FSM = '0' then
                ASIGNACION2 : for k in 0 to 15 loop
                    LEDS_OUT(k) <= '0';
                end loop ASIGNACION2;
        
                ASIGNACION3 : for k in 0 to 3 loop
                    LEDS_OUT(k) <= LEDS_FP(k);
                end loop ASIGNACION3;
                
                if LEDS_CP(0) = '1' then --RGB verde
                    LEDS_OUT_BGR(0) <= '0';
                    LEDS_OUT_BGR(1) <= '1';
                    LEDS_OUT_BGR(2) <= '0';
                elsif LEDS_CP(1) = '1' then --RGB rojo
                    LEDS_OUT_BGR(0) <= '0';
                    LEDS_OUT_BGR(1) <= '0';
                    LEDS_OUT_BGR(2) <= '1';
                end if;
            elsif LEDS_FSM = '1' then --Aquí iría la funcionalidad con CLK
                ASIGNACION4 : for j in 0 to 15 loop
                    LEDS_OUT(j) <= '1';
                end loop ASIGNACION4;
            end if;
        end if;
    
    end process;
end BEHAVIORAL;
