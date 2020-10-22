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
		rom_dado <= "0100100100000000"; --0
		wait for 100 ns;
		rom_dado <= "0001000100000001"; --1
		wait for 100 ns;
		rom_dado <= "0100000100000001"; --2
		wait for 100 ns;
		rom_dado <= "0010100100100000"; --3
		wait for 100 ns;
		rom_dado <= "1100100011111101"; --4
		wait for 100 ns;
		rom_dado <= "0100101000000001"; --5
		wait for 100 ns;
		rom_dado <= "0101000100000010"; --6
		wait for 100 ns;
		rom_dado <= "0001000100000001"; --7
		wait for 100 ns;
		rom_dado <= "0101001000000001"; --8
		wait for 100 ns;
		rom_dado <= "0011100100000010"; --9
		wait for 100 ns;
		rom_dado <= "0101001100000001"; --10
		wait for 100 ns;
		rom_dado <= "0010100100000000"; --11
		wait for 100 ns;
		rom_dado <= "1100000000010111"; --12
		wait for 100 ns;
		rom_dado <= "0101010000000010"; --13
		wait for 100 ns;
		rom_dado <= "0101000100000100"; --14
		wait for 100 ns;
		rom_dado <= "0001000100000001"; --15
		wait for 100 ns;
		rom_dado <= "0101010000000001"; --16
		wait for 100 ns;
		rom_dado <= "0011100100000100"; --17
		wait for 100 ns;
		rom_dado <= "0101010100000001"; --18
		wait for 100 ns;
		rom_dado <= "0010100100000000"; --19
		wait for 100 ns;
		rom_dado <= "1100000000001100"; --20
		wait for 100 ns;
		rom_dado <= "0101000100000101"; --21
		wait for 100 ns;
		rom_dado <= "0001100100000011"; --22
		wait for 100 ns;
		rom_dado <= "0101010100000001"; --23
		wait for 100 ns;
		rom_dado <= "0011000100000011"; --24
		wait for 100 ns;
		rom_dado <= "1100000011111100"; --25
		wait for 100 ns;
		rom_dado <= "1100100000000010"; --26
		wait for 100 ns;
		rom_dado <= "1001100011111010"; --27
		wait for 100 ns;
		rom_dado <= "0010100100000000"; --28
		wait for 100 ns;
		rom_dado <= "1100000000000010"; --29
		wait for 100 ns;
		rom_dado <= "1001100000000010"; --30
		wait for 100 ns;
		rom_dado <= "0100010000000001"; --31
		wait for 100 ns;
		rom_dado <= "0101000100000100"; --32
		wait for 100 ns;
		rom_dado <= "0010100100100000"; --33
		wait for 100 ns;
		rom_dado <= "1100100011101100"; --34
		wait for 100 ns;
		rom_dado <= "0101000100000010"; --35
		wait for 100 ns;
		rom_dado <= "0010100100100000"; --36
		wait for 100 ns;
		rom_dado <= "1100100011100001"; --37
		wait for 100 ns;
		rom_dado <= "0100101000000001"; --38
		wait for 100 ns;
		rom_dado <= "0101000100000010"; --39
		wait for 100 ns;
		rom_dado <= "0001000100000001"; --40
		wait for 100 ns;
		rom_dado <= "0101001000000001"; --41
		wait for 100 ns;
		rom_dado <= "0100000100000010"; --42
		wait for 100 ns;
		rom_dado <= "0101011000000001"; --43
		wait for 100 ns;
		rom_dado <= "0101000100000010"; --44
		wait for 100 ns;
		rom_dado <= "0010100100100000"; --45
		wait for 100 ns;
		rom_dado <= "1100100011111001"; --46
		wait;
	end process;

end architecture;