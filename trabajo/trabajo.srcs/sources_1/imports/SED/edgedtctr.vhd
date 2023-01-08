library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity EDGEDTCTR is
    port (
        CLK     : in std_logic;
        RST_N   : in std_logic;
        SYNC_IN : in std_logic;
        SELEC   : in std_logic; -- '1' para subida, '0' para bajada
        EDGE    : out std_logic
    );
end EDGEDTCTR;

architecture BEHAVIORAL of EDGEDTCTR is
    signal sreg : std_logic_vector(2 downto 0);
begin
    process (CLK, RST_N)
    begin
        if rising_edge(CLK) then
            if SELEC = '1' then
            
                if RST_N ='0' then
                    sreg <= "000";
                else
                    sreg <= sreg(1 downto 0) & SYNC_IN;
                end if;
                
                if sreg = "011" then 
                    EDGE <= '1';
                else
                    EDGE <= '0';
                end if;
            elsif SELEC = '0' then
            
                if RST_N ='0' then
                    sreg <= "000";
                else
                    sreg <= sreg(1 downto 0) & SYNC_IN;
                end if;
    
                if sreg = "100" then 
                    EDGE <= '1';
                else
                    EDGE <= '0';
                end if;
            end if;
        end if;
    end process;
end BEHAVIORAL;