--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end;

architecture a_processador_tb of processador_tb is
	component processador
	port( proc_clk		:	in std_logic;
		  proc_rst		:	in std_logic;
		  proc_state 	:	out unsigned(1 downto 0);
		  proc_pc		:	out unsigned(7 downto 0);
		  proc_rom_dado :	out unsigned(15 downto 0);
		  proc_reg1		:	out unsigned(15 downto 0);
		  proc_reg2		:	out unsigned(15 downto 0);
		  proc_ula_out	:	out unsigned(15 downto 0)
		);
	end component;
	
	signal proc_clk, proc_rst: std_logic := '0';
	signal proc_state : unsigned(1 downto 0) := "00";
	signal proc_pc : unsigned(7 downto 0) := "00000000";
	signal proc_rom_dado : unsigned(15 downto 0) := "0000000000000000";
	signal proc_reg1, proc_reg2, proc_ula_out : unsigned(15 downto 0) := "0000000000000000";
	
begin
-- Pino com sinal
uut: processador port map( proc_clk => proc_clk,
						 proc_state => proc_state,
						 proc_rst => proc_rst,
						 proc_pc => proc_pc,
						 proc_rom_dado => proc_rom_dado,
						 proc_reg1 => proc_reg1,
						 proc_reg2 => proc_reg2,
						 proc_ula_out => proc_ula_out);
						 
	process
	begin --sinal do clock
		proc_clk <= '0';
		wait for 50 ns;
		proc_clk <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin --sinal de reset
		proc_rst <= '1';
		wait for 100 ns;
		proc_rst <= '0';
		wait;
	end process;
	
end architecture;
		
	