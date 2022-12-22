----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.12.2022 10:20:11
-- Design Name: 
-- Module Name: top_entity - Behavioral
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
use IEEE.std_logic_1164.all;

ENTITY top_entity IS
    PORT ( 
        RST      : IN std_logic;
        BOTON    : IN std_logic_vector(4 DOWNTO 0);
        CLK      : IN std_logic;
        SWITCH   : IN std_logic_vector(1 DOWNTO 0);
        LEDS     : OUT std_logic_vector(15 DOWNTO 0);
        LEDS_BGR : OUT std_logic_vector(2 DOWNTO 0)
);
END top_entity;

ARCHITECTURE BEHAVIORAL OF top_entity IS

	--DECLARACION DE COMPONENTES
    
    --Sincronizador
    COMPONENT synchrnzr is
        port (
            RST_N    : in std_logic;
            CLK      : in std_logic;
            ASYNC_IN : in std_logic;
            SYNC_OUT : out std_logic
        );
    end COMPONENT;

	--Detector de flanco de subida
    COMPONENT edgedtctr is
        port (
            RST_N   : in std_logic;
            CLK     : in std_logic;
            SYNC_IN : in std_logic;
            SELEC   : in std_logic;
            EDGE    : out std_logic
        );
    end COMPONENT;
    
    
    --Componentes de la contraseña
    
    --Formador de palabra REVISAR
    COMPONENT formador_palabra is
    	port (
    		CLK         : in std_logic;
        	BOTONES      : in std_logic_vector(4 downto 0);
    		ENABLE_FP   : in std_logic;
        	PALABRA     : out std_logic_vector(7 downto 0);
            LED_PALABRA : out std_logic_vector(3 downto 0)
        );
    end COMPONENT;
    
    --Comprobador de palabra REVISAR
    COMPONENT comprobador_palabra is
    	port (
            RST       : in std_logic;
            CLK       : in std_logic;
            ENABLE    : in std_logic;
            PALABRA   : in std_logic_vector(7 downto 0);
            LEDS      : out std_logic_vector(1 downto 0);
            CORRECT   : out std_logic
        );
    end COMPONENT;
    
    --Componente de la máquina de estados REVISAR
    COMPONENT fsm is
    	port (
            RST       : in std_logic;
            CLK       : in std_logic;
            CORRECT   : in std_logic;
            SWITCH1   : in std_logic;
            SWITCH2   : in std_logic;
            SWITCH_N  : in std_logic;
            ENABLE_FP : out std_logic;
            ENABLE_CP : out std_logic;
            LED       : out std_logic
        );
    end COMPONENT;
    
    --Luces REVISAR INCLUSO SI ES O NO NECESARIO
    COMPONENT luces is
    	port (
            CLK                    : in std_logic;
            LED_FP                 : in std_logic_vector(3 downto 0);
            LEDS_FSM               : in std_logic;
            LEDS_CP                : in std_logic_vector(1 downto 0);
            LEDS_OUT               : out std_logic_vector(15 downto 0);
            LEDS_OUT_BGR           : out std_logic_vector(2 downto 0)
    	);
    end COMPONENT;
    
    --SEÑALES
    
    --Señales salida leds
    SIGNAL luces_leds : std_logic_vector(15 DOWNTO 0); --Posiblemente no hace falta, se conecta sin señal a las variables de salida
    SIGNAL luces_BGR  : std_logic_vector(2 DOWNTO 0); --Posiblemente no hace falta

    --Señales llegada a LUCES
    SIGNAL fsm_luces : std_logic;
    SIGNAL fp_luces  : std_logic_vector(3 DOWNTO 0);
    SIGNAL cp_luces  : std_logic_vector(1 DOWNTO 0);

    --Señales llegada a FSM
    SIGNAL cp_fsm  : std_logic;
    SIGNAL df1_fsm : std_logic;
    SIGNAL df2_fsm : std_logic;
    SIGNAL dfb_fsm : std_logic;

    --Señales llegada a CP
    SIGNAL fsm_cp : std_logic;
    SIGNAL fp_cp  : std_logic_vector(7 DOWNTO 0);
    
    --Señales llegada a FP
    SIGNAL df_fp  : std_logic_vector(4 DOWNTO 0);
    SIGNAL fsm_fp : std_logic;
    
    --Señales llegada a DF de botones
    SIGNAL sinc_df_b : std_logic_vector(4 DOWNTO 0);
    
    --Señales llegada a SINC de botones
    SIGNAL botones_sinc : std_logic_vector(4 DOWNTO 0); --Posiblemente no hace falta
    
    --Señales llegada a DF de switches
    SIGNAL sinc_df_sw : std_logic_vector(1 DOWNTO 0);
    
    --Señales llegada a DF_N de switches
    SIGNAL sinc_dfn_sw : std_logic;
    
    --Señales llegada a SINC de switches
    SIGNAL switches_sinc : std_logic_vector(1 DOWNTO 0); --Posiblemente no hace falta
    
