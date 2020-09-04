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
		0 => "0000000000001",
		1 => "1111100000100",
		2 => "1111100000000",
		3 => "1111100000010",
		4 => "0000000000101",
		5 => "0000000000110",
		6 => "0000000000111",
		7 => "0000000001000",
		8 => "1111100000110",
		9 => "0111011011010",
		10 => "0000000001011",
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