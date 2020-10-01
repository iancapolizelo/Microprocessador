--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is --mudei as variáveis aqui pra ficar melhor de entender no top
	port( rom_clk		:	in std_logic;
		  rom_endereco	:	in unsigned(7 downto 0);
		  rom_dado		:	out unsigned(15 downto 0)
		);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 255) of unsigned(15 downto 0);
	constant conteudo_rom : mem := (
		--caso endereco => conteudo
		-- Passo 1
		0 => B"0010_011_0_00000101", -- addq R3, 5
		-- Passo 2
		1 => B"0010_100_0_00001000", -- addq R4, 8
		-- Passo 3
		2 => B"0011_101_000000_101", -- sub R5, R5
		3 => B"0001_101_000000_011", -- add R5, R3
		4 => B"0001_101_000000_100", -- add R5, R4
		-- Passo 4
		5 => B"0100_101_0_00000001", -- subq R5, 1
		-- Passo 5
		6 => B"1111_0000_00010100", -- jmp 20 (temos que rever isso aqui)
		7 => "0000000000000000", -- nop
		8 => "0000000000000000", -- nop
		9 => "0000000000000000", -- nop
		10 => "0000000000000000", 
		11 => "0000000000000000", 
		12 => "0000000000000000", 
		13 => "0000000000000000", 
		14 => "0000000000000000", 
		15 => "0000000000000000", 
		16 => "0000000000000000", 
		17 => "0000000000000000", 
		18 => "0000000000000000", 
		19 => "0000000000000000", 
		-- Passo 6
		20 => B"0011_011_000000_011", -- sub R3, R3 
		21 => B"0001_011_000000_101", -- add R3, R5 
		-- Passo 7
		22 => B"1111_0000_00000010", -- jmp 3 (temos que rever isso aqui)
		--abaixo: casos omissos => (zero em todos os bits)
		others => (others=>'0')
		);
		
begin
	process(rom_clk)
	begin
		if(rising_edge(rom_clk)) then --quando tiver uma rampa de subida no clock
			rom_dado <= conteudo_rom(to_integer(rom_endereco));
		end if;
	end process;
end architecture;