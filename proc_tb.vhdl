-- Trabalho de Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proc_tb is
end;

architecture a_proc_tb of proc_tb is
	component proc
	port( 	proc_clk : in std_logic;
			proc_wr_en : in std_logic;
			proc_rst : in std_logic;
			proc_en : in std_logic
	);
	end component;
	signal proc_clk, proc_en, proc_rst, proc_wr_en: std_logic;

begin

uut: proc port map ( proc_clk => proc_clk,
					proc_wr_en => proc_wr_en,
					proc_rst => proc_rst,
					proc_en => proc_en);
	process
	begin
		proc_clk <= '0';
		wait for 50 ns;
		proc_clk <= '1';
		wait for 50 ns;
	end process;
	
	process -- sinal de reset
	begin
		proc_rst <= '1';
		wait for 100 ns;
		proc_rst <= '0';
		wait;
	end process;
	
	process
	begin
		wait for 100 ns;
		proc_en <= '1';
		proc_wr_en <= '0';
		wait for 100 ns;
		proc_wr_en <= '1';
		wait for 2500 ns;
		proc_en <= '0';
		wait;
	end process;

end architecture;