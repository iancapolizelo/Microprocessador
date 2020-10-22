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
		wait for 100 ns;
		rom_endereco <= "00000001"; --1
		wait for 100 ns;
		rom_endereco <= "00000010"; --2
		wait for 100 ns;
		rom_endereco <= "00000011"; --3
		wait for 100 ns;
		rom_endereco <= "00000100"; --4
		wait for 100 ns;
		rom_endereco <= "00000101"; --5
		wait for 100 ns;
		rom_endereco <= "00000110"; --6
		wait for 100 ns;
		rom_endereco <= "00000111"; --7
		wait for 100 ns;
		rom_endereco <= "00001000"; --8
		wait for 100 ns;
		rom_endereco <= "00001001"; --9
		wait for 100 ns;
		rom_endereco <= "00001010"; --10
		wait for 100 ns;
		rom_endereco <= "00001011"; --11
		wait for 100 ns;
		rom_endereco <= "00001100"; --12
		wait for 100 ns;
		rom_endereco <= "00001101"; --13
		wait for 100 ns;
		rom_endereco <= "00001110"; --14
		wait for 100 ns;
		rom_endereco <= "00001111"; --15
		wait for 100 ns;
		rom_endereco <= "00010000"; --16
		wait for 100 ns;
		rom_endereco <= "00010001"; --17
		wait for 100 ns;
		rom_endereco <= "00010010"; --18
		wait for 100 ns;
		rom_endereco <= "00010011"; --19
		wait for 100 ns;
		rom_endereco <= "00010100"; --20
		wait for 100 ns;
		rom_endereco <= "00010101"; --21
		wait for 100 ns;
		rom_endereco <= "00010110"; --22
		wait for 100 ns;
		rom_endereco <= "00010111"; --23
		wait for 100 ns;
		rom_endereco <= "00011000"; --24
		wait for 100 ns;
		rom_endereco <= "00011001"; --25
		wait for 100 ns;
		rom_endereco <= "00011010"; --26
		wait for 100 ns;
		rom_endereco <= "00011011"; --27
		wait for 100 ns;
		rom_endereco <= "00011100"; --28
		wait for 100 ns;
		rom_endereco <= "00011101"; --29
		wait for 100 ns;
		rom_endereco <= "00011110"; --30
		wait for 100 ns;
		rom_endereco <= "00011111"; --31
		wait for 100 ns;
		rom_endereco <= "00100000"; --32
		wait for 100 ns;
		rom_endereco <= "00100001"; --33
		wait for 100 ns;
		rom_endereco <= "00100010"; --34
		wait for 100 ns;
		rom_endereco <= "00100011"; --35
		wait for 100 ns;
		rom_endereco <= "00100100"; --36
		wait for 100 ns;
		rom_endereco <= "00100101"; --37
		wait for 100 ns;
		rom_endereco <= "00100110"; --38
		wait for 100 ns;
		rom_endereco <= "00100111"; --39
		wait for 100 ns;
		rom_endereco <= "00101000"; --40
		wait for 100 ns;
		rom_endereco <= "00101001"; --41
		wait for 100 ns;
		rom_endereco <= "00101010"; --42
		wait for 100 ns;
		rom_endereco <= "00101011"; --43
		wait for 100 ns;
		rom_endereco <= "00101100"; --44
		wait for 100 ns;
		rom_endereco <= "00101101"; --45
		wait for 100 ns;
		rom_endereco <= "00101110"; --46
		wait;
	end process;
	
end architecture;