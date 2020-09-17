-- Trabalho de Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maq_estados3_tb is
end;

architecture a_maq_estados3_tb of maq_estados3_tb is
	component maq_estados3
	port ( 	clk : in std_logic;
			rst : in std_logic;
			en : in std_logic;
			estado: out unsigned(1 downto 0)
		
	);
end component;

signal clk, rst, en: std_logic;
signal estado: unsigned(1 downto 0);

begin

uut: maq_estados3 port map(	clk => clk,
							rst => rst,
							en => en,
							estado => estado);

	process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;
	
	process -- sinal de reset
	begin
		rst <= '1';
		wait for 100 ns;
		rst <= '0';
		wait;
	end process;

	process
	begin
		wait for 100 ns;
		en <= '0';
		wait for 200 ns;
		en <= '1';
		wait for 500 ns;
		en <= '0';
		wait;
	end process;

end architecture;