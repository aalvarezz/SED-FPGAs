library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LUCES is
    port (
	CLK : in std_logic;
	LEDS_FP : in std_logic_vector(3 downto 0);
	LEDS_FSM : in std_logic;
	LEDS_CP_BGR_CORRECTO : in std_logic;
	LEDS_CP_BGR_INCORRECTO : in std_logic;

        LEDS_OUT : out std_logic_vector(15 downto 0);
	LEDS_OUT_BGR : out std_logic_vector(2 downto 0)
	
    );
end LUCES;

architecture BEHAVIORAL of EDGEDTCTR is

begin

process(CLK, LEDS_FP, LEDS_FSM, LEDS_CP_BRG_CORRECTO, LEDS_CP_BRG_INCORRECTO)

begin

if rising_edge(CLK) then
	if LEDS_FSM = '0' then
		asignacion: for k in 0 to 15 loop
			LEDS_OUT(k) <= 0;
		end loop asignacion;

		asignacion: for k in 0 to 3 loop
			LEDS_OUT(k) <= LEDS_FP(k);
		end loop asignacion;
		
		if LEDS_CP_BRG_CORRECTO = '1' then //RGB verde
			LEDS_OUT_BGR(0) <= '0';
			LEDS_OUT_BGR(1) <= '1';
			LEDS_OUT_BGR(2) <= '0';
		elsif LEDS_CP_BRG_INCORRECTO = '1' then //RGB rojo
			LEDS_OUT_BGR(0) <= '0';
			LEDS_OUT_BGR(1) <= '0';
			LEDS_OUT_BGR(2) <= '1';
		end if;
	else //Aquí iría la funcionalidad con CLK
		asignacion: for k in 0 to 15 loop
			LEDS_OUT(k) <= 1;
		end loop asignacion;
	end if;
end if;

end process;
end BEHAVIORAL;