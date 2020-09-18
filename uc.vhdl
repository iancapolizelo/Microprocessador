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

	signal opcode: unsigned(3 downto 0);
	signal estado : unsigned(1 downto 0);
	
	signal add, addq, sub, subq, jump: unsigned (3 downto 0);
	signal f: std_logic;
begin
	maq_estados0: maq_estados3 port map( clk => uc_clk,
		  						rst => uc_rst,
		  						estado => estado);
	
	opcode <= rom_dado(15 downto 11);
	
	add <= "1101"; --1101 rrr010XXXrrr - add (add <ea>y, Dx)
	
	addq <= "0101"; --0101 nnn010XXXrrr - addq (#<data>, Dx)
	
	sub <= "1001"; --1001 rrr010XXXrrr - sub (sub <ea>y, Dx)
	
	subq <= "0101"; --0101 nnn110XXXrrr - subq (#<data>, Dx)
	
	jump <= "0100"; --0100 111011XXXrrr - jump (<ea>y)
	
	
	cte <= rom_dado(7 downto 0); --n
	
	f <= '1' when opcode(0 downto 0) = "1" else '0'; --f
	
	reg_a <= opcode(2 downto 0) when opcode(4 downto 3) = addq or opcode(4 downto 3) = addq else
			 "001"; --a / r
			 
	reg_b <= rom_dado(2 downto 0); -- r / g
	
	
	
	jump_en <= '1' when opcode=jump;
						
	ula_sel <= "00" when opcode = addq or opcode = add else
				"01" when opcode = subq or opcode = sub else
				"10";

	ula_b_sel <= '0' when opcode = add or opcode = sub or opcode(4 downto 3) = addq else
				'1';
	
	reg_wr_en <= '1' when opcode=addq or opcode=add or opcode=subq or opcode=sub or opcode(4 downto 3) = addq else
					'0';
	
	state <= estado;
end architecture ; -- arch