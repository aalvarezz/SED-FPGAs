library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity FormadorPalabra_tb is
end FormadorPalabra_tb;

architecture behavior of FormadorPalabra_tb is
	component FormadorPalabra
    port(
		boton: in std_logic_vector(3 downto 0);
        reset: in std_logic;
    	okey: in std_logic;
    	clk: in std_logic;
        enable_fp: in std_logic;
    	contrasena: out std_logic_vector(7 downto 0);
        led_contrasena: out std_logic_vector(3 downto 0)
        );

     end component;
     
     signal okey: std_logic;
     signal boton: std_logic_vector(3 downto 0);
     signal reset: std_logic;
     signal clk: std_logic;
     signal enable_fp: std_logic;
     signal contrasena: std_logic_vector(7 downto 0);
     signal led_contrasena: std_logic_vector(3 downto 0);
     constant k: time := 10 ns;
     
begin
	uut: FormadorPalabra port map(
    	okey=>okey,
        boton=>boton,
        reset=>reset,
        clk=>clk,
        contrasena=>contrasena,
        led_contrasena=>led_contrasena,
        enable_fp=>enable_fp
        );
        
     --okey<='0', '1' after k, '0' after 2*k, '1' after 5*k;
     
     clock: process
     begin 
     	clk<='0';
        wait for k/10;
        clk<='1';
        wait for k/10;
     end process;
     
     stimuli: process
     begin
     	--enable apagado
     	boton(0)<='0';
        boton(1)<='0';
        boton(2)<='0';
        boton(3)<='0';
        okey<='1';
        wait for 0.2*k;
        boton(0)<='1';
        wait for 0.2*k;
        boton(0)<='0';
        boton(1)<='1';
        wait for 0.2*k;
        boton(1)<='0';
        boton(2)<='1';
        wait for 0.2*k;
        boton(2)<='0';
        --se enciende el enable
        enable_fp<='1';
     	wait for k;
     	boton(3)<='1';
     	wait for k;
        boton(3)<='0';
     	boton(2)<='1';
     	wait for k;
        boton(2)<='0';
     	boton(1)<='1';
     	wait for k;
        boton(1)<='0';
     	boton(3)<='1';
        wait for 0.25*k;
        okey<='0';
        wait for 0.25*k;
        okey<='1';
        wait for 4*k;
     end process;
end behavior;