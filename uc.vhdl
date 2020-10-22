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
		  jump_r_flag 	:	out std_logic;
		  ram_wr_en :	out std_logic;
		  acess_ram	:	out std_logic
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
		
	
	signal opcode	:	unsigned(4 downto 0);
	signal estado	:	unsigned(1 downto 0);
	signal add, addq, sub, subq, bcc_n, bcc_r : unsigned (4 downto 0);
	signal move_a_r, move_r_a, move_r_n, move_r_r : unsigned (4 downto 0);
	signal jump_e, jump_r : unsigned (4 downto 0);
	signal jump_e_f, jump_r_f : unsigned (3 downto 0);
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
										
	add <= "00001"; --
	
	addq <= "00010"; --
	
	sub <= "00011"; --
	
	subq <= "00100"; --

	bcc_n <= "00101"; -- 
	
	bcc_r <= "00110";
	
	move_a_r <= "00111";
	
	move_r_a <= "01000";
	
	move_r_n <= "01001";
	
	move_r_r <= "01010";
	
	jump_e <= "01011";
	
	jump_e_f <= "1000";
	
	jump_r <= "10011";
	
	jump_r_f <= "1100";
	
	--Aqui fica a decodificação da instrução:
	
	-- Parei aqui
	
	opcode <= rom_dado(15 downto 11); --bits 15, 14, 13, 12, 11
	
	reg_a <= "001" when opcode = move_a_r else 
			rom_dado(10 downto 8); -- 10, 9, 8
	
	reg_b <= rom_dado(2 downto 0) when opcode = add or opcode = sub or opcode = bcc_r or opcode = move_a_r or opcode = move_r_r else
			 "001" when opcode = move_r_a else
				"000"; -- 2, 1, 0 (menos no jump)
	
	jump_en <= '1' when opcode = jump_e or opcode = jump_r or 
				((opcode(4 downto 1) = jump_r_f or opcode(4 downto 1) = jump_e_f) and ((f = '0' and z = '1') or (f = '1' and c = '1'))) else 
				'0';
	
	cte <= rom_dado(7 downto 0) when opcode = addq or opcode = subq or opcode = bcc_n or opcode = move_r_n or opcode = jump_e or opcode = jump_r or
			opcode(4 downto 1) = jump_e_f or opcode(4 downto 1) = jump_r_f else
			"00000000"; -- cte pode ser addq, subq ou jump
	
	f <= '1' when opcode(0) = '1' else '0'; --f: 0 - Z | 1 - C
	
	--PAREI AQUI
	
	ula_sel <= "00" when opcode = add or opcode = addq or opcode= jump_r or opcode(4 downto 1) = jump_r_f else
				"01" when opcode = sub or opcode = subq or opcode = bcc_n or opcode = bcc_r else
				"10";
	
	ula_b_sel <= '0' when opcode = add or opcode = sub or opcode = bcc_r or opcode(4 downto 1) = move_r_r else
				'1';
				
	--ula_a_sel ativa quando é jump relativo, senão fica 0			
	ula_a_sel <= '1' when opcode = jump_r or ((opcode(4 downto 1) = jump_r_f) and ((f = '0' and z = '1') or (f = '1' and c = '1'))) 
				else '0';
				
	flags_wr_en <= '1' when opcode = bcc_n or opcode = bcc_r or opcode = add or opcode = addq or opcode = sub or opcode = subq else
				    '0';
				
	reg_wr_en <= '1' when opcode = add or opcode = addq or opcode = sub or opcode = subq or opcode = move_r_n or opcode = move_r_r or opcode = move_a_r else
				'0';
		
	--flag de jump relativo		
	jump_r_flag <= '1' when opcode(4 downto 1) = jump_r_f or opcode = jump_r else
			  '0';
			  
	ram_wr_en <= '1' when opcode = move_r_a else '0';
	
	acess_ram <= '1' when opcode = move_r_a or opcode = move_a_r else '0';
	
	state <= estado;
	
end architecture;