--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

--Especificação da ULA:
--	duas entradas de dados de 16 bits
--	uma saída de resultado de 16 bits
--	(opcional) uma ou mais saídas de sinalização de um bit (resultado zero, indicação de "maior" em comparação)
--	entradas para seleção de operações
--No mínimo 4 operações, incluindo:
--	soma
--	subtração
-- uma maneira de comparar dois números (pode ser operador "maior ou igual", ou então verificar o sinal de um número, ou outra maneira)
--	não implemente divisão, pois a implementação do compilador VHDL pode dar uns erros com divisão por zero (são contornáveis, mas melhor evitar)
--
-- Um testbench que cobre todas as operações tem que ser entregue; inclua nele um conjunto de testes razoável, que cobre todos os casos de interesse.
--
-- Resumindo: entram dois dados de 16 bits, escolhe-se qual das 4 operações deve ser executada pela ULA e o resultado desta operação surge na saída de 16 bits.
-- Ou seja, tem que fazer as operações e bota um mux na saída

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
	port( entr0,entr1	 					 : in unsigned(15 downto 0);  -- as duas entradas 
		  selec_op		 					 : in unsigned(1 downto 0);   -- seleção da operação (4 operações, então 2 bits)
																		  -- 00: soma | 01: subtração | 10: entr0 > entr1 | 11: entr0 é negativo
		  saida								 : out unsigned(15 downto 0)  -- saida da ULA
		  );
end entity;

architecture a_ULA of ULA is
begin	 
	saida <=	entr0+entr1	   				 when selec_op="00" else
				entr0-entr1	   				 when selec_op="01" else
				"0000000000000001"  		 when selec_op="10" and entr0>entr1 else
				"0000000000000000"  		 when selec_op="10" and entr0<=entr1 else
				"000000000000000" & entr0(7) when selec_op="11" else
				"0000000000000000";
end architecture;
