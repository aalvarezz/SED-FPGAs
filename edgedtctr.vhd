library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity EDGEDTCTR is
port (
	CLK : in std_logic;
	RST_N: in std_logic;
	SYNC_IN : in std_logic;
	SELEC : in std_logic;--0 para subida y 1 para bajada. En botones un 1 es subida, es al revés
	EDGE : out std_logic
);
end EDGEDTCTR;

architecture BEHAVIORAL of EDGEDTCTR is
signal sreg : std_logic_vector(2 downto 0);
begin
process (CLK, RST_N)
begin
	if SELEC '1' then
		if RST_N ='0' then
			sreg <= "000";
		elsif rising_edge(CLK) then
			sreg <= sreg(1 downto 0) & SYNC_IN;
		end if;
		end process;
		with sreg select
			EDGE <= '1' when "011",
			'0' when others;
     else then
     	if RST_N ='0' then
			sreg <= "000";
		elsif rising_edge(CLK) then
			sreg <= sreg(1 downto 0) & SYNC_IN;
		end if;
		end process;
		with sreg select
			EDGE <= '1' when "100",
			'0' when others;
     end if
end BEHAVIORAL;