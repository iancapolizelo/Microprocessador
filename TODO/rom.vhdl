-- Trabalho de Gustavo Henrique Zeni e Ianca Polizelo
-- Regras:
-- Restrição para codificação: a instrução 0 deverá ser NOP (não faz nada).
-- A ULA será de 16 bits
-- O Banco de Registradores possui 8 registradores de 16 bits; usar o reg. 0 como constante é opcional
-- Os operandos das instruções não possuem 16 bits; portanto vocês não vão conseguir carregar diretamente um valor como 0xFFFF no registrador. Não tem problema.
-- Não é necessário gerar os mesmos opcodes do processador original, mas é exigido que as instruções a implementar existam nele. 
--Por exemplo: no 8051, uma soma com constante é feita com ADD A,#cte, sendo A um registrador especial (o acumulador). Pode-se somar com um registrador com
-- ADD A,Ri, sendo i de 0 a 7. Então você pode implementar uma ou ambas as instruções, mas não pode fazer ADD R3,R4, porque esta não existe.

  
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
	type mem is array (0 to 255) of unsigned (15 downto 0); --fiz mem de 256 bits, calculando 2^8, que são os registradores
	constant conteudo_rom : mem := (
		-- Passos 1 e 2 (temos que ver se aqui antes precisa zerar R3 E R4 - acho que sim)
		0 => "0010000101000011", -- addq 5, R3
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