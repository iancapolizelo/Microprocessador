-- Trabalho de Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end;

architecture pc_tb of pc_tb is
	component pc
	port( pc_clk : in std_logic;
		  pc_rst : in std_logic;
		  pc_wr_en : in std_logic;
		  data_in : in unsigned(7 downto 0);
		  data_out : out unsigned(7 downto 0)
	);
	end component;
	signal pc_clk, pc_rst, pc_wr_en: std_logic;
	signal data_in, data_out: unsigned(7 downto 0);
	
begin
	
 -- uut significa Unit Under Test
 uut: pc port map(          pc_clk => pc_clk,
					        pc_rst => pc_rst,
					        pc_wr_en => pc_wr_en,
					        data_in => data_in,
					        data_out => data_out);
					  
	process
	begin
		pc_clk <= '0';
		wait for 50 ns;
		pc_clk <= '1';
		wait for 50 ns;
	end process;
	
	process -- sinal de reset
	begin
		pc_rst <= '1';
		wait for 100 ns;
		pc_rst <= '0';
		wait;
	end process;
	
	process -- sinais dos casos de teste
	begin
		wait for 100 ns;
		pc_wr_en <= '1';
		data_in <= x"3A";
		wait for 100 ns;
		data_in <= x"82";
        wait for 100 ns;
		pc_wr_en <= '0';
		data_in <= x"1E";
		wait;
	end process;
end architecture;