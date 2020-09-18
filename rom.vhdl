-- Trabalho de Gustavo Henrique Zeni e Ianca Polizelo

  
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port( 	clk	: in std_logic;
			endereco : in unsigned(7 downto 0);
			dado : out unsigned(15 downto 0)
		);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 254) of unsigned (15 downto 0);
	constant conteudo_rom : mem := (
		0 => "0101101010000011", -- addq R3, 5
		1 => "0101100010000100", -- addq R4, 8
		2 => "0101000010000001", -- addq A, 0
		3 => "1101011010000000", --add A, R3 
		4 => "1101100010000000", -- add A, R4
		5 => "0101001010000101", -- addq R5, A
		6 => "0101001010000101" -- addq A, R5
		7 => "0101001110000001", -- subq A, 1
		8 => "0101001010000101", -- addq R5, A
		9 => "0100111011010100", -- jp 20
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
		20 => "1101101010000011", -- ld R5, R3 
		21 => "0100111011000010", -- jp 2
		others => (others=>'0')
		);

	begin
		process(clk)
		begin
			if(rising_edge(clk)) then
				dado <= conteudo_rom(to_integer(endereco));
			end if;
		end process;
end architecture;