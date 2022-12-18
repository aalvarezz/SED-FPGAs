----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2022 21:12:37
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


library ieee;
use ieee.std_logic_1164.all;

entity fsm_tb is
end fsm_tb;

architecture behavior of fsm_tb is

    component fsm
        port (
            reset   : in std_logic;
            clk     : in std_logic;
            correct : in std_logic;
            switch  : in std_logic_vector(1 downto 0);
            enable  : out std_logic;
            led     : out std_logic
              );
    end component;

    signal reset   : std_logic;
    signal clk     : std_logic;
    signal correct : std_logic;
    signal switch  : std_logic_vector(1 downto 0);
    signal enable  : std_logic;
    signal led     : std_logic;

    constant k: time := 10 ns; -- EDIT Put right period here

begin

    uut : fsm port map (
              reset   => reset,
              clk     => clk,
              correct => correct,
              switch  => switch,
              enable  => enable,
              led     => led
              );

    reset <= '0', '1' after 11 * k;

    -- Clock generation
    clock : process
    begin
        clk <= '0';
        wait for k / 2;
        clk <= '1';
        wait for k / 2;
    end process;

    correct_stimuli : process --FALTA AÑADIR ESTO PARA TODAS LAS ENTRADAS (cuadrando tiempos)
    begin
        correct <= '0';
        wait for 0.75 * k;
        correct <= '1';
        wait for 0.75 * k;
    end process;
    
    switch0_stimuli : process --FALTA AÑADIR ESTO PARA TODAS LAS ENTRADAS (cuadrando tiempos)
    begin
        switch(0) <= '0';
        wait for k;
        switch(0) <= '1';
        wait for k;
    end process;
    
    switch1_stimuli : process --FALTA AÑADIR ESTO PARA TODAS LAS ENTRADAS (cuadrando tiempos)
    begin
        switch(1) <= '0';
        wait for 1.25 * k;
        switch(1) <= '1';
        wait for 1.25 * k;
    end process;

end behavior;