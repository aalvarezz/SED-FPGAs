----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2022 19:36:54
-- Design Name: 
-- Module Name: fsm_tb - Behavioral
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

entity fsm_tb is
end fsm_tb;

architecture Behavioral of fsm_tb is
	component fsm
        port(
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

     end component;
     
     	signal RST       : std_logic;
        signal CLK       : std_logic;
        signal CORRECT   : std_logic;
        signal SWITCH1   : std_logic;
        signal SWITCH2   : std_logic;
        signal SWITCH1_N : std_logic;
        signal ENABLE_FP : std_logic;
        signal ENABLE_CP : std_logic;
        signal LED       : std_logic;
     	constant k: time := 10 ns;
     
begin
	uut: fsm port map(
    	RST=>RST,
        CLK=>CLK,
        CORRECT=>CORRECT,
        SWITCH1=>SWITCH1,
        SWITCH2=>SWITCH2,
        SWITCH1_N=>SWITCH1_N,
        ENABLE_FP=>ENABLE_FP,
        ENABLE_CP=>ENABLE_CP,
        LED=>LED
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
        CORRECT<='0';
        SWITCH1<='0';
        SWITCH2<='0';
        SWITCH1_N<='0';
      	wait for k;
      	
      	--S0 -> S1
     	CORRECT<='1';
        wait for 0.2*k;
        CORRECT<='0';
        wait for k;
        
        --S1 -> S2
        CORRECT<='1';
        wait for 0.2*k;
        CORRECT<='0';
        wait for k;
        
        --S2 -> S3
        SWITCH1<='1';
        wait for 0.2*k;
        SWITCH1<='0';
        wait for k;
        
        --S3 -> S2
        SWITCH1_N<='1';
        wait for 0.2*k;
        SWITCH1_N<='0';
        wait for k;
        
        --S2 -> S0
        SWITCH2<='1';
        wait for 0.2*k;
        SWITCH2<='0';
        wait for k;
     	
     end process;
end Behavioral;
