library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity synchrnzr is
    port (
        RST_N: in std_logic;
        CLK : in std_logic;
        ASYNC_IN : in std_logic;
        SYNC_OUT : out std_logic
    );
end synchrnzr;

architecture behavioral of synchrnzr is
    signal sreg : std_logic_vector(1 downto 0);
begin
    process (CLK,RST_N)
    begin
        if RST_N = '0' then
            sreg <= "00";
        elsif rising_edge(CLK) then
            sync_out <= sreg(1);
            sreg <= sreg(0) & async_in;
        end if;
    end process;
end behavioral;