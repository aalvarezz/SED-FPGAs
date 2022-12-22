----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.12.2022 10:32:16
-- Design Name: 
-- Module Name: formadorpalabra - Behavioral
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


-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity formador_palabra is
    port(
        CLK         : in std_logic; --señal de reloj
        BOTONES     : in std_logic_vector(4 downto 0); --botones con los que introducir la contraseña
        ENABLE_FP   : in std_logic; --habilita la escritura de la contraseña
        PALABRA     : out std_logic_vector(7 downto 0);
        LED_PALABRA : out std_logic_vector(3 downto 0) --leds que se encienden para indicar el numero introducido
        );
end formador_palabra;

architecture behavioral of formador_palabra is 
	type STATES is (S0, S1, S2, S3, S4); 
    signal current_state: STATES := S0; 
    signal next_state: STATES; 
    
begin
	state_register: process (CLK) 
	begin
      	current_state <= next_state;--lleva a cabo los cambios de estado
    end process;
    
    nextstate_decod: process (BOTONES, ENABLE_FP, current_state) 
    variable comodin: std_logic_vector(1 downto 0);
    begin 
    	next_state <= current_state; 
    if ENABLE_FP = '1' then--si esta habilitado se puede escribir la contraseña
        next_state <= current_state; --lleva a cabo los cambios de estado
        case current_state is
        when S0 => --ningun numero introducido
        	PALABRA <= (OTHERS => '0');--contraseña a cero
            LED_PALABRA <= (OTHERS => '0');--leds apagados
        	if BOTONES(0) = '1' then 
            	comodin(0) := '0';--sirve para actualizar correctamente la contraseña en funcion del boton elegido
                comodin(1) := '0';
                LED_PALABRA<="0001";--leds correspondientes al boton
            	next_state <= S1; --estado sucesor
             elsif BOTONES(1) = '1' then 
           	comodin(0) := '1';
                comodin(1) := '0';
                LED_PALABRA<="0011";
            	next_state <= S1;
             elsif BOTONES(2) = '1' then 
            	comodin(0) := '0';
                comodin(1) := '1';
                LED_PALABRA<="0111";
            	next_state <= S1;
             elsif BOTONES(3) = '1' then 
            	comodin(0) := '1';
                comodin(1) := '1';
                LED_PALABRA<="1111";
            	next_state <= S1;
            end if;
  		when S1 => --1 digito introducido
        	PALABRA(0) <= comodin(0);
            PALABRA(1) <= comodin(1);
        	if BOTONES(0) = '1' then 
            	comodin(0) := '0';
                comodin(1) := '0';
                LED_PALABRA<="0001";
            	next_state <= S2; 
             elsif BOTONES(1) = '1' then 
            	comodin(0) := '1';
                comodin(1) := '0';
                LED_PALABRA<="0011";
            	next_state <= S2;
             elsif BOTONES(2) = '1' then 
            	comodin(0) := '0';
                comodin(1) := '1';
                LED_PALABRA<="0111";
            	next_state <= S2;
             elsif BOTONES(3) = '1' then 
            	comodin(0) := '1';
                comodin(1) := '1';
                LED_PALABRA<="1111";
            	next_state <= S2;
            end if;
        when S2 => --2 digitos introducidos
        	PALABRA(2) <= comodin(0);
            PALABRA(3) <= comodin(1);
        	if BOTONES(0) = '1' then 
            	comodin(0) := '0';
                comodin(1) := '0';
                LED_PALABRA<="0001";
            	next_state <= S3; 
             elsif BOTONES(1) = '1' then 
            	comodin(0) := '1';
                comodin(1) := '0';
                LED_PALABRA<="0011";
            	next_state <= S3;
             elsif BOTONES(2) = '1' then 
            	comodin(0) := '0';
                comodin(1) := '1';
                LED_PALABRA<="0111";
            	next_state <= S3;
             elsif BOTONES(3) = '1' then 
            	comodin(0) := '1';
                comodin(1) := '1';
                LED_PALABRA<="1111";
            	next_state <= S3;
            end if;
        when S3 => --3 digitos introducidos
        	PALABRA(4) <= comodin(0);
            PALABRA(5) <= comodin(1);
        	if BOTONES(0) = '1' then 
            	comodin(0) := '0';
                comodin(1) := '0';
                LED_PALABRA<="0001";
            	next_state <= S4; 
             elsif BOTONES(1) = '1' then 
            	comodin(0) := '1';
                comodin(1) := '0';
                LED_PALABRA<="0011";
            	next_state <= S4;
             elsif BOTONES(2) = '1' then 
            	comodin(0) := '0';
                comodin(1) := '1';
                LED_PALABRA<="0111";
            	next_state <= S4;
             elsif BOTONES(3) = '1' then 
            	comodin(0) := '1';
                comodin(1) := '1';
                LED_PALABRA<="1111";
            	next_state <= S4;
            end if;
        when S4 => --4 digitos introducidos
 			PALABRA(6) <= comodin(0);
            PALABRA(7) <= comodin(1);
            if BOTONES(4) = '1' then
            	LED_PALABRA<="0000";
            	next_state <= S0;
             end if;
        when others => 
        	next_state <= current_state;
    		PALABRA <= (OTHERS => '0');
			LED_PALABRA <= (OTHERS => '0');
        end case;
    end if;
    end process;
 
end behavioral;
