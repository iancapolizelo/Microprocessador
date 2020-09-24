-- Trabalho de Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is  
	port( 	
			uc_clk: in std_logic;
			uc_rst : in std_logic;
			rom_dado: in unsigned(15 downto 0);
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

	signal opcode: unsigned(3 downto 0); --4 bits de opcode
	signal estado : unsigned(1 downto 0); --3 estados
	
	signal add, addq, sub, subq, jump: unsigned (3 downto 0); --4 bits de opcode
	signal f: std_logic;
begin
	maq_estados0: maq_estados3 port map( clk => uc_clk,
		  						rst => uc_rst,
		  						estado => estado);
	
	opcode <= rom_dado(15 downto 12); -- Nossos opcodes são de 4 bits (15, 14, 13, 12);
	
	add <= "0001"; --0001 rrr010XXXrrr - add R1, R2 (add <ea>y, Dx - Source + Destination -> Destination)
	
	addq <= "0010"; --0010 nnnnnnXXXrrr - addq n, R1 (addq #<data>, Dx - Data + Destination -> Destination)
	
	sub <= "0011"; --0011 rrr010XXXrrr - sub R1, R2 (sub <ea>y, Dx - Source - Destination -> Destination)
	
	subq <= "0100"; --subq n, R1 (subq #<data>, Dx - Data - Destination -> Destination)
	
	jump <= "0101"; --0101 111011XXXrrr - jump (verificar)
	
	
	cte <= rom_dado(11 downto 6); --n
	
	f <= '1' when opcode(0 downto 0) = "1" else '0'; --f
	
	reg_a <= opcode(11 downto 9) when opcode(15 downto 12) = add or opcode(15 downto 12) = sub else
			 "000"; -- r1
			 
	reg_b <= rom_dado(2 downto 0); -- r2
	
	
	
	jump_en <= '1' when opcode=jump; --verificar jump
						
	ula_sel <= "00" when opcode = add or opcode = addq else
				"01" when opcode = sub or opcode = subq else
				"10";

	ula_b_sel <= '0' when opcode = add or opcode = sub else
				'1';
	
	reg_wr_en <= '1' when opcode=add or opcode=addq or opcode=sub or opcode=subq else
					'0';
	
	state <= estado;
end architecture ; -- arch