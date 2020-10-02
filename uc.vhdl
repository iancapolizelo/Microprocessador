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
		  ula_a_sel	:	out std_logic;
		  ula_b_sel	:	out std_logic;
		  reg_wr_en	:	out std_logic;
		  z_in		:	in std_logic;
		  c_in		:	in std_logic;
		  jump_r 	:	out std_logic
		);
end entity;

architecture a_uc of uc is
	component maq_estados3 --aqui temos que ligar à maq_estados pra ver em que pé está
		port(clk	 :	in std_logic;
			 rst	 :	in std_logic;
			 estado :	out unsigned(1 downto 0)
			);
	end component;
	
	component flag
		port(clk	:	in std_logic;
			 rst	:	in std_logic;
			 wr_en	:	in std_logic;
			 data_in:	in std_logic;
			 data_out:	out std_logic
			);
	end component;
		
	
	signal opcode	:	unsigned(3 downto 0); --nossos opcodes são de 4 bits
	signal estado	:	unsigned(1 downto 0);
	signal add, addq, sub, subq, jump, bcc: unsigned (3 downto 0); --4 bits de opcode
	signal jump_r_f : unsigned(2 downto 0); --jump relativo com flag
	signal f, z, c	:	std_logic;
	signal flags_wr_en	:	std_logic;
	
begin

	--Aqui ficam os componentes:

	maq_estados0: maq_estados3 port map( clk    => uc_clk,
										rst    => uc_rst,
										estado => estado);
										
	flag_z: flag port map(clk => uc_clk,
						  rst => uc_rst,
						  wr_en => flags_wr_en,
						  data_in => z_in,
						  data_out => z);
					
	flag_c: flag port map(clk => uc_clk,
						  rst => uc_rst,
						  wr_en => flags_wr_en,
						  data_in => c_in,
						  data_out => c);
						  
	--Aqui ficam os opcodes:
										
	add <= "0001"; --0001 rrrXXXXXXrrr - add Ra, Rb: salva no reg_b
	
	addq <= "0010"; --0010 nnnnnnnnXrrr - addq n, Rb: salva no reg_b
	
	sub <= "0011"; --0011 rrrXXXXXXrrr - sub Ra, Rb: salva no reg_b
	
	subq <= "0100"; --0100 nnnnnnnnXrrr - subq n, Rb: salva no reg_b
	
	jump <= "1111"; --1111 0000nnnnnnnn - jump
	
	jump_r_f <= "100"; --100f 0000nnnnnnnn - jump relativo com flag

	bcc <= "0101"; -- 0101 rrrXnnnnnnnn - bcc Ra, n : compara r < n
	
	--Aqui fica a decodificação da instrução:
	
	opcode <= rom_dado(15 downto 12); --bits 15, 14, 13, 12
	
	reg_a <= rom_dado(11 downto 9); -- 11, 10, 9
	
	reg_b <= rom_dado(2 downto 0) when opcode = add or opcode = sub else
				"000"; -- 2, 1, 0 (menos no jump)
	
	jump_en <= '1' when opcode = jump or ((opcode(3 downto 1) = jump_r_f) and ((f = '0' and z = '1') or (f = '1' and c = '1'))) else '0';
	
	cte <= rom_dado(7 downto 0) when opcode = addq or opcode = subq or opcode = bcc or opcode = jump or opcode(3 downto 1) = jump_r_f; -- cte pode ser addq, subq ou jump
	
	f <= '1' when opcode(0 downto 0) = "1" else '0'; --f: 0 - Z | 1 - C
	
	ula_sel <= "00" when opcode = add or opcode = addq or opcode(3 downto 1) = jump_r_f else
				"01" when opcode = sub or opcode = subq or opcode = bcc else
				"10";
	
	--ula_b_sel ativa quando é add ou sub
	ula_b_sel <= '0' when opcode = add or opcode = sub else
				'1';
				
	--ula_a_sel ativa quando é jump relativo, senão fica 0			
	ula_a_sel <= '1' when ((opcode(3 downto 1) = jump_r_f) and ((f = '0' and z = '1') or (f = '1' and c = '1'))) else '0';
				
	flags_wr_en <= '1' when opcode = bcc or opcode = add or opcode = addq or opcode = sub or opcode = subq else
				    '0';
				
	reg_wr_en <= '1' when opcode = add or opcode = addq or opcode = sub or opcode = subq else
				'0';
		
	--flag de jump relativo		
	jump_r <= '1' when opcode(3 downto 0) = jump_r_f else
			  '0';
	
	state <= estado;
	
end architecture;