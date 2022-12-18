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

entity comprobadorpalabra is
    port(
    reset   : in std_logic;
    clk     : in std_logic;
    enable  : in std_logic;
    word    : in std_logic_vector(7 downto 0);
    correct : out std_logic
    );
end comprobadorpalabra;

architecture Behavioral of comprobadorpalabra is
begin
    comparador : process(reset, clk, enable, word)
        variable password : std_logic_vector(7 downto 0);
    begin
        if reset = '0' then
            password := "00000000";
            correct <= '0';
        end if;
        
        if enable = '1' then --Registro
            correct <= '1';
            password := word; --Se almacena la palabra introducida como contraseña
        else
            correct <= '0';
        end if;
        
        if enable = '0' and password = word then --Log in
            correct <= '1';
        else
            correct <= '0';
        end if;
    end process;
end Behavioral;
