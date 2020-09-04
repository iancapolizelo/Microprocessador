-- Trabalho de Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is  
	port( 	
			uc_clk: in std_logic;
			uc_rst : in std_logic;
			uc_en : in std_logic;
			rom_dado: in unsigned(12 downto 0);
			jump_en : out std_logic;
			jump_addr : out unsigned(7 downto 0);
			state : out std_logic
	);
end entity;

architecture a_uc of uc is
	component maq_estados
		port ( 	clk : in std_logic;
			rst : in std_logic;
			en : in std_logic;
			estado : out std_logic		
	);
	end component;

	signal opcode: unsigned(4 downto 0);
	signal estado : std_logic;
	signal instr: unsigned(12 downto 0);

begin
	maq_estados0: maq_estados port map( clk => uc_clk,
		  						rst => uc_rst,
		  						en => uc_en,
		  						estado => estado);
	
	opcode <= rom_dado(12 downto 8);

	jump_en <= '1' when opcode="11111" else
					'0';
					
	jump_addr <= rom_dado(7 downto 0);

	state <= estado;
end architecture ; -- arch