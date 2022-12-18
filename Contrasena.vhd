-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity top2 is

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
end top2;

architecture behavioral of top2 is 
	type STATES is (S0, S1, S2, S3, S4, S5); 
    signal current_state: STATES := S0; 
    signal next_state: STATES; 
    
begin
	state_register: process (clk) 
	begin
      	current_state <= next_state;
    end process;
    
    nextstate_decod: process (boton1, boton2, boton3, boton4, okey, current_state) 
    variable comodin: std_logic_vector(1 downto 0);
    begin 
    	next_state <= current_state; 
        case current_state is
        when S0 => 
        	contrasena <= (OTHERS => '0');
            LED <= (OTHERS => '0');
        	if rising_edge(boton1) then 
            	comodin(0) := '0';
                comodin(1) := '0';
                LED(0)<='1';
                LED(1)<='0';
                LED(2)<='0';
                LED(3)<='0';
            	next_state <= S1; 
             elsif rising_edge(boton2) then 
            	comodin(0) := '1';
                comodin(1) := '0';
                LED(0)<='1';
                LED(1)<='1';
                LED(2)<='0';
                LED(3)<='0';
            	next_state <= S1;
             elsif rising_edge(boton3) then 
            	comodin(0) := '0';
                comodin(1) := '1';
                LED(0)<='1';
                LED(1)<='1';
                LED(2)<='1';
                LED(3)<='0';
            	next_state <= S1;
             elsif rising_edge(boton4) then 
            	comodin(0) := '1';
                comodin(1) := '1';
                LED(0)<='1';
                LED(1)<='1';
                LED(2)<='1';
                LED(3)<='1';
            	next_state <= S1;
            end if;
  		when S1 => 
        	contrasena(0) <= comodin(0);
            contrasena(1) <= comodin(1);
        	if rising_edge(boton1) then 
            	comodin(0) := '0';
                comodin(1) := '0';
                LED(0)<='1';
                LED(1)<='0';
                LED(2)<='0';
                LED(3)<='0';
            	next_state <= S2; 
             elsif rising_edge(boton2) then 
            	comodin(0) := '1';
                comodin(1) := '0';
                LED(0)<='1';
                LED(1)<='1';
                LED(2)<='0';
                LED(3)<='0';
            	next_state <= S2;
             elsif rising_edge(boton3) then 
            	comodin(0) := '0';
                comodin(1) := '1';
                LED(0)<='1';
                LED(1)<='1';
                LED(2)<='1';
                LED(3)<='0';
            	next_state <= S2;
             elsif rising_edge(boton4) then 
            	comodin(0) := '1';
                comodin(1) := '1';
                LED(0)<='1';
                LED(1)<='1';
                LED(2)<='1';
                LED(3)<='1';
            	next_state <= S2;
            end if;
        when S2 => 
        	contrasena(2) <= comodin(0);
            contrasena(3) <= comodin(1);
        	if rising_edge(boton1) then 
            	comodin(0) := '0';
                comodin(1) := '0';
                LED(0)<='1';
                LED(1)<='0';
                LED(2)<='0';
                LED(3)<='0';
            	next_state <= S3; 
             elsif rising_edge(boton2) then 
            	comodin(0) := '1';
                comodin(1) := '0';
                LED(0)<='1';
                LED(1)<='1';
                LED(2)<='0';
                LED(3)<='0';
            	next_state <= S3;
             elsif rising_edge(boton3) then 
            	comodin(0) := '0';
                comodin(1) := '1';
                LED(0)<='1';
                LED(1)<='1';
                LED(2)<='1';
                LED(3)<='0';
            	next_state <= S3;
             elsif rising_edge(boton4) then 
            	comodin(0) := '1';
                comodin(1) := '1';
                LED(0)<='1';
                LED(1)<='1';
                LED(2)<='1';
                LED(3)<='1';
            	next_state <= S3;
            end if;
        when S3 => 
        	contrasena(4) <= comodin(0);
            contrasena(5) <= comodin(1);
        	if rising_edge(boton1) then 
            	comodin(0) := '0';
                comodin(1) := '0';
                LED(0)<='1';
                LED(1)<='0';
                LED(2)<='0';
                LED(3)<='0';
            	next_state <= S4; 
             elsif rising_edge(boton2) then 
            	comodin(0) := '1';
                comodin(1) := '0';
                LED(0)<='1';
                LED(1)<='1';
                LED(2)<='0';
                LED(3)<='0';
            	next_state <= S4;
             elsif rising_edge(boton3) then 
            	comodin(0) := '0';
                comodin(1) := '1';
                LED(0)<='1';
                LED(1)<='1';
                LED(2)<='1';
                LED(3)<='0';
            	next_state <= S4;
             elsif rising_edge(boton4) then 
            	comodin(0) := '1';
                comodin(1) := '1';
                LED(0)<='1';
                LED(1)<='1';
                LED(2)<='1';
                LED(3)<='1';
            	next_state <= S4;
            end if;
        when S4 =>
 			contrasena(6) <= comodin(0);
            contrasena(7) <= comodin(1);
            if rising_edge(okey) then
            	LED(0)<='0';
                LED(1)<='0';
                LED(2)<='0';
                LED(3)<='0';
            	next_state <= S5;
             end if;
        when S5 =>
        	--fin de escritura de contrasena
            contrasena <= contrasena;
        when others => 
        	next_state <= current_state;
    		contrasena <= (OTHERS => '0');
			LED <= (OTHERS => '0');
        end case;
    end process;
 
end behavioral;