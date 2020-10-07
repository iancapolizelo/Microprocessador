--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is
end;

architecture a_ram_tb of ram_tb is
	component ram
		port(clk		:	in std_logic;
			 endereco	:	in unsigned(7 downto 0);
			 wr_en		:	in std_logic;
			 dado_in	:	in unsigned(15 downto 0);
			 dado_out	:	out unsigned(15 downto 0)
			);
	end component;
	
	signal clk, wr_en : std_logic;
	signal endereco : unsigned(7 downto 0);
	signal dado_in, dado_out : unsigned(15 downto 0);
	
begin
uut: ram port map(clk => clk,
				  endereco => endereco,
				  wr_en => wr_en,
				  dado_in => dado_in,
				  dado_out => dado_out);
				  
	process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin
		wait for 100 ns;
		wr_en <= '1';
		dado_in <= x"B1FE";
		endereco <= "00000001";
		wait for 100 ns;
		wr_en <= '0';
		dado_in <= x"F0F0";
		endereco <= "00000010";
		wait for 100 ns;
		endereco <= "00001000";
		wait for 100 ns;
		endereco <= "00000001";
		wait;
	end process;
	
end architecture;