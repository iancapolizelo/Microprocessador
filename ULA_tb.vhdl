--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_tb is
end;

architecture a_ULA_tb of ULA_tb is

	component ULA 	
		port( entr0,entr1	 				 : in unsigned(15 downto 0);
			  selec_op		 				 : in unsigned(1 downto 0);  
			  saida							 : out unsigned(15 downto 0)
	     );
	end component;
	
	signal entr0 : unsigned(15 downto 0);
	signal entr1 : unsigned(15 downto 0);
	signal selec_op : unsigned(1 downto 0);
	signal saida : unsigned(15 downto 0);
	
	begin
		uut: ULA port map( entr0 => entr0,
						   entr1 => entr1,
						   selec_op => selec_op,
						   saida => saida);
							 
		process
		begin									--Testes do somatório
			entr0 <= "0000000000000011"; 		--  3
			entr1 <= "0000000000000101";		--  5
			selec_op <= "00";
			saida <= "0000000000001000";		--  8
			wait for 50 ns;
			entr0 <= "0000000000000001";		--  1
			entr1 <= "0111111111111110";		--  32766
			selec_op <= "00";
			saida <= "0111111111111111";		--  32767
			wait for 50 ns;
			entr0 <= "0000000000000101";		--  3
			entr1 <= "0000000000000000";		--  0
			selec_op <= "00";
			saida <= "0000000000000101";		--  3
			wait for 50 ns;
			entr0 <= "0000000000000010";		--  2
			entr1 <= "1111111111111100";		-- -4
			selec_op <= "00";
			saida <= "1111111111111110";		-- 	-2
			wait for 50 ns;
			entr0 <= "0000110010110101";		--  3253
			entr1 <= "1111001101001011";		-- -3253
			selec_op <= "00";
			saida <= "0000000000000000";		-- 	0
			wait for 50 ns;
												--Testes de subtração
			entr0 <= "0000000000010001"; 		--  17
			entr1 <= "0000000000001110";		--  14
			selec_op <= "01";
			saida <= "0000000000000011";		--  3
			wait for 50 ns;
			entr0 <= "0000000000010001"; 		--  17
			entr1 <= "0000000000000000";		--  0
			selec_op <= "01";
			saida <= "0000000000010001";		--  17
			wait for 50 ns;
			entr0 <= "0000000000000001"; 		--  1
			entr1 <= "0000000000011111";		--  31
			selec_op <= "01";
			saida <= "1111111111100010";		--  -30
			wait for 50 ns;
			entr0 <= "0111111111111111"; 		--  32767
			entr1 <= "0111111111111111";		--  32767
			selec_op <= "01";
			saida <= "0000000000000000";		--  0
			wait for 50 ns;
			entr0 <= "0000000000000000"; 		--  0
			entr1 <= "0000000000000000";		--  0
			selec_op <= "01";
			saida <= "0000000000000000";		--  0
			wait for 50 ns;
												-- Teste para comparação entr0>entr1
			entr0 <= "0000000000000011";		-- 3
			entr1 <= "0000000000000101";		-- 5
			selec_op <= "10";
			saida <= "0000000000000000";		-- 0
			wait for 50 ns;
			entr0 <= "0000000000000011";		-- 3
			entr1 <= "0000000000000011";		-- 3
			selec_op <= "10";
			saida <= "0000000000000000";		-- 0
			wait for 50 ns;
			entr0 <= "0000000000000101";		-- 5
			entr1 <= "0000000000000011";		-- 3
			selec_op <= "10";
			saida <= "0000000000000001";		-- 1
			wait for 50 ns;
			entr0 <= "1111111111100010";		-- -30
			entr1 <= "1111111111111110";		-- -2
			selec_op <= "10";
			saida <= "0000000000000000";		-- 0
			wait for 50 ns;
			entr0 <= "0000000000000000";		-- 0
			entr1 <= "1111111111111110";		-- -2
			selec_op <= "10";
			saida <= "0000000000000000";		-- 0
			wait for 50 ns;
												-- Teste para verificar se entr0 é negativo
			entr0 <= "0000000000000011";		-- 3
			selec_op <= "11";
			saida <= "0000000000000000";
			wait for 50 ns;
			entr0 <= "1111111111100010";		-- -30
			selec_op <= "11";
			saida <= "0000000000000001";
			wait for 50 ns;
			entr0 <= "0000000000001110";		-- 14
			selec_op <= "11";
			saida <= "0000000000000000";
			wait for 50 ns;
			entr0 <= "1111111111111100";		-- -4
			selec_op <= "11";
			saida <= "0000000000000001";
			wait for 50 ns;
			wait;
		end process;
end architecture;