----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.12.2022 10:21:19
-- Design Name: 
-- Module Name: top_tb - Behavioral
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

entity top_tb is
end top_tb;

architecture Behavioral of top_tb is
    component top_entity
        port(
            RST      : in std_logic;
            CLK      : in std_logic;
            BOTONES  : in std_logic_vector(4 DOWNTO 0);
            SWITCH   : in std_logic_vector(1 DOWNTO 0);
            LEDS     : out std_logic_vector(15 DOWNTO 0);
            LEDS_BGR : out std_logic_vector(2 DOWNTO 0)
        );
    end component;
    
    signal rst      : std_logic;
    signal clk      : std_logic;
    signal botones  : std_logic_vector(4 DOWNTO 0);
    signal switch   : std_logic_vector(1 DOWNTO 0);
    signal leds     : std_logic_vector(15 DOWNTO 0);
    signal leds_bgr : std_logic_vector(2 DOWNTO 0);
    constant k      : time := 10 ns;
    
begin

    uut : top_entity port map(
        RST      => rst,
        CLK      => clk,
        BOTONES  => botones,
        SWITCH   => switch,
        LEDS     => leds,
        LEDS_BGR => leds_bgr
        );

    switchP: process
    begin
        SWITCH(0)<='0';
        wait for k;
        SWITCH(0)<='1';
        wait for k;
    end process;
    
    clock: process
    begin 
        clk<='0';
        wait for k/10;
        clk<='1';
        wait for k/10;
    end process;

    stimuli: process
    begin
        
        --Estado inicial
        BOTONES(0) <= '0';
        BOTONES(1) <= '0';
     	BOTONES(2) <= '0';
     	BOTONES(3) <= '0';
     	BOTONES(4) <= '0';         	
     	wait for k;
     	
        --REGISTRO
        --Primer dígito	
     	BOTONES(0) <= '1';     	
     	wait for k;
     	BOTONES(0) <= '0';
     	wait for 2*k;
     	
     	--Segundo dígito
     	BOTONES(1) <= '1';     	
     	wait for k;
     	BOTONES(1) <= '0';
     	wait for 2*k;
     	
     	--Tercer dígito
     	BOTONES(2) <= '1';     	
     	wait for k;
     	BOTONES(2) <= '0';
     	wait for 2*k;
     	
     	--Cuarto dígito
     	BOTONES(3) <= '1';     	
     	wait for k;
     	BOTONES(3) <= '0';
     	wait for 2*k;
        
     	--Confirmación
     	BOTONES(4) <= '1';      	
     	wait for k;
     	BOTONES(4) <= '0';
     	wait for 2*k;
     	
     	--LOGIN INCORRECTO
        --Primer dígito	
     	BOTONES(0) <= '1';     	
     	wait for k;
     	BOTONES(0) <= '0';
     	wait for 2*k;
     	
     	--Segundo dígito
     	BOTONES(1) <= '1';     	
     	wait for k;
     	BOTONES(1) <= '0';
     	wait for 2*k;
     	
     	--Tercer dígito
     	BOTONES(0) <= '1';     	
     	wait for k;
     	BOTONES(0) <= '0';
     	wait for 2*k;
     	
     	--Cuarto dígito
     	BOTONES(1) <= '1';     	
     	wait for k;
     	BOTONES(1) <= '0';
     	wait for 2*k;
        
     	--Confirmación
     	BOTONES(4) <= '1';      	
     	wait for k;
     	BOTONES(4) <= '0';
     	wait for 2*k;
     	
        --ELECCIÓN 1
        --SWITCH(0) <= '1';
        --wait for 2*k;
        --SWITCH(0) <= '0';
        --wait for 2*k;
        
        --LOGIN CORRECTO
        --Primer dígito	
     	BOTONES(0) <= '1';     	
     	wait for k;
     	BOTONES(0) <= '0';
     	wait for 2*k;
     	
     	--Segundo dígito
     	BOTONES(1) <= '1';     	
     	wait for k;
     	BOTONES(1) <= '0';
     	wait for 2*k;
     	
     	--Tercer dígito
     	BOTONES(2) <= '1';     	
     	wait for k;
     	BOTONES(2) <= '0';
     	wait for 2*k;
     	
     	--Cuarto dígito
     	BOTONES(3) <= '1';     	
     	wait for k;
     	BOTONES(3) <= '0';
     	wait for 2*k;
        
     	--Confirmación
     	BOTONES(4) <= '1';      	
     	wait for k;
     	BOTONES(4) <= '0';
     	wait for 2*k;
     	
        --ELECCIÓN 1
        --SWITCH(0) <= '1';
        --wait for 2*k;
        
    end process;
end Behavioral;
