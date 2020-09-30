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
		rom_endereco <= "00000000"; --0
		--rom_dado <= "0010000101000011";
		wait for 100 ns;
		rom_endereco <= "00000001"; --1
		--rom_dado <= "0010001000000100";
		wait for 100 ns;
		rom_endereco <= "00000010"; --2
		--rom_dado <= "0001011010000100";
		wait for 100 ns;
		rom_endereco <= "00000011"; --3
		--rom_dado <= "0011101010000101";
		wait for 100 ns;
		rom_endereco <= "00000100"; --4
		--rom_dado <= "0001100010000101";
		wait for 100 ns;
		rom_endereco <= "00000101"; --5
		--rom_dado <= "0100000001000101";
		wait for 100 ns;
		rom_endereco <= "00000110"; --6
		--rom_dado <= "1111000000010100";
		wait for 100 ns;
		rom_endereco <= "00000111"; --7
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00001000"; --8
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00001001"; --9
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00001010"; --10
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00001011"; --11
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00001100"; --12
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00001101"; --13
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00001110"; --14
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00001111"; --15
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00010000"; --16
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00010001"; --17
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00010010"; --18
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00010011"; --19
		--rom_dado <= "0000000000000000";
		wait for 100 ns;
		rom_endereco <= "00010100"; --20
		--rom_dado <= "0011011010000011";
		wait for 100 ns;
		rom_endereco <= "00010101"; --21
		--rom_dado <= "0001101010000011";
		wait for 100 ns;
		rom_endereco <= "00010110"; --22
		--rom_dado <= "1111000000000011";
		wait for 100 ns;
	end process;
	
end architecture;