library IEEE;
use IEEE.std_logic_1164.all;

ENTITY CajaFuerte IS
    PORT ( 
    rst: IN std_logic;
    boton : IN std_logic_vector(4 DOWNTO 0);
    
    clk: IN std_logic;
    switch : IN std_logic_vector(1 DOWNTO 0);

    leds : OUT std_logic_vector(15 DOWNTO 0);
    led_BGR : OUT std_logic_vector(2 DOWNTO 0)
);
END CajaFuerte;

ARCHITECTURE BEHAVIORAL OF CajaFuerte IS

	--DECLARACION DE COMPONENTES
    COMPONENT SYNCHRNZR is
        port (
            CLK : in std_logic;
            ASYNC_IN : in std_logic;
            SYNC_OUT : out std_logic
        );
    end COMPONENT;

    COMPONENT EDGEDTCTR is
        port (
            CLK : in std_logic;
            SYNC_IN : in std_logic;
            EDGE : out std_logic
        );
    end COMPONENT;
    
    --Componentes de la contraseña
    COMPONENT FormadorPalabra is
    	port(
        
        );
    end COMPONENT;
    
    COMPONENT ComprobadorPalabra is
    	port(
        
        );
    end COMPONENT;
    
    --Componente de la máquina de estados
    COMPONENT MaquinaEstados is
    	port(
        
        );
    end COMPONENT;
    
    --SEÑALES
    
    --Señal sincro a df de los botones
    SIGNAL sinc_df_b : std_logic_vector(4 DOWNTO 0);
    --Señal df a contraseña de los botones
    SIGNAL df_cont_b : std_logic_vector(4 DOWNTO 0);
    
    --Señal sincro a df de los switches
    SIGNAL sinc_df_sw : std_logic_vector(1 DOWNTO 0);
    --Señal df a maquina de estados de los switches
    SIGNAL df_me_sw : std_logic_vector(1 DOWNTO 0);
    
begin

	B_SINC_GEN: for i in 0 to 4 generate

        B_SINC: SYNCHRNZR port map (
        
        CLK  => clk,
    	RST_N => rst,
    	ASYNC_IN => boton(i),
    	SYNC_OUT => sinc_df_b(i)
        );

    end generate;
    
    B_DF_GEN: for i in 0 to 4 generate

        B_DF: EDGEDTCTR port map (
        
        CLK => clk,
    	RST_N => rst,
    	SYNC_IN => sinc_df_b(i),
    	EDGE => df_cont_b(i)
        );

    end generate;
    
    SW_SINC_GEN: for i in 0 to 1 generate

        SW_SINC: SYNCHRNZR port map (
        
        CLK  => clk,
    	RST_N => rst,
    	ASYNC_IN => switch(i),
    	SYNC_OUT => sinc_df_sw(i)
        );

    end generate;
    
	B_DF_GEN: for i in 0 to 1 generate

        B_DF: EDGEDTCTR port map (
        
        CLK => clk,
    	RST_N => rst,
    	SYNC_IN => sinc_df_sw(i),
    	EDGE => df_me_sw
        );

    end generate;
    
    MAQUINA: MaquinaEstados port map(
    
    
    );
    
END BEHAVIORAL;

