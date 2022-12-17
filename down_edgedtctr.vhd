library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EDGEDTCTR is
    port (
        CLK : in std_logic;
        SYNC_IN : in std_logic;
        EDGE : out std_logic
    );
end EDGEDTCTR;

architecture BEHAVIORAL of EDGEDTCTR is

    signal sreg : std_logic_vector(2 downto 0);

begin
    process (CLK)

variable detect : std_logic_vector (1 downto 0);

    begin
	if SYNC_IN ='0' then
         detect := "00";
        elsif rising_edge(CLK) then
            	detect(1) := detect(0); 
         	detect(0) := sync ; 
         
         	if detect = "01" then -- rising_edge
         	elsif detect = "10" then --falling_edge
        end if;
    end process;

    with detect select
        EDGE <= '1' when "10",
            '0' when others;
            
end BEHAVIORAL;