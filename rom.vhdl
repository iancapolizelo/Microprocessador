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
		0 => B"01001_00100000000", -- move_r_n A, 0
		1 => B"00010_00100000001", --fill: addq A, 1
		2 => B"01000_00100000001", -- 			move_r_a Ra, A
		3 => B"00101_00100100000", -- 			bcc_r A, 32
		4 => B"11001_00011111101", -- 			jump_r_f C, fill(-3)
		5 => B"01001_01000000001", --			move_r_n R2, 1
		6 => B"01010_00100000010", --iterate: move_r_r A, R2
		7 => B"00010_00100000001", -- 	    	addq A, 1
		8 => B"01010_01000000001", --		    move_r_r R2, A
		9 => B"00111_00100000010", --		    move_a_r A, (R2)
		10 => B"01010_01100000001", --		    move_r_r R3, A
		11 => B"00101_00100000000", --	 	    bcc_n A, 0
		12 => B"11000_00000010111", --	     	jump_r_f z, it_next(+23)
		13 => B"01010_10000000010", --			move_r_r R4, R2
		14 => B"01010_00100000100", --multp: move_r_r A, R4
		15 => B"00010_00100000001", --		  	addq A, 1
		16 => B"01010_10000000001", --			move_r_r R4, A
		17 => B"00111_00100000100", --		    move_a_r A, (R4)
		18 => B"01010_10100000001", --		    move_r_r R5, A
		19 => B"00101_00100000000", --		    bcc_n A, 0
		20 => B"11000_00000001100", --	        jump_r_f Z, next_m(+12)
		21 => B"01010_00100000101", --sub: move_r_r A, R5
		22 => B"00011_00100000011", --			sub A, R3
		23 => B"01010_10100000001", --			move_r_r R5, A
		24 => B"00110_00100000011", --			bcc_r A, R3
		25 => B"11000_00011111100", --			jump_r_f Z, sub(-4)
		26 => B"11001_00000000010", --			jump_r_f C, menor(+2)
		27 => B"10011_00011111010", --			jump_r sub(-6)
		28 => B"00101_00100000000", --menor: bcc_n A, 0
		29 => B"11000_00000000010", --			jump_r_f Z, zera(+2)
		30 => B"10011_00000000010", --			jump_r next_m(+2)
		31 => B"01000_10000000001", --zera: move_r_a (R4), A
		32 => B"01010_00100000100", --next_m: move_r_r A, R4
		33 => B"00101_00100100000", --			bcc_n A, 32
		34 => B"11001_00011101100", --			jump_r_f C, multp(-20)
		35 => B"01010_00100000010", --it_next: move_r_r A, R2
		36 => B"00101_00100100000", --			bcc_n A, 32
		37 => B"11001_00011100001", --	     	jump_r_f C, iterate(-31)
		38 => B"01001_01000000001", --			move_r_n R2, 1
		39 => B"01010_00100000010", --show: move_r_r A, R2
		40 => B"00010_00100000001", --			addq A, 1
		41 => B"01010_01000000001", --			move_r_r R2, A
		42 => B"01000_00100000010", --			move_a_r A, (R2)
		43 => B"01010_11000000001", --			move_r_r R6, A
		44 => B"01010_00100000010", --			move_r_r A, R2
		45 => B"00101_00100100000", --			bcc_n A, 32
		46 => B"11001_00011111001", --		    jump_r_f C, show(-7)
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