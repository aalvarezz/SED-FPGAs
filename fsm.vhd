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
        reset   : in std_logic;
        clk     : in std_logic;
        correct : in std_logic;
        switch  : in std_logic_vector(1 downto 0);
        enable  : out std_logic;
        led     : out std_logic
    );
end fsm;

architecture behavioral of fsm is
    type STATES is (S0, S1, S2, S3);
    signal current_state : STATES := S0;
    signal next_state    : STATES;
begin
    state_register : process (reset, clk)
    begin
        if reset = '0' then
            current_state <= S0;
        elsif rising_edge(clk) then --Avanzar de estado al pulso de reloj
            current_state <= next_state;
        end if;
    end process;
 
    nextstate_decod : process (current_state, switch, correct)
    begin
        next_state <= current_state;
        case current_state is
            when S0 => --Registro
                if correct = '1' then
                    next_state <= S1;
                end if;
            when S1 => --Log in
                if correct = '1' then
                    next_state <= S2;
                end if;
            when S2 => --Selección de modo (Funcionalidad o Cambio de contraseña)
                if rising_edge(switch(0)) then --Eleccion1 (Funcionalidad)
                    next_state <= S3;
                elsif rising_edge(switch(1)) then --Eleccion2 (Cambio de contraseña)
                    next_state <= S0; --Se ha elegido la opción de cambiar de contraseña, por lo que se devuelve el programa al estado de registro
                end if;
            when S3 => --Funcionalidad
                if switch(0)'event and switch(0) = '0' then --Sustituir por boton/switch usado para esta funcion
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
                enable <= '1'; --Enable para habilitar la función de registro
            when S1 =>
                enable <= '0'; --Se desactiva el Enable para habilitar la función de log in (PROVISIONAL)
            when S3 =>
                led <= '1'; --Funcion provisional
            when others =>
                led <= '0';
                enable <= '0';
        end case;
    end process;
end behavioral;