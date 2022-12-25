library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity FormadorPalabra is
port (
    boton: in std_logic_vector(3 downto 0);
    reset: in std_logic;
    okey: in std_logic; --falta implementarlo
    clk: in std_logic;
    enable_fp: in std_logic;
    contrasena: out std_logic_vector(7 downto 0);
    led_contrasena: out std_logic_vector(3 downto 0)
    );
end FormadorPalabra;

architecture behavioral of FormadorPalabra is
    type STATES is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21);
    signal current_state: STATES := S0;
    signal next_state: STATES;
begin
    state_register: process (reset, CLK)
    begin
    if reset = '0' then
      current_state <= S0;
    elsif rising_edge(CLK) then
      current_state <= next_state; 
    end if;
 end process;
 
 nextstate_decod: process (boton, current_state, enable_fp, okey)
 begin
   next_state <= current_state;
    if enable_fp then
        next_state <= current_state; 
        case current_state is
         when S0 => 
         if rising_edge(boton(0)) then
         next_state <= S1;
         elsif rising_edge(boton(1)) then
         next_state <= S2;
         elsif rising_edge(boton(2)) then
         next_state <= S3;
         elsif rising_edge(boton(3)) then
         next_state <= S4;
         end if;
         when S1 =>
         next_state <= S5;
         when S2 =>
         next_state <= S5;
         when S3 =>
         next_state <= S5;
         when S4 =>
         next_state <= S5;
         ----------------------primer digito introducido
         when S5 => 
         if rising_edge(boton(0)) then
         next_state <= S6;
         elsif rising_edge(boton(1)) then
         next_state <= S7;
         elsif rising_edge(boton(2)) then
         next_state <= S8;
         elsif rising_edge(boton(3)) then
         next_state <= S9;
         end if;
         when S6 =>
         next_state <= S10;
         when S7 =>
         next_state <= S10;
         when S8 =>
         next_state <= S10;
         when S9 =>
         next_state <= S10;
         -----------------------segundo dígito dentro
         when S10 => 
         if rising_edge(boton(0)) then
         next_state <= S11;
         elsif rising_edge(boton(1)) then
         next_state <= S12;
         elsif rising_edge(boton(2)) then
         next_state <= S13;
         elsif rising_edge(boton(3)) then
         next_state <= S14;
         end if;
         when S11 =>
         next_state <= S15;
         when S12 =>
         next_state <= S15;
         when S13 =>
         next_state <= S15;
         when S14 =>
         next_state <= S15;
         -----------------tercer digito dentro
         when S15 => 
         if rising_edge(boton(0)) then
         next_state <= S16;
         elsif rising_edge(boton(1)) then
         next_state <= S17;
         elsif rising_edge(boton(2)) then
         next_state <= S18;
         elsif rising_edge(boton(3)) then
         next_state <= S19;
         end if;
         when S16 =>
         next_state <= S20;
         when S17 =>
         next_state <= S20;
         when S18 =>
         next_state <= S20;
         when S19 =>
         next_state <= S20;
         -------------------cuarto dígito dentro
         when S20 =>
         if rising_edge(okey) then
         next_state <= S21;
         end if;
         when S21 =>
         --ya está
         when others =>
         next_state <= S0;
        end case;
     end if;
 end process;
 
 output_decod: process (current_state)
 variable auxiliar: std_logic_vector(7 downto 0);
 begin

   case current_state is
      when S0 => 
      auxiliar := (OTHERS => '0');
      led_contrasena <= (OTHERS => '0');
      when S1 =>
      auxiliar(0) := '0';
      auxiliar(1) := '0';
      led_contrasena <= "0001";
      when S2 =>
      auxiliar(0) := '1';
      auxiliar(1) := '0';
      led_contrasena <= "0011";
      when S3 =>
      auxiliar(0) := '0';
      auxiliar(1) := '1';
      led_contrasena <= "0111";
      when S4 =>
      auxiliar(0) := '1';
      auxiliar(1) := '1';
      led_contrasena <= "1111";
      ----------------------primer digito introducido
      when S6 =>
      auxiliar(2) := '0';
      auxiliar(3) := '0';
      led_contrasena <= "0001";
      when S7 =>
      auxiliar(2) := '1';
      auxiliar(3) := '0';
      led_contrasena <= "0011";
      when S8 =>
      auxiliar(2) := '0';
      auxiliar(3) := '1';
      led_contrasena <= "0111";
      when S9 =>
      auxiliar(2) := '1';
      auxiliar(3) := '1';
      led_contrasena <= "1111";
      -----------------------segundo dígito dentro
      when S11 =>
      auxiliar(4) := '0';
      auxiliar(5) := '0';
      led_contrasena <= "0001";
      when S12 =>
      auxiliar(4) := '1';
      auxiliar(5) := '0';
      led_contrasena <= "0011";
      when S13 =>
      auxiliar(4) := '0';
      auxiliar(5) := '1';
      led_contrasena <= "0111";
      when S14 =>
      auxiliar(4) := '1';
      auxiliar(5) := '1';
      led_contrasena <= "1111";
      -----------------tercer digito dentro
      when S16 =>
      auxiliar(6) := '0';
      auxiliar(7) := '0';
      led_contrasena <= "0001";
      when S17 =>
      auxiliar(6) := '1';
      auxiliar(7) := '0';
      led_contrasena <= "0011";
      when S18 =>
      auxiliar(6) := '0';
      auxiliar(7) := '1';
      led_contrasena <= "0111";
      when S19 =>
      auxiliar(6) := '1';
      auxiliar(7) := '1';
      led_contrasena <= "1111";
      -------------------cuarto dígito dentro
      when S21 =>
      led_contrasena <= (OTHERS => '0');
      when others =>
      auxiliar := auxiliar;
      led_contrasena <= led_contrasena;
   end case;
   contrasena<=auxiliar;
 end process;
end behavioral;