--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
	port( entr0			: in unsigned(15 downto 0); -- reg_a
		  entr1			: in unsigned(15 downto 0); -- reg_b
		  selec_op		: in unsigned(1 downto 0);
		  saida			: out unsigned(15 downto 0);
		  z				: out std_logic; --flag de zero
		  c				: out std_logic --flag de carry
		  );
end entity;

architecture a_ULA of ULA is

signal result : unsigned(15 downto 0);
signal in_a_17, in_b_17, soma_17 : unsigned(16 downto 0);
signal carry_soma : std_logic;

begin	 

	in_a_17 <= '0' & entr0; --passamos reg_a para 17 bits
	in_b_17 <= '0' & entr1; --passamos reg_b para 17 bits
	soma_17 <= in_a_17 + in_b_17;
	carry_soma <= soma_17(16); --o carry é o MSB da soma de 17 bits

	result <=	entr0+entr1	   		when selec_op = "00" else --add ou addq
				entr0-entr1	   		when selec_op = "01" else --sub ou subq
				entr1				when selec_op = "10" else --bypass entr1
				"0000000000000001"  when selec_op = "11" and entr0 > entr1 else --gt: entr0 > entr1
				"0000000000000000"  when selec_op = "11" and entr0 <= entr1 else
				"0000000000000000";
				
	saida <= result;
	
	z <= '1' when result = "0000000000000000" else --sempre que o resultado for zero, ativa
		 '0';
			
	c <= carry_soma when selec_op = "00" else --carregando a flag de carry, tanto soma quanto subtração
		 '0' when entr1 <= entr0 else
		 '1';
			
				
end architecture;
