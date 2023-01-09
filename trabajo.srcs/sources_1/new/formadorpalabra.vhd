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
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity formador_palabra is
    port(
        RST         : in std_logic; --entrada de la señal de reset
        CLK         : in std_logic; --entrada de reloj
        BOTONES     : in std_logic_vector(4 downto 0); --botones con los que introducir la contraseña
        ENABLE_FP   : in std_logic; --habilita la escritura de la contraseña
        INTRODUCIDA : out std_logic; --indica que se ha introducido una contraseña satisfacoriamente
        PALABRA     : out std_logic_vector(7 downto 0); --palabra introducida por el usuario, se calcula según los botones pulsados
        LED_PALABRA : out std_logic_vector(3 downto 0) --leds que se encienden para indicar el numero introducido
        );
end formador_palabra;

architecture behavioral of formador_palabra is 
    type STATES is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21);
    signal current_state: STATES := S0;
    signal next_state: STATES;
begin
    state_register: process (RST, CLK)
    begin
        if RST = '0' then
          current_state <= S0;
        elsif rising_edge(CLK) then
          current_state <= next_state; 
        end if;
    end process;

    nextstate_decod: process (current_state, BOTONES)
    begin
        next_state <= current_state;
        if ENABLE_FP = '1' then
            next_state <= current_state; 
            case current_state is
                when S0 => 
                    if BOTONES(0) = '1' then
                        next_state <= S1;
                    elsif BOTONES(1) = '1' then
                        next_state <= S2;
                    elsif BOTONES(2) = '1' then
                        next_state <= S3;
                    elsif BOTONES(3) = '1' then
                        next_state <= S4;
                    end if;
                when S1 =>
                    next_state <= S5;
                when S2 =>
                    next_state <= S5;
                when S3 =>
                    next_state <= S5;
                when S4 =>
                    next_state <= S5;
                ----------------------primer digito introducido
                when S5 => 
                    if BOTONES(0) = '1' then
                        next_state <= S6;
                    elsif BOTONES(1) = '1' then
                        next_state <= S7;
                    elsif BOTONES(2) = '1' then
                        next_state <= S8;
                    elsif BOTONES(3) = '1' then
                        next_state <= S9;
                    end if;
                when S6 =>
                    next_state <= S10;
                when S7 =>
                    next_state <= S10;
                when S8 =>
                    next_state <= S10;
                when S9 =>
                    next_state <= S10;
                -----------------------segundo dígito dentro
                when S10 => 
                    if BOTONES(0) = '1' then
                        next_state <= S11;
                    elsif BOTONES(1) = '1' then
                        next_state <= S12;
                    elsif BOTONES(2) = '1' then
                        next_state <= S13;
                    elsif BOTONES(3) = '1' then
                        next_state <= S14;
                    end if;
                when S11 =>
                    next_state <= S15;
                when S12 =>
                    next_state <= S15;
                when S13 =>
                    next_state <= S15;
                when S14 =>
                    next_state <= S15;
                -----------------tercer digito dentro
                when S15 => 
                    if BOTONES(0) = '1' then
                        next_state <= S16;
                    elsif BOTONES(1) = '1' then
                        next_state <= S17;
                    elsif BOTONES(2) = '1' then
                        next_state <= S18;
                    elsif BOTONES(3) = '1' then
                        next_state <= S19;
                    end if;
                when S16 =>
                    next_state <= S20;
                when S17 =>
                    next_state <= S20;
                when S18 =>
                    next_state <= S20;
                when S19 =>
                    next_state <= S20;
                -------------------cuarto dígito dentro
                when S20 =>
                    if BOTONES(4) = '1' then
                        next_state <= S21;
                    end if;
                when S21 =>
                    next_state <= S0;
                when others =>
                    next_state <= S0;
            end case;
        end if;
    end process;

    output_decod: process (current_state)
    begin
        case current_state is
            when S0 => 
                LED_PALABRA <= (OTHERS => '0');
                INTRODUCIDA <= '0';
            when S1 =>
                PALABRA(0)  <= '0';
                PALABRA(1)  <= '0';
                LED_PALABRA <= "0001";
            when S2 =>
                PALABRA(0)  <= '1';
                PALABRA(1)  <= '0';
                LED_PALABRA <= "0011";
            when S3 =>
                PALABRA(0)  <= '0';
                PALABRA(1)  <= '1';
                LED_PALABRA <= "0111";
            when S4 =>
                PALABRA(0)  <= '1';
                PALABRA(1)  <= '1';
                LED_PALABRA <= "1111";
            ----------------------primer dígito introducido
            when S6 =>
                PALABRA(2)  <= '0';
                PALABRA(3)  <= '0';
                LED_PALABRA <= "0001";
            when S7 =>
                PALABRA(2)  <= '1';
                PALABRA(3)  <= '0';
                LED_PALABRA <= "0011";
            when S8 =>
                PALABRA(2)  <= '0';
                PALABRA(3)  <= '1';
                LED_PALABRA <= "0111";
            when S9 =>
                PALABRA(2)  <= '1';
                PALABRA(3)  <= '1';
                LED_PALABRA <= "1111";
            -----------------------segundo dígito dentro
            when S11 =>
                PALABRA(4)  <= '0';
                PALABRA(5)  <= '0';
                LED_PALABRA <= "0001";
            when S12 =>
                PALABRA(4)  <= '1';
                PALABRA(5)  <= '0';
                LED_PALABRA <= "0011";
            when S13 =>
                PALABRA(4)  <= '0';
                PALABRA(5)  <= '1';
                LED_PALABRA <= "0111";
            when S14 =>
                PALABRA(4)  <= '1';
                PALABRA(5)  <= '1';
                LED_PALABRA <= "1111";
            -----------------tercer dígito dentro
            when S16 =>
                PALABRA(6)  <= '0';
                PALABRA(7)  <= '0';
                LED_PALABRA <= "0001";
            when S17 =>
                PALABRA(6)  <= '1';
                PALABRA(7)  <= '0';
                LED_PALABRA <= "0011";
            when S18 =>
                PALABRA(6)  <= '0';
                PALABRA(7)  <= '1';
                LED_PALABRA <= "0111";
            when S19 =>
                PALABRA(6)  <= '1';
                PALABRA(7)  <= '1';
                LED_PALABRA <= "1111";
            -------------------cuarto dígito dentro
            when S21 =>
                --Se ha terminado de introducir satisfactoriamente la palabra, a través de esta señal se le comunica a 
                --los demás componentes. Está pensado para que sea un pulso
                INTRODUCIDA <= '1';
                LED_PALABRA <= "0000";
            when others =>
        end case;
             end process;
end behavioral;
