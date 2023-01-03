----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2022 20:57:17
-- Design Name: 
-- Module Name: comprobadorpalabra - Behavioral
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

entity comprobador_palabra is
    port (                
        RST         : in std_logic;
        CLK         : in std_logic;
        ENABLE      : in std_logic;
        INTRODUCIDA : in std_logic;
        PALABRA     : in std_logic_vector(7 downto 0);
        LEDS        : out std_logic_vector(1 downto 0);
        CORRECT     : out std_logic
    );
end comprobador_palabra;

architecture Behavioral of comprobador_palabra is
    signal reg_correct : std_logic_vector(2 downto 0);
    signal password : std_logic_vector(7 downto 0);
begin
    comparador : process(CLK, RST)
        --variable password : std_logic_vector(7 downto 0);
    begin
        if RST = '0' then --REVISAR
            password <= "00000000";
            CORRECT <= '0';
            LEDS(0) <= '0';
            LEDS(1) <= '0'; 
        elsif rising_edge(CLK) then
            LEDS(0) <= '0';
            LEDS(1) <= '0';
            reg_correct <= reg_correct(1 downto 0) & INTRODUCIDA;
            if reg_correct = "010" then
                if ENABLE = '1' then --Registro
                    CORRECT <= '1';
                    password <= PALABRA; --Se almacena la palabra introducida como contraseña
                    LEDS(0) <= '1';
                    LEDS(1) <= '0';
                elsif ENABLE = '0' then  --Log in
                    if password = PALABRA then
                        CORRECT <= '1';
                        LEDS(0) <= '1';
                        LEDS(1) <= '0';
                    elsif password /= PALABRA then
                        CORRECT <= '0';
                        LEDS(0) <= '0';
                        LEDS(1) <= '1';
                    end if;
                end if;
            else
                CORRECT <= '0';
            end if;
        end if;
    end process;
end Behavioral;
