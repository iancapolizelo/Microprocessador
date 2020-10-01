--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
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
end entity;

architecture a_uc of uc is
	component maq_estados3 --aqui temos que ligar à maq_estados pra ver em que pé está
		port(clk	 :	in std_logic;
			 rst	 :	in std_logic;
			 estado :	out unsigned(1 downto 0)
			);
	end component;
	
	signal opcode	:	unsigned(3 downto 0); --nossos opcodes são de 4 bits
	signal estado	:	unsigned(1 downto 0);
	signal add, addq, sub, subq, jump: unsigned (3 downto 0); --4 bits de opcode
	
begin
	maq_estados0: maq_estados3 port map( clk    => uc_clk,
										rst    => uc_rst,
										estado => estado);
										
	add <= "0001"; --0001 rrrXXXXXXrrr - add Ra, Rb: salva no reg_b
	
	addq <= "0010"; --0010 nnnnnnnnXrrr - addq n, Rb: salva no reg_b
	
	sub <= "0011"; --0011 rrrXXXXXXrrr - sub Ra, Rb: salva no reg_b
	
	subq <= "0100"; --0100 nnnnnnnnXrrr - subq n, Rb: salva no reg_b
	
	jump <= "1111"; --1111 0000nnnnnnnn - jump 
	
	opcode <= rom_dado(15 downto 12); --bits 15, 14, 13, 12
	
	reg_a <= rom_dado(11 downto 9) when opcode = add or opcode = sub else "000"; -- 11, 10, 9
	
	reg_b <= rom_dado(2 downto 0) when opcode = add or opcode = addq or opcode = sub or opcode = subq else
				"000"; -- 2, 1, 0 (menos no jump)
	
	jump_en <= '1' when opcode = jump else '0';
	
	cte <= rom_dado(11 downto 4) when opcode = addq or opcode = subq else 
		   rom_dado(7 downto 0) when opcode = jump else
		   "00000000"; -- cte pode ser addq, subq ou jump
	
	ula_sel <= "00" when opcode = add or opcode = addq else
				"01" when opcode = sub or opcode = subq else
				"10";
				
	ula_b_sel <= '0' when opcode = add or opcode = sub else
				'1';
				
	reg_wr_en <= '1' when opcode = add or opcode = addq or opcode = sub or opcode = subq else
				'0';
	
	state <= estado;
	
end architecture;