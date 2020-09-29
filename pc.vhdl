--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
	port( pc_clk	   : in std_logic;
		  pc_rst	   : in std_logic;
		  pc_wr_en    : in std_logic; -- clock enable
		  data_in  : in unsigned(7 downto 0);
		  data_out : out unsigned(7 downto 0)
	);
end entity;

architecture a_pc of pc is
	signal registro: unsigned(7 downto 0);
begin
	
	process(pc_clk, pc_rst, pc_wr_en)
	begin
		if pc_rst = '1' then
			registro <= "00000000";
		elsif pc_wr_en='1' then
			if rising_edge(pc_clk) then
				registro <= data_in;
			end if;
		end if;
	end process;
	
	data_out <= registro;
	
end architecture;