begin

	--Genera sincronizadores para los botones
	B_SINC_GEN: for i in 0 to 4 generate

        B_SINC: synchrnzr port map (
            CLK  => clk,
    	   RST_N => rst,
    	   ASYNC_IN => boton(i),
    	   SYNC_OUT => sinc_df_b(i)
        );

    end generate;
    
    --Genera detectores de flanco para los botones
    B_DF_GEN: for i in 0 to 4 generate

        B_DF: edgedtctr port map (
            CLK     => clk,
    	   RST_N   => rst,
    	   SYNC_IN => sinc_df_b(i),
    	   SELEC   => '0',
    	   EDGE    => df_fp(i)
        );

    end generate;
    
    --Genera sincronizadores para los switches
    SW_SYNC_GEN: for i in 0 to 1 generate

        SW_SYNC : synchrnzr port map (
            CLK  => clk,
            RST_N => rst,
            ASYNC_IN => switch(i),
            SYNC_OUT => sinc_df_sw(i)
        );

    end generate;
    
    
    DF_SW_1 : edgedtctr port map (
        CLK => clk,
    	RST_N => rst,
    	SYNC_IN => sinc_df_sw(0),
    	SELEC => '0',
    	EDGE => df1_fsm
    );


    DF_SW_2 : edgedtctr port map (
        CLK => clk,
    	RST_N => rst,
    	SYNC_IN => sinc_df_sw(1),
    	SELEC => '0',
    	EDGE => df2_fsm
    );


    DFB_SW_1 : edgedtctr port map (
        CLK => clk,
    	RST_N => rst,
    	SYNC_IN => sinc_df_sw(0),
    	SELEC => '1',
    	EDGE => df1_fsm
    );

    
    --FORMADOR_PALABRA
    FORMADOR_DE_PALABRA : formador_palabra port map (
    	CLK         => clk,
        BOTONES     => df_fp,
    	ENABLE_FP   => fsm_fp,
        PALABRA     => fp_cp,
        LED_PALABRA => fp_luces
    );
    
    
    --COMPROBADOR_PALABRA
    COMPROBADOR_DE_PALABRA : comprobador_palabra port map (
        RST       => rst,
        CLK       => clk,
        ENABLE    => fsm_cp,
        PALABRA   => fp_cp,
        LEDS      => cp_luces,
        CORRECT   => cp_fsm
    );
    
    
    --FSM
    MAQUINA_ESTADOS : fsm port map (
        RST       => rst,
        CLK       => clk,
        CORRECT   => cp_fsm,
        SWITCH1   => df1_fsm,
        SWITCH2   => df2_fsm,
        SWITCH_N  => dfb_fsm,
        ENABLE_FP => fsm_fp,
        ENABLE_CP => fsm_cp,
        LED       => fsm_luces
    );
    
    
    -- LUCES
    COMPONENTE_LUCES : luces port map (
        CLK                    => clk,
        LED_FP                 => fp_luces,
        LEDS_FSM               => fsm_luces,
        LEDS_CP                => cp_luces,
        LEDS_OUT               => luces_leds,
        LEDS_OUT_BGR           => luces_BGR
    );
    
END BEHAVIORAL;
