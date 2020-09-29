--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
	port( uc_clk	:	in std_logic;
		  uc_rst	:	in std_logic;
		  uc_en		:	in std_logic;
		  rom_dado	:	in unsigned(15 downto 0); --aqui vem o dado da rom
		  jump_en	:	out std_logic; --flag se é pra pular ou não
		  jump_addr	:	out unsigned(7 downto 0); --endereço para o qual vai pular
		  state		:	out std_logic --e estado em que está
		);
end entity;

architecture a_uc of uc is
	component maq_estados --aqui temos que ligar à maq_estados pra ver em que pé está
		port(clk	 :	in std_logic;
			 rst	 :	in std_logic;
			 en	 :	in std_logic;
			 estado :	out std_logic
			);
	end component;
	
	signal opcode	:	unsigned(3 downto 0); --nossos opcodes são de 4 bits
	signal estado	:	std_logic;
	signal instr	:	unsigned(15 downto 0); --nossas instruções tem 16 bits
	
begin
	maq_estados0: maq_estados port map( clk    => uc_clk,
										rst    => uc_rst,
										en     => uc_en,
										estado => estado);
										
	instr <= rom_dado when estado = '0' else "0000000000000000"; --estado 0 é quando faz leitura da rom(fetch)
	
	opcode <= instr(15 downto 12); --bits 15, 14, 13, 12
	
	jump_en <= '1' when opcode = "1111" else '0'; --instrução de jump
	
	jump_addr <= instr(7 downto 0);
	
	state <= estado;
	
end architecture;