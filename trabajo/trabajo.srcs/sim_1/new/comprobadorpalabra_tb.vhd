----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2022 19:37:59
-- Design Name: 
-- Module Name: comprobadorpalabra_tb - Behavioral
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

entity comprobador_palabra_tb is
end comprobador_palabra_tb;

architecture Behavioral of comprobador_palabra_tb is
	component comprobador_palabra
        port(
            RST         : in std_logic;
            CLK         : in std_logic;
            ENABLE      : in std_logic;
            INTRODUCIDA : in std_logic;
            PALABRA     : in std_logic_vector(7 downto 0);
            LEDS        : out std_logic_vector(1 downto 0);
            CORRECT     : out std_logic
            );

     end component;
     
     	signal RST         : std_logic;
        signal CLK         : std_logic;
        signal ENABLE      : std_logic;
        signal INTRODUCIDA : std_logic;
        signal PALABRA     : std_logic_vector(7 downto 0);
        signal LEDS        : std_logic_vector(1 downto 0);
        signal CORRECT     : std_logic;
     	constant k: time := 10 ns;
     
begin
	uut: comprobador_palabra port map(
    	RST=>RST,
        CLK=>CLK,
        ENABLE=>ENABLE,
        INTRODUCIDA=>INTRODUCIDA,
        PALABRA=>PALABRA,
        LEDS=>LEDS,
        CORRECT=>CORRECT
        );
        
     
     clock: process
     begin 
     	CLK<='0';
        wait for k/10;
        CLK<='1';
        wait for k/10;
     end process;
     
     stimuli: process
     begin
     	--RST<='0';
        PALABRA<="01010101";
        ENABLE<='0';
        INTRODUCIDA<='0';
        wait for k;
        
        ENABLE<='1';
        wait for 0.5*k;
        
        INTRODUCIDA<='1';
        wait for 0.5*k;
        
        INTRODUCIDA<='0';
        ENABLE<='0';
        wait for 0.5*k;
        
        INTRODUCIDA<='1';
        wait for k;
        
        PALABRA<="11111110";
        wait for k;
        
        INTRODUCIDA<='1';
     	
     end process;
end Behavioral;