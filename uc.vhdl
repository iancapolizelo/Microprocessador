--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
	port( uc_clk	:	in std_logic;
		  uc_rst	:	in std_logic;
		  rom_dado	:	in unsigned(15 downto 0);
		  jump_en	:	out std_logic;
		  cte		:	out unsigned(7 downto 0);
		  state		:	out unsigned(1 downto 0);
		  reg_a		:	out unsigned(2 downto 0);
		  reg_b		:	out unsigned(2 downto 0);
		  ula_sel	:	out unsigned(1 downto 0);
		  ula_a_sel	:	out std_logic;
		  ula_b_sel	:	out std_logic;
		  reg_wr_en	:	out std_logic;
		  z_in		:	in std_logic;
		  c_in		:	in std_logic;
		  jump_r 	:	out std_logic;
		  ram_wr_en :	out std_logic;
		  acess_ram	:	out std_logic
		);
end entity;

architecture a_uc of uc is
	component maq_estados3 
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
	signal add, addq, sub, subq, cmpi, cmpa : unsigned (4 downto 0);
	signal move_a_r, move_r_a, move_r_n, move_r_r : unsigned (4 downto 0);
	signal jmp, bra : unsigned (4 downto 0);
	signal bc : unsigned (3 downto 0);
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
						  
	opcode <= rom_dado(15 downto 11);
						  
	--Aqui ficam os opcodes:
										
	add <= "00001"; -- add A, R -> 00001 00000000rrr
	
	addq <= "00010"; -- addq A, n -> 00010 000nnnnnnnn
	
	sub <= "00011"; -- sub A, R -> 00011 00000000rrr
	
	subq <= "00100"; -- subq A, n -> 00100 000nnnnnnnn

	cmpi <= "00101"; -- cmpi A, n -> 00101 000nnnnnnnn
	
	cmpa <= "00110"; -- cmpa A, R -> 00110 00000000rrr
	
	move_a_r <= "00111"; -- move_a_r A, (R) -> 00111 00000000rrr
	
	move_r_a <= "01000"; -- move_r_a (R), A -> 01000 00000000rrr
	
	move_r_n <= "01001"; -- move_r_n a, n -> 01001 rrrnnnnnnnn
	
	move_r_r <= "01010"; -- move_r_r a, R -> 01010 rrr00000ggg
	
	jmp <= "01011"; -- jmp n -> 01011 000nnnnnnnn
	
	bra <= "10011"; -- bra n -> 10011 000nnnnnnnn
	
	bc <= "1100"; -- bcf n (f = C -> BCS/f = Z -> BEQ) -> 1100f 000nnnnnnnn
	
	--Aqui fica a decodificação da instrução:
	
	reg_a <= rom_dado(10 downto 8) when opcode = move_r_n or opcode = move_r_r else
			"001"; -- A/r
	
	reg_b <= rom_dado(2 downto 0); -- r/g
	
	jump_en <= '1' when opcode = jmp or opcode = bra or 
				((opcode(4 downto 1) = bc) and ((f = '0' and z = '1') or (f = '1' and c = '1'))) else 
				'0';
	
	cte <= rom_dado(7 downto 0); -- n
	
	f <= '1' when opcode(0) = '1' else '0'; --f: 0 - Z | 1 - C

	
	ula_sel <= "00" when opcode = add or opcode = addq or opcode= bra or opcode(4 downto 1) = bc else
				"01" when opcode = sub or opcode = subq or opcode = cmpi or opcode = cmpa else
				"10";
	
	ula_b_sel <= '0' when opcode = add or opcode = sub or opcode = cmpa or opcode = move_r_r else
				'1';
				
	
	ula_a_sel <= '1' when opcode = bra or ((opcode(4 downto 1) = bc) and ((f = '0' and z = '1') or (f = '1' and c = '1'))) 
				else '0';
				
	flags_wr_en <= '1' when opcode = cmpi or opcode = cmpa or opcode = add or opcode = addq or opcode = sub or opcode = subq else
				    '0';
				
	reg_wr_en <= '1' when opcode = add or opcode = addq or opcode = sub or opcode = subq or opcode = move_r_n or opcode = move_r_r or opcode = move_a_r else
				'0';
		
	--flag de jump relativo		
	jump_r <= '1' when opcode(4 downto 1) = bc or opcode = bra else
			  '0';
			  
	ram_wr_en <= '1' when opcode = move_r_a else '0';
	
	acess_ram <= '1' when opcode = move_r_a or opcode = move_a_r else '0';
	
	state <= estado;
	
end architecture;