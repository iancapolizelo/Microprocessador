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
		  rom_dado	:	in unsigned(15 downto 0); --aqui vem o dado da rom
		  jump_en	:	out std_logic; --flag se é pra pular ou não
		  cte		:	out unsigned(7 downto 0);
		  state		:	out unsigned(1 downto 0); --e estado em que está
		  reg_a		:	out unsigned(2 downto 0);
		  reg_b		:	out unsigned(2 downto 0);
		  ula_sel	:	out unsigned(1 downto 0);
		  ula_a_sel	:	out std_logic;
		  ula_b_sel	:	out std_logic;
		  reg_wr_en	:	out std_logic;
		  z_in		:	in std_logic;
		  c_in		:	in std_logic;
		  jump_r 	:	out std_logic
		);
	end component;
	
	signal rom_dado: unsigned(15 downto 0);
	signal uc_clk, uc_rst, jump_en : std_logic;
	signal state: unsigned(1 downto 0);
	signal cte: unsigned(7 downto 0);
	signal reg_a, reg_b : unsigned(2 downto 0);
	signal ula_sel: unsigned(1 downto 0);
	signal ula_b_sel, ula_a_sel, reg_wr_en: std_logic;
	signal z_in, c_in, jump_r : std_logic;
	
begin
uut: uc port map ( uc_clk => uc_clk,
			uc_rst => uc_rst,
			rom_dado => rom_dado,
			jump_en => jump_en,
			cte => cte,
			state => state,
			reg_a => reg_a,
			reg_b => reg_b,
			ula_sel => ula_sel,
			ula_a_sel => ula_a_sel,
			ula_b_sel => ula_b_sel,
			reg_wr_en => reg_wr_en,
			z_in => z_in,
			c_in => c_in,
			jump_r => jump_r);
	process
	begin
		uc_clk <= '0';
		wait for 50 ns;
		uc_clk <= '1';
		wait for 50 ns;
	end process;
	
	process -- sinal de reset
	begin
		uc_rst <= '1';
		wait for 100 ns;
		uc_rst <= '0';
		wait;
	end process;

	process
	begin
		wait for 100 ns;
		rom_dado <= "0010011000000000"; --0
		wait for 100 ns;
		rom_dado <= "0010100000000000"; --1
		wait for 100 ns;
		rom_dado <= "0001100000000011"; --2
		wait for 100 ns;
		rom_dado <= "0010011000000001"; --3
		wait for 100 ns;
		rom_dado <= "0101011000011110"; --4
		wait for 100 ns;
		rom_dado <= "1001000011111101"; --5
		wait for 100 ns;
		rom_dado <= "0001101000000100";--6
		wait;
	end process;

end architecture;