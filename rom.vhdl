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
		0 => B"0010_011_0_00000000", -- addq R3, 0
		1 => B"0010_100_0_00000000", -- addq R4, 0
		2 => B"0001_100_000000_011", -- add R4, R3
		3 => B"0010_011_0_00000001", -- addq R3, 1
		4 => B"0101_011_0_00011110", -- bcc R3, 30
		5 => B"1001_0000_00000010", --jump_r C, -3
		6 => B"0001_101_000000_100", --add R5, R4 
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