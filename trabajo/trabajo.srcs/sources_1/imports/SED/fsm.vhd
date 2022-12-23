----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2022 14:20:37
-- Design Name: 
-- Module Name: fsm - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm is
    port (
        RST       : in std_logic;
        CLK       : in std_logic;
        CORRECT   : in std_logic;
        SWITCH1   : in std_logic;
        SWITCH2   : in std_logic;
        SWITCH1_N : in std_logic;
        ENABLE_FP : out std_logic;
        ENABLE_CP : out std_logic;
        LED       : out std_logic
    );
end fsm;

architecture behavioral of fsm is
    type STATES is (S0, S1, S2, S3);
    signal current_state : STATES := S0;
    signal next_state    : STATES;
begin
    state_register : process (RST, CLK)
    begin
        if RST = '0' then
            current_state <= S0;
        elsif rising_edge(CLK) then --Avanzar de estado al pulso de reloj
            current_state <= next_state;
        end if;
    end process;
 
    nextstate_decod : process (current_state, SWITCH1, SWITCH2, SWITCH1_N, CORRECT)
    begin
        next_state <= current_state;
        case current_state is
            when S0 => --Registro
                if CORRECT = '1' then
                    next_state <= S1;
                end if;
            when S1 => --Log in
                if CORRECT = '1' then
                    next_state <= S2;
                end if;
            when S2 => --Selección de modo (Funcionalidad o Cambio de contraseña)
                if SWITCH1 = '1' then --Eleccion1 (Funcionalidad)
                    next_state <= S3;
                elsif SWITCH2 = '1' then --Eleccion2 (Cambio de contraseña)
                    next_state <= S0; --Se ha elegido la opción de cambiar de contraseña, por lo que se devuelve el programa al estado de registro
                end if;
            when S3 => --Funcionalidad
                if SWITCH1_N = '1' then
                    next_state <= S2; --Tras ejecutar la funcionalidad, se puede volver al estado de selección
                end if;
            when others =>
                next_state <= S0;
        end case;
    end process;
 
    output_decod: process (current_state)
    begin
        case current_state is
            when S0 =>
                ENABLE_CP <= '1'; --Enable para habilitar la función de registro
                ENABLE_FP <= '1'; --Enable para habilitar la función de escritura
                LED       <= '0';
            when S1 =>
                ENABLE_CP <= '0'; --Se desactiva el Enable para habilitar la función de log in (PROVISIONAL)
                ENABLE_FP <= '1'; --Enable para habilitar la función de escritura
                LED       <= '0';
            when S2 =>
                ENABLE_CP <= '0';
                ENABLE_FP <= '0'; --Enable para deshabilitar la función de escritura
                LED       <= '0';
            when S3 =>
                ENABLE_CP <= '0';
                ENABLE_FP <= '0'; --Enable para deshabilitar la función de escritura
                LED       <= '1'; --Funcion provisional
            when others =>
                ENABLE_CP <= '0';
                ENABLE_FP <= '0';
                LED       <= '0';
        end case;
    end process;
end behavioral;