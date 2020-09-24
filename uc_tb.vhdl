-- Trabalho de Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc_tb is
end;

architecture a_uc_tb of uc_tb is
	component uc
	port( 	uc_clk: in std_logic;
			uc_rst : in std_logic;
			rom_dado: in unsigned(15 downto 0);
			jump_en : out std_logic;
			cte : out unsigned(7 downto 0);
			state : out unsigned(1 downto 0);
			reg_a : out unsigned(2 downto 0);
			reg_b : out unsigned(2 downto 0);
			ula_sel: out unsigned(1 downto 0);
			ula_b_sel: out std_logic;
			reg_wr_en: out std_logic
	);
	end component;
	signal rom_dado : unsigned(15 downto 0);
	signal uc_clk, uc_rst, jump_en : std_logic;
	signal state: unsigned(1 downto 0);
	signal cte: unsigned(7 downto 0);
	signal reg_a, reg_b : unsigned(2 downto 0);
	signal ula_sel: unsigned(1 downto 0);
	signal ula_b_sel, reg_wr_en: std_logic;
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
			ula_b_sel => ula_b_sel,
			reg_wr_en => reg_wr_en);
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
		rom_dado <= "0000110001001";
		wait for 300 ns;
		rom_dado <= "1111100000011";
		wait for 200 ns;
		rom_dado <= "1111100000101";
		wait;
	end process;

end architecture;