----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2022 23:56:59
-- Design Name: 
-- Module Name: formadorpalabra_tb - Behavioral
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
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity formador_palabra_tb is
end formador_palabra_tb;

architecture Behavioral of formador_palabra_tb is
	component formador_palabra
        port(
            RST         : in std_logic; --entrada de la señal de reset
            CLK         : in std_logic; --entrada de reloj
            BOTONES     : in std_logic_vector(4 downto 0); --botones con los que introducir la contraseña
            ENABLE_FP   : in std_logic; --habilita la escritura de la contraseña
            INTRODUCIDA : out std_logic;
            PALABRA     : out std_logic_vector(7 downto 0); --palabra introducida por el usuario, se calcula según los botones pulsados
            LED_PALABRA : out std_logic_vector(3 downto 0) --leds que se encienden para indicar el numero introducido
            );
     end component;
     
     signal rst: std_logic;
     signal clk: std_logic;
     signal botones: std_logic_vector(4 downto 0);
     signal enable_fp: std_logic;
     signal introducida: std_logic;
     signal palabra: std_logic_vector(7 downto 0);
     signal led_palabra: std_logic_vector(3 downto 0);
     constant k: time := 10 ns;
     
begin
	uut: formador_palabra port map(
    	RST=>rst,
    	CLK=>clk,
        BOTONES=>botones,
        ENABLE_FP=>enable_fp,
        INTRODUCIDA=>introducida,
        PALABRA=>palabra,
        LED_PALABRA=>led_palabra
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
        enable_fp<='0';
        botones(0)<='0';
        botones(1)<='0';
        botones(2)<='0';
        botones(3)<='0';
        botones(4)<='0';
     	wait for k;
        
        botones(0)<='1';
        wait for 0.2*k;   
        botones(0)<='0';
        wait for 0.2*k;
        
        botones(1)<='1';
        wait for 0.2*k;        
        botones(1)<='0';
        wait for 0.2*k;
        
        botones(2)<='1';
        wait for 0.2*k;       
        botones(2)<='0';
        wait for 0.2*k;
        
        botones(3)<='1';
        wait for 0.2*k;       
        botones(3)<='0';
        wait for 0.2*k;
        
        botones(4)<='1';
        wait for 0.2*k;       
        botones(4)<='0';
        wait for k;
        
        --se enciende el enable
        enable_fp<='1';
     	wait for k;
        
        botones(0)<='1';
        wait for 0.2*k;   
        botones(0)<='0';
        wait for 0.2*k;
        
        botones(1)<='1';
        wait for 0.2*k;        
        botones(1)<='0';
        wait for 0.2*k;
        
        botones(2)<='1';
        wait for 0.2*k;       
        botones(2)<='0';
        wait for 0.2*k;
        
        botones(3)<='1';
        wait for 0.2*k;       
        botones(3)<='0';
        wait for 0.2*k;
        
        botones(4)<='1';
        wait for 0.2*k;       
        botones(4)<='0';
        wait for k;
        
     end process;
end Behavioral;
