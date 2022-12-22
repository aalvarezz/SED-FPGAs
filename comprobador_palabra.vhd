library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comprobador_palabra is
    port(
    reset   : in std_logic;
    clk     : in std_logic;
    enable  : in std_logic;
    word    : in std_logic_vector(7 downto 0);
	LEDS : out std_logic_vector(1 downto 0);
    correct : out std_logic
    );
end comprobador_palabra;

architecture Behavioral of comprobador_palabra is
begin
    comparador : process(reset, clk, enable, word)
        variable password : std_logic_vector(7 downto 0);
    begin
        if reset = '0' then
            password := "00000000";
            correct <= '0';
		LEDS(0) <= '0';
		LEDS(1) <= '0';
        end if;
        
        if enable = '1' then --Registro
            correct <= '1';
            password := word; --Se almacena la palabra introducida como contraseña
		LEDS(0) <= '1';
        else
            correct <= '0';
		LEDS(0) <= '0';
		LEDS(1) <= '0';
        end if;
        
        if enable = '0' and password = word then --Log in
            correct <= '1';
		LEDS(0) <= '1';
        else
            correct <= '0';
		LEDS(1) <= '1';
        end if;
    end process;
end Behavioral;