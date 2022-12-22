library IEEE;
use IEEE.std_logic_1164.all;

ENTITY CajaFuerte IS
    PORT ( 
    rst: IN std_logic;
    boton : IN std_logic_vector(4 DOWNTO 0);
    
    clk: IN std_logic;
    switch : IN std_logic_vector(1 DOWNTO 0);

    leds : OUT std_logic_vector(15 DOWNTO 0);
    leds_BGR : OUT std_logic_vector(2 DOWNTO 0)
);
END CajaFuerte;

ARCHITECTURE BEHAVIORAL OF CajaFuerte IS

	--DECLARACION DE COMPONENTES
    
    --Sincronizador
    COMPONENT SYNCHRNZR is
        port (
            CLK : in std_logic;
            ASYNC_IN : in std_logic;
            SYNC_OUT : out std_logic
        );
    end COMPONENT;

	--Detector de flanco de subida
    COMPONENT EDGEDTCTR is
        port (
            CLK : in std_logic;
            SYNC_IN : in std_logic;
            EDGE : out std_logic
        );
    end COMPONENT;
    
    --Detector de flanco de bajada REVISAR
    COMPONENT down_edgedtctr is
        port (
            CLK : in std_logic;
            SYNC_IN : in std_logic;
            EDGE : out std_logic
        );
    end COMPONENT;
    
    --Componentes de la contraseña
    
    --Formador de palabra REVISAR
    COMPONENT FormadorPalabra is
    	port(
        	boton1: in std_logic;
    		boton2: in std_logic;
    		boton3: in std_logic;
    		boton4: in std_logic;
    		okey: in std_logic;
    		clk: in std_logic;
        
        	contrasena: out std_logic_vector(7 downto 0);
            	led_contrasena: out std_logic_vector(3 downto 0)
        );
    end COMPONENT;
    
    --Comprobador de palabra REVISAR
    COMPONENT ComprobadorPalabra is
    	port(
        	borrar: in std_logic;
    		clk: in std_logic;
        	contrasena: in std_logic_vector(7 downto 0);
            
            	comp: out std_logic
        );
    end COMPONENT;
    
    --Componente de la máquina de estados REVISAR
    COMPONENT MaquinaEstados is
    	port(
       		COMP: in std_logic;
    		CLK: in std_logic; 
        	RST: in std_logic;
        	SW1_UP: in std_logic; 
        	SW1_DOWN: in std_logic;
        	SW2_UP: in std_logic;
            
        	leds: out std_logic_vector(15 downto 0);
            leds_BGR : out std_logic_vector(2 DOWNTO 0)
        );
    end COMPONENT;
    
    --Luces REVISAR INCLUSO SI ES O NO NECESARIO
    COMPONENT LUCES is
    	port (
		CLK : in std_logic;
		LEDS_FP : in std_logic_vector(3 downto 0);
		LEDS_FSM : in std_logic;
		LEDS_CP_BRG_CORRECTO : in std_logic;
		LEDS_CP_BRG_INCORRECTO : in std_logic;

        	LEDS_OUT : out std_logic_vector(15 downto 0);
		LEDS_OUT_BGR : out std_logic_vector(2 downto 0)
	
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
    SIGNAL df_me_sw : std_logic_vector(2 DOWNTO 0);
    
    --Señal login/CP a maquina de estados
    SIGNAL cont_me : std_logic;
    
    --Señal login a luces
    SIGNAL cont_luces : std_logic_vector(3 DOWNTO 0);
    
    --Señal máquina de estados a luces
    SIGNAL me_luces : std_logic_vector(15 DOWNTO 0);
    SIGNAL me_luces_BGR : std_logic_vector(2 DOWNTO 0);
    
begin
	--Genera sincronizadores para los botones
	B_SINC_GEN: for i in 0 to 4 generate

        B_SINC: SYNCHRNZR port map (
        
        CLK  => clk,
    	RST_N => rst,
    	ASYNC_IN => boton(i),
    	SYNC_OUT => sinc_df_b(i)
        );

    end generate;
    
    --Genera detectores de flanco para los botones
    B_DF_GEN: for i in 0 to 4 generate

        B_DF: EDGEDTCTR port map (
        
        CLK => clk,
    	RST_N => rst,
    	SYNC_IN => sinc_df_b(i),
    	EDGE => df_cont_b(i)
        );

    end generate;
    
    --Genera sincronizadores para los switches
    SW_SINC_GEN: for i in 0 to 1 generate

        SW_SINC: SYNCHRNZR port map (
        
        CLK  => clk,
    	RST_N => rst,
    	ASYNC_IN => switch(i),
    	SYNC_OUT => sinc_df_sw(i)
        );

    end generate;
    
    --Genera detectores de flanco para los switches
	SW_DF_GEN: for i in 0 to 1 generate

        SW_DF: EDGEDTCTR port map (
        
        CLK => clk,
    	RST_N => rst,
    	SYNC_IN => sinc_df_sw(i),
    	EDGE => df_me_sw(i)
        );

    end generate;
    
    
    
    MAQUINA: MaquinaEstados port map(
    
    	COMP => cont_me,
    	CLK => clk,
        RST => rst,
        SW1_UP => df_me_sw(0),
        SW1_DOWN => df_me_sw(1),
        SW2_UP => df_me_sw(2),
        leds => me_luces,
        leds_BGR => me_luces_BGR
    );
    
END BEHAVIORAL;