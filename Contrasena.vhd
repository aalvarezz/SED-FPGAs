-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity FormadorPalabra is
port(
	boton1: in std_logic;--botones con los que introducir la contraseña
    boton2: in std_logic;
    boton3: in std_logic;
    boton4: in std_logic;
    okey: in std_logic;--boton para confirmar contraseña
    clk: in std_logic;--señal de reloj
    enable_fp: in std_logic;--habilita la escritura de la contraseña
    contrasena: out std_logic_vector(7 downto 0);
    led_contrasena: out std_logic_vector(3 downto 0)--leds que se encienden para indicar el numero introducido
    );
end FormadorPalabra;

architecture behavioral of FormadorPalabra is 
	type STATES is (S0, S1, S2, S3, S4, S5); 
    signal current_state: STATES := S0; 
    signal next_state: STATES; 
    
begin
	state_register: process (clk) 
	begin
      	current_state <= next_state;--lleva a cabo los cambios de estado
    end process;
    
    nextstate_decod: process (boton1, boton2, boton3, boton4, okey, enable_fp, current_state) 
    variable comodin: std_logic_vector(1 downto 0);
    begin 
    	next_state <= current_state; 
    if enable_fp then--si esta habilitado se puede escribir la contraseña
        next_state <= current_state; --lleva a cabo los cambios de estado
        case current_state is
        when S0 => --ningun numero introducido
        	contrasena <= (OTHERS => '0');--contraseña a cero
            led_contrasena <= (OTHERS => '0');--leds apagados
        	if rising_edge(boton1) then 
            	comodin(0) := '0';--sirve para actualizar correctamente la contraseña en funcion del boton elegido
                comodin(1) := '0';
                led_contrasena<="0001";--leds correspondientes al boton
            	next_state <= S1; --estado sucesor
             elsif rising_edge(boton2) then 
            	comodin(0) := '1';
                comodin(1) := '0';
                led_contrasena<="0011";
            	next_state <= S1;
             elsif rising_edge(boton3) then 
            	comodin(0) := '0';
                comodin(1) := '1';
                led_contrasena<="0111";
            	next_state <= S1;
             elsif rising_edge(boton4) then 
            	comodin(0) := '1';
                comodin(1) := '1';
                led_contrasena<="1111";
            	next_state <= S1;
            end if;
  		when S1 => --1 digito introducido
        	contrasena(0) <= comodin(0);
            contrasena(1) <= comodin(1);
        	if rising_edge(boton1) then 
            	comodin(0) := '0';
                comodin(1) := '0';
                led_contrasena<="0001";
            	next_state <= S2; 
             elsif rising_edge(boton2) then 
            	comodin(0) := '1';
                comodin(1) := '0';
                led_contrasena<="0011";
            	next_state <= S2;
             elsif rising_edge(boton3) then 
            	comodin(0) := '0';
                comodin(1) := '1';
                led_contrasena<="0111";
            	next_state <= S2;
             elsif rising_edge(boton4) then 
            	comodin(0) := '1';
                comodin(1) := '1';
                led_contrasena<="1111";
            	next_state <= S2;
            end if;
        when S2 => --2 digitos introducidos
        	contrasena(2) <= comodin(0);
            contrasena(3) <= comodin(1);
        	if rising_edge(boton1) then 
            	comodin(0) := '0';
                comodin(1) := '0';
                led_contrasena<="0001";
            	next_state <= S3; 
             elsif rising_edge(boton2) then 
            	comodin(0) := '1';
                comodin(1) := '0';
                led_contrasena<="0011";
            	next_state <= S3;
             elsif rising_edge(boton3) then 
            	comodin(0) := '0';
                comodin(1) := '1';
                led_contrasena<="0111";
            	next_state <= S3;
             elsif rising_edge(boton4) then 
            	comodin(0) := '1';
                comodin(1) := '1';
                led_contrasena<="1111";
            	next_state <= S3;
            end if;
        when S3 => --3 digitos introducidos
        	contrasena(4) <= comodin(0);
            contrasena(5) <= comodin(1);
        	if rising_edge(boton1) then 
            	comodin(0) := '0';
                comodin(1) := '0';
                led_contrasena<="0001";
            	next_state <= S4; 
             elsif rising_edge(boton2) then 
            	comodin(0) := '1';
                comodin(1) := '0';
                led_contrasena<="0011";
            	next_state <= S4;
             elsif rising_edge(boton3) then 
            	comodin(0) := '0';
                comodin(1) := '1';
                led_contrasena<="0111";
            	next_state <= S4;
             elsif rising_edge(boton4) then 
            	comodin(0) := '1';
                comodin(1) := '1';
                led_contrasena<="1111";
            	next_state <= S4;
            end if;
        when S4 => --4 digitos introducidos
 			contrasena(6) <= comodin(0);
            contrasena(7) <= comodin(1);
            if rising_edge(okey) then
            	led_contrasena<="0000";
            	next_state <= S5;
             end if;
        when S5 => --no se si sobra
        	--fin de escritura de contrasena
            contrasena <= contrasena;
        when others => 
        	next_state <= current_state;
    		contrasena <= (OTHERS => '0');
			led_contrasena <= (OTHERS => '0');
        end case;
    end if;
    end process;
 
end behavioral;