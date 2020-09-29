--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end;

architecture a_rom_tb of rom_tb is
	component rom
	port( rom_clk		:	in std_logic;
		  rom_endereco	:	in unsigned(7 downto 0);
		  rom_dado		:	out unsigned(15 downto 0)
		);
	end component;
	
signal rom_clk 		: std_logic;
signal rom_endereco : unsigned(7 downto 0);
signal rom_dado		: unsigned(15 downto 0);

begin
--pino => sinal
uut: rom port map(rom_clk => rom_clk, 
				  rom_endereco => rom_endereco, 
				  rom_dado => rom_dado);

	process
	begin
		rom_clk <= '0';
		wait for 50 ns;
		rom_clk <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin
		wait for 100 ns;
		rom_endereco <= "00000001";
		wait for 100 ns;
		rom_endereco <= "00000010";
		wait for 100 ns;
		rom_endereco <= "00000011";
		wait for 100 ns;
		rom_endereco <= "00000100";
		wait for 100 ns;
		rom_endereco <= "00001000";
		wait for 100 ns;
		rom_endereco <= "11111110";
		wait;
	end process;
	
end architecture;