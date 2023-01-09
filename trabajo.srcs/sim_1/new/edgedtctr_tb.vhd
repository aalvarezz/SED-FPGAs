----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2022 19:35:57
-- Design Name: 
-- Module Name: edgedtctr_tb - Behavioral
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

entity edgedtctr_tb is
end edgedtctr_tb;

architecture Behavioral of edgedtctr_tb is
	component EDGEDTCTR
        port(
            CLK     : in std_logic;
            RST_N   : in std_logic;
            SYNC_IN : in std_logic;
            SELEC   : in std_logic;
            EDGE    : out std_logic
            );

    end component;
     
    signal CLK     : std_logic;
    signal RST_N   : std_logic;
    signal SYNC_IN : std_logic;
    signal SELEC   : std_logic;
    signal EDGE    : std_logic;
    constant k: time := 10 ns;
     
begin
	uut: EDGEDTCTR port map(
    	CLK     => CLK,
        RST_N   => RST_N,
        SYNC_IN => SYNC_IN,
        SELEC   => SELEC,
        EDGE    => EDGE
        );
             
     clock: process
     begin 
     	CLK <= '0';
        wait for k/10;
        CLK <= '1';
        wait for k/10;
     end process;
     
     stimuli: process
     begin
        SYNC_IN <= '0';
        SELEC   <= '0';
        wait for k;
        
        SYNC_IN <= '1';
        wait for 5*k;
        
        SYNC_IN <= '0';
        SELEC   <= '1';
        wait for k;
        
        SYNC_IN <= '1';
        wait for 5*k;
        
     end process;
end Behavioral;