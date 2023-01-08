----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.12.2022 14:09:08
-- Design Name: 
-- Module Name: synchrnzr_tb - Behavioral
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

entity synchrnzr_tb is
end synchrnzr_tb;

architecture Behavioral of synchrnzr_tb is
    component synchrnzr
        port(
            RST_N: in std_logic;
            CLK : in std_logic;
            ASYNC_IN : in std_logic;
            SYNC_OUT : out std_logic
        );
    end component;

    signal rst_n    : std_logic;
    signal clk      : std_logic;
    signal async_in : std_logic;
    signal sync_out : std_logic;
    constant k      : time := 10 ns;
    
begin

    uut : synchrnzr port map(
        RST_N    => rst_n,
        CLK      => clk,
        ASYNC_IN => async_in,
        SYNC_OUT => sync_out
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
       

        ASYNC_IN <= '0';
     	wait for k;
        ASYNC_IN <= '1';
     	wait for k;

       
    end process;
end Behavioral;
