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
		RST_N: in std_logic;
            ASYNC_IN : in std_logic;
            SYNC_OUT : out std_logic
        );
    end COMPONENT;

	--Detector de flanco de subida
    COMPONENT EDGEDTCTR is
        port (
            CLK : in std_logic;
		RST_N: in std_logic;
            SYNC_IN : in std_logic;
            EDGE : out std_logic
        );
    end COMPONENT;
    
    --Detector de flanco de bajada REVISAR
    COMPONENT down_edgedtctr is
        port (
            CLK : in std_logic;
		RST_N: in std_logic;
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
        	reset   : in std_logic;
    		clk     : in std_logic;
   		enable  : in std_logic;
    		word    : in std_logic_vector(7 downto 0);

		led_verde : out std_logic;
		led_rojo : out std_logic;
    		correct : out std_logic
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
--Señales salida leds
--SIGNAL luces_leds : std_logic_vector(15 DOWNTO 0);--Posiblemente no hace falta, se conecta sin señal a las variables de salida
--SIGNAL luces_BGR : std_logic_vector(2 DOWNTO 0);--Posiblemente no hace falta

--Señales llegada a LUCES
SIGNAL fsm_luces : std_logic;
SIGNAL fp_luces : std_logic_vector(3 DOWNTO 0);
SIGNAL cp_luces : std_logic_vector(1 DOWNTO 0);

--Señales llegada a FSM
SIGNAL cp_fsm : std_logic;
SIGNAL df1_fsm : std_logic;
SIGNAL df2_fsm : std_logic;
SIGNAL dfb_fsm : std_logic;

--Señales llegada a CP
SIGNAL fsm_cp : std_logic;
SIGNAL fp_cp : std_logic_vector(7 DOWNTO 0);

--Señales llegada a FP
SIGNAL df_fp : std_logic_vector(4 DOWNTO 0);
SIGNAL fsm_fp : std_logic;

--Señales llegada a DF de botones
SIGNAL sinc_df_b : std_logic_vector(4 DOWNTO 0);

--Señales llegada a SINC de botones
--SIGNAL botones_sinc : std_logic_vector(4 DOWNTO 0);--Posiblemente no hace falta

--Señales llegada a DF de switches
SIGNAL sinc_df_sw : std_logic_vector(1 DOWNTO 0);

--Señales llegada a DF_N de switches
SIGNAL sinc_dfn_sw : std_logic;--Es la misma que la de arriba, usar esa

--Señales llegada a SINC de switches
--SIGNAL switches_sinc : std_logic_vector(1 DOWNTO 0);--Posiblemente no hace falta
    
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
    	EDGE => df_fp(i)
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
    	EDGE => df_fsm_sw(i)
        );

    end generate;
    
df_sw_1: EDGEDTCTR port map (
        
        CLK => clk,
    	RST_N => rst,
    	SYNC_IN => sinc_df_sw(0),
    	EDGE => df1_fsm
);

df_sw_2: EDGEDTCTR port map (
        
        CLK => clk,
    	RST_N => rst,
    	SYNC_IN => sinc_df_sw(1),
    	EDGE => df2_fsm
);

dfb_sw_1: down_edgedtctr port map (
        
        CLK => clk,
    	RST_N => rst,
    	SYNC_IN => sinc_df_sw(0),
    	EDGE => df1_fsm
);
    
    --Hecho, hay que actualizar
    MAQUINA: fsm port map(
    
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