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
		  ula_b_sel	:	out std_logic;
		  reg_wr_en	:	out std_logic
		);
	end component;
	
	signal rom_dado: unsigned(15 downto 0);
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
		rom_dado <= "0010000101000011"; --0
		wait for 100 ns;
		rom_dado <= "0010001000000100"; --1
		wait for 100 ns;
		rom_dado <= "0001011010000100"; --2
		wait for 100 ns;
		rom_dado <= "0011101010000101"; --3
		wait for 100 ns;
		rom_dado <= "0001100010000101"; --4
		wait for 100 ns;
		rom_dado <= "0100000001000101"; --5
		wait for 100 ns;
		rom_dado <= "1111000000010100";--6
		wait for 100 ns;
		rom_dado <= "0000000000000000";--7
		wait for 100 ns;
		rom_dado <= "0000000000000000";--8
		wait for 100 ns;
		rom_dado <= "0000000000000000";--9
		wait for 100 ns;
		rom_dado <= "0000000000000000";--10
		wait for 100 ns;
		rom_dado <= "0000000000000000";--11
		wait for 100 ns;
		rom_dado <= "0000000000000000";--12
		wait for 100 ns;
		rom_dado <= "0000000000000000";--13
		wait for 100 ns;
		rom_dado <= "0000000000000000";--14
		wait for 100 ns;
		rom_dado <= "0000000000000000";--15
		wait for 100 ns;
		rom_dado <= "0000000000000000";--16
		wait for 100 ns;
		rom_dado <= "0000000000000000";--17
		wait for 100 ns;
		rom_dado <= "0000000000000000";--18
		wait for 100 ns;
		rom_dado <= "0000000000000000";--19
		wait for 100 ns;
		rom_dado <= "0011011010000011";--20
		wait for 100 ns;
		rom_dado <= "0001101010000011";--21
		wait for 100 ns;
		rom_dado <= "1111000000000011";--22
		wait;
	end process;

end architecture;