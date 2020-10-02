--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flag_tb is
end;

architecture a_flag_tb of flag_tb is
	component flag
		port(clk	:	in std_logic;
			 rst	:	in std_logic;
			 wr_en	:	in std_logic;
			 data_in:	in std_logic;
			 data_out:	out std_logic
			);
	end component;
	
	signal clk, rst, wr_en : std_logic;
	signal data_in, data_out : std_logic;
	
begin
uut: flag port map( clk => clk,
					rst => rst,
					wr_en => wr_en,
					data_in => data_in,
					data_out => data_out);
					
	process
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin
		rst <= '1';
		wait for 100 ns;
		rst <= '0';
		wait;
	end process;
	
	process
	begin
		wait for 100 ns;
		wr_en <= '1';
		data_in <= '1';
		wait for 100 ns;
		wr_en <= '0';
		data_in <= '0';
		wait;
	end process;
	
end architecture;