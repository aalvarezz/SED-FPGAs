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
    signal sreg : std_logic_vector(13 downto 0); --Ampliar la longitud del vector supone una mayor protección contra rebotes además de una mejor detección
begin
    process (CLK, RST_N)
    begin
        if rising_edge(CLK) then
            if SELEC = '1' then --Modo de detección de flancos de subida
            
                if RST_N ='0' then
                    sreg <= "00000000000000";
                else
                    sreg <= sreg(12 downto 0) & SYNC_IN;
                end if;
                
                if sreg = "00000111111111" then --Se han incluido varios 0s al principio (no solo 1) para evitar la posibilidad de que se cuele solo un 0 mientras el flanco está siendo detectado
                    EDGE <= '1';
                else
                    EDGE <= '0';
                end if;
            elsif SELEC = '0' then --Modo de detección de flancos de bajada
            
                if RST_N ='0' then
                    sreg <= "00000000000000";
                else
                    sreg <= sreg(12 downto 0) & SYNC_IN;
                end if;
    
                if sreg = "11111000000000" then 
                    EDGE <= '1';
                else
                    EDGE <= '0';
                end if;
            end if;
        end if;
    end process;
end BEHAVIORAL;