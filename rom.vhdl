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
		0 => "0010000101000011",
		1 => "0010001000000100", -- addq 8, R4
		-- Passo 3
		2 => "0001011010000100", -- add R3, R4 (a soma dos dois fica no R4)
		3 => "0011101010000101", -- sub R5, R5 (aqui vamos zerar o R5)
		4 => "0001100010000101", -- add R4, R5 (pra gravar o resultado do R4 no R5)
		-- Passo 4
		5 => "0100000001000101", -- subq 1, R5
		-- Passo 5
		6 => "0101111011010100", -- jmp 20 (temos que rever isso aqui)
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
		20 => "0011011010000011", -- sub R3, R3 (temos que zerar o R3 aqui) 
		21 => "0001101010000011", -- add R5, R3 (faz R5+R3->R3 - como R3 tá zerado, então R3=R5)
		-- Passo 7
		22 => "0101111011000011", -- jmp 3 (temos que rever isso aqui)
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