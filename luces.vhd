library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EDGEDTCTR is
    port (
        LEDS_LOGIN : in std_logic_vector(3 downto 0);
	LEDS_FSM : in std_logic_vector(15 downto 0);
	LEDS_FSM_BRG : in std_logic_vector(2 downto 0);
        LEDS_OUT : out std_logic_vector(15 downto 0);
	LEDS_OUT_BGR : out std_logic_vector(15 downto 0)
	LEDS_OUT_BGR : out std_logic_vector(2 downto 0)
    );
end EDGEDTCTR;

architecture BEHAVIORAL of EDGEDTCTR is

begin
	asignacion: for k in 0 to 15 loop
		if k<4 then
			LEDS_OUT(k) <= LEDS_LOGIN(k) or LEDS_FSM(k);
		else
			LEDS_OUT(k) <= LEDS_FSM(k);
		end if;
	end loop asignacion;

	LEDS_OUT_BGR <= LEDS_FSM_BRG;
end BEHAVIORAL;