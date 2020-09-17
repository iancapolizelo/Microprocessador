-- Trabalho de Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is  
	port( 	
			uc_clk: in std_logic;
			uc_rst : in std_logic;
			rom_dado: in unsigned(12 downto 0);
			jump_en : out std_logic;
			cte : out unsigned(7 downto 0);
			state : out unsigned(1 downto 0);
			reg_a : out unsigned(2 downto 0);
			reg_b : out unsigned(2 downto 0);
			ula_sel: out unsigned(1 downto 0);
			ula_b_sel: out std_logic;
			reg_wr_en: out std_logic
	);
end entity;

architecture a_uc of uc is
	component maq_estados3
		port ( 	clk : in std_logic;
			rst : in std_logic;
			estado : out unsigned(1 downto 0)
	);
	end component;

	signal opcode: unsigned(4 downto 0);
	signal estado : unsigned(1 downto 0);
	signal add_a_n, add_a_r, sub_a_n, sub_a_r, jr_n, jp_n, jp_a: unsigned(4 downto 0);
	signal jr_f_n, jp_f_n: unsigned(3 downto 0);
	signal ld_r_n, ld_r_g:  unsigned(1 downto 0);
	signal f: std_logic;
begin
	maq_estados0: maq_estados3 port map( clk => uc_clk,
		  						rst => uc_rst,
		  						estado => estado);
	
	opcode <= rom_dado(12 downto 8);
	
	add_a_n <= "00001"; --00001 nnnnnnnn - add a, n
	
	add_a_r <= "00010"; --00010 XXXXXrrr - add a, r
	
	sub_a_n <= "00011"; --00011 nnnnnnnn - sub a, n
	
	sub_a_r <= "00100"; --00100 XXXXXrrr - sub a, r
	
	jr_n <= "00101"; --00101 nnnnnnnn - jr n
	
	jp_n <= "00110"; --00110 nnnnnnnn - jp n
	
	jp_a <= "00111"; --00111 xxxxxxxx - jp a
	
	jr_f_n <= "0100"; --0100f nnnnnnnn - jr f n
	
	jp_f_n <= "0101"; --0101f nnnnnnnn - jp f n
	
	ld_r_n <= "10"; --10rrr nnnnnnnn - ld r, n
	
	ld_r_g <= "11"; --11rrr XXXXXggg - ld r, g
	
	cte <= rom_dado(7 downto 0); --n
	
	f <= '1' when opcode(0 downto 0) = "1" else '0'; --f
	
	reg_a <= opcode(2 downto 0) when opcode(4 downto 3) = ld_r_n or opcode(4 downto 3) = ld_r_g else
			 "001"; --a / r
			 
	reg_b <= rom_dado(2 downto 0); -- r / g
	
	
	
	jump_en <= '1' when opcode=jp_n or opcode=jp_a else
					'0';
						
	ula_sel <= "00" when opcode = add_a_n or opcode = add_a_r else
				"01" when opcode = sub_a_n or opcode = sub_a_r else
				"10";

	ula_b_sel <= '0' when opcode = add_a_r or opcode = sub_a_r or opcode(4 downto 3) = ld_r_g else
				'1';
	
	reg_wr_en <= '1' when opcode=add_a_n or opcode=add_a_r or opcode=sub_a_n or opcode=sub_a_r or opcode(4 downto 3) = ld_r_n or opcode(4 downto 3) = ld_r_g else
					'0';
	
	state <= estado;
end architecture ; -- arch