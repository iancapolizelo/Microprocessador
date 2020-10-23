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
		0 => "0100100100000000", -- move_r_n A, 0
		1 => "0001000000000001", --fill: addq A, 1
		2 => "0100000000000001", -- 			move_r_a Ra, A
		3 => "0010100000100000", -- 			bcc_r A, 32
		4 => "1100100011111101", -- 			jump_r_f C, fill(-3)
		5 => "0100101000000001", --			move_r_n R2, 1
		6 => "0101000100000010", --iterate: move_r_r A, R2
		7 => "0001000000000001", -- 	    	addq A, 1
		8 => "0101001000000001", --		    move_r_r R2, A
		9 => "0011100000000010", --		    move_a_r A, (R2)
		10 => "0101001100000001", --		    move_r_r R3, A
		11 => "0010100000000000", --	 	    bcc_n A, 0
		12 => "1100000000010111", --	     	jump_r_f z, it_next(+23)
		13 => "0101010000000010", --			move_r_r R4, R2
		14 => "0101000100000100", --multp: move_r_r A, R4
		15 => "0001000000000001", --		  	addq A, 1
		16 => "0101010000000001", --			move_r_r R4, A
		17 => "0011100000000100", --		    move_a_r A, (R4)
		18 => "0101010100000001", --		    move_r_r R5, A
		19 => "0010100000000000", --		    bcc_n A, 0
		20 => "1100000000001100", --	        jump_r_f Z, next_m(+12)
		21 => "0101000100000101", --sub: move_r_r A, R5
		22 => "0001100000000011", --			sub A, R3
		23 => "0101010100000001", --			move_r_r R5, A
		24 => "0011000000000011", --			bcc_r A, R3
		25 => "1100000011111100", --			jump_r_f Z, sub(-4)
		26 => "1100100000000010", --			jump_r_f C, menor(+2)
		27 => "1001100011111010", --			jump_r sub(-6)
		28 => "0010100000000000", --menor: bcc_n A, 0
		29 => "1100000000000010", --			jump_r_f Z, zera(+2)
		30 => "1001100000000010", --			jump_r next_m(+2)
		31 => "0100000000000100", --zera: move_r_a (R4), A
		32 => "0101000100000100", --next_m: move_r_r A, R4
		33 => "0010100000100000", --			bcc_n A, 32
		34 => "1100100011101100", --			jump_r_f C, multp(-20)
		35 => "0101000100000010", --it_next: move_r_r A, R2
		36 => "0010100000100000", --			bcc_n A, 32
		37 => "1100100011100001", --	     	jump_r_f C, iterate(-31)
		38 => "0100101000000001", --			move_r_n R2, 1
		39 => "0101000100000010", --show: move_r_r A, R2
		40 => "0001000000000001", --			addq A, 1
		41 => "0101001000000001", --			move_r_r R2, A
		42 => "0011100000000010", --			move_a_r A, (R2)
		43 => "0101011000000001", --			move_r_r R6, A
		44 => "0101000100000010", --			move_r_r A, R2
		45 => "0010100000100000", --			bcc_n A, 32
		46 => "1100100011111001", --		    jump_r_f C, show(-7)
		--abaixo: casos omissos => (zero em todos os bits)
		others => (others=>'0')
		);
		
begin
	process(rom_clk)
	begin
		if(rising_edge(rom_clk)) then 
			rom_dado <= conteudo_rom(to_integer(rom_endereco));
		end if;
	end process;
end architecture;