-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity top_tb is
end top_tb;

architecture behavior of top_tb is
	component top2
    port(
		boton1: in std_logic;
    	boton2: in std_logic;
    	boton3: in std_logic;
    	boton4: in std_logic;
    	okey: in std_logic;
    	clk: in std_logic;
    	contrasena: out std_logic_vector(7 downto 0);
        LED: out std_logic_vector(3 downto 0)
        );

     end component;
     
     signal okey: std_logic;
     signal boton1: std_logic;
     signal boton2: std_logic;
     signal boton3: std_logic;
     signal boton4: std_logic;
     signal clk: std_logic;
     signal contrasena: std_logic_vector(7 downto 0);
     signal LED: std_logic_vector(3 downto 0);
     constant k: time := 10 ns;
     
begin
	uut: top2 port map(
    	okey=>okey,
        boton1=>boton1,
        boton2=>boton2,
        boton3=>boton3,
        boton4=>boton4,
        clk=>clk,
        contrasena=>contrasena,
        LED=>LED
        );
        
     okey<='0', '1' after k, '0' after 2*k, '1' after 5*k;
     
     clock: process
     begin 
     	clk<='0';
        wait for k/10;
        clk<='1';
        wait for k/10;
     end process;
     
     stimuli: process
     begin
     	boton1<='0';
        boton2<='0';
        boton3<='0';
        boton4<='0';
     	wait for 0.25*k;
     	boton2<='1';
     	wait for k;
     	boton1<='1';
     	wait for k;
     	boton3<='1';
     	wait for k;
     	boton4<='1';
        wait for 4*k;
     end process;
end behavior;
     