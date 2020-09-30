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
	
	signal proc_clk, proc_rst: std_logic;
	signal proc_state : unsigned(1 downto 0);
	signal proc_pc : unsigned(7 downto 0);
	signal proc_rom_dado : unsigned(15 downto 0);
	signal proc_reg1, proc_reg2, proc_ula_out : unsigned(15 downto 0);
	
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
	
	--process
	--begin
	--	wait for 100 ns;
	--	proc_rom_dado <= "0010000101000011"; --0
	--	wait for 100 ns;
	--	proc_rom_dado <= "0010001000000100"; --1
	--	wait for 100 ns;
	--	proc_rom_dado <= "0001011010000100"; --2
	--	wait for 100 ns;
	--	proc_rom_dado <= "0011101010000101"; --3
	--	wait for 100 ns;
	--	proc_rom_dado <= "0001100010000101"; --4
	--	wait for 100 ns;
	--	proc_rom_dado <= "0100000001000101"; --5
	--	wait for 100 ns;
	--	proc_rom_dado <= "1111000000010100"; --6
	--	wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --7
	--	wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --8
	--	wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --9
	--	wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --10
	--	wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --11
	--	wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --12
	--	wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --13
	--	wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --14
	--	wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --15
	--	wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --16
	--	wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --17
		--wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --18
	--	wait for 100 ns;
	--	proc_rom_dado <= "0000000000000000"; --19
	--	wait for 100 ns;
	--	proc_rom_dado <= "0011011010000011"; --20
	--	wait for 100 ns;
	--	proc_rom_dado <= "0001101010000011"; --21
	--	wait for 100 ns;
	--	proc_rom_dado <= "1111000000000011"; --22
	--	wait;
	--end process;
	
end architecture;
		
	