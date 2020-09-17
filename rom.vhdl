-- Trabalho de Gustavo Henrique Zeni e Ianca Polizelo

  
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port( 	clk	: in std_logic;
			endereco : in unsigned(7 downto 0);
			dado : out unsigned(12 downto 0)
		);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 254) of unsigned (12 downto 0);
	constant conteudo_rom : mem := (
		0 => "1001100000101", -- ld R3, 5
		1 => "1010000001000", -- ld R4, 8
		2 => "1000100000000", -- ld A, 0
		3 => "0000100000011", -- add A, R3
		4 => "0000100000100", -- add A, R4
		5 => "1110100000001", -- ld R5, A
		6 => "1100100000101", -- ld A, R5
		7 => "0001100000001", -- sub A, 1
		8 => "1110100000001", -- ld R5, A
		9 => "0011000010100", -- jp 20
		10 => "0000000000000", 
		11 => "0000000000000", 
		12 => "0000000000000", 
		13 => "0000000000000", 
		14 => "0000000000000", 
		15 => "0000000000000", 
		16 => "0000000000000", 
		17 => "0000000000000", 
		18 => "0000000000000", 
		19 => "0000000000000", 
		20 => "1110100000101", -- ld R5, R3 
		21 => "0011000000010", -- jp 2
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