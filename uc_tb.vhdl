--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc_tb is
end;

architecture a_uc_tb of uc_tb is
	component uc
	port( uc_clk	:	in std_logic;
		  uc_rst	:	in std_logic;
		  uc_en		:	in std_logic;
		  rom_dado	:	in unsigned(15 downto 0);
		  jump_en	:	out std_logic; 
		  jump_addr	:	out unsigned(7 downto 0); 
		  state		:	out std_logic
		);
	end component;
	
	signal rom_dado	:	unsigned(15 downto 0);
	signal uc_clk, uc_rst, uc_en, jump_en, state : std_logic;
	signal jump_addr : unsigned(7 downto 0);
	
begin
uut: uc port map(uc_clk => uc_clk,
				 uc_rst => uc_rst,
				 uc_en => uc_en,
				 rom_dado => rom_dado,
				 jump_en => jump_en,
				 jump_addr => jump_addr,
				 state => state);
				 
	process
	begin
		uc_clk <= '0';
		wait for 50 ns;
		uc_clk <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin
		uc_rst <= '1';
		wait for 100 ns;
		uc_rst <= '0';
		wait;
	end process;
	
	process
	begin
		wait for 100 ns;
		uc_en <= '1';
		rom_dado <= "0000110001001";
		wait for 300 ns;
		rom_dado <= "1111100000011";
		wait for 200 ns;
		uc_en <= '0';
		rom_dado <= "1111100000101";
		wait;
	end process;

end architecture; 