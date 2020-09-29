--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level_tb is
end;

architecture a_top_level_tb of top_level_tb is
	component top_level
	port( mux_sel	:	in std_logic;
		  cte		:	in unsigned(15 downto 0);
		  top_clk	:	in std_logic;
		  top_rst	:	in std_logic; 
		  top_wr_en	:	in std_logic; 
		  top_sel	:	in unsigned(1 downto 0); 
		  reg_a		:	in unsigned(2 downto 0); 
		  reg_b		:	in unsigned(2 downto 0); 
		  reg_wr	:	in unsigned(2 downto 0); 
		  debugger	:	out unsigned(15 downto 0);
		  rom_out	:	out unsigned(15 downto 0)
		);
	end component;
	
	signal mux_sel 					   : std_logic;
	signal cte						   : unsigned(15 downto 0);
	signal top_clk, top_rst, top_wr_en : std_logic;
	signal top_sel					   : unsigned(1 downto 0);
	signal reg_a, reg_b, reg_wr 	   : unsigned(2 downto 0);
	signal debugger 				   : unsigned(15 downto 0);
	signal rom_out					   : unsigned(15 downto 0);
	
begin
-- Pino com sinal
uut: top_level port map( mux_sel   => mux_sel,
						 cte       => cte,
						 top_clk   => top_clk,
						 top_rst   => top_rst,
						 top_wr_en => top_wr_en,
						 top_sel   => top_sel,
						 reg_a     => reg_a,
						 reg_b     => reg_b,
						 reg_wr    => reg_wr,
						 debugger  => debugger,
						 rom_out   => rom_out);
						 
	process
	begin --sinal do clock
		top_clk <= '0';
		wait for 50 ns;
		top_clk <= '1';
		wait for 50 ns;
	end process;
	
	process
	begin --sinal de reset
		top_rst <= '1'; --Resetando todo mundo obrigatoriamente no começo
		wait for 100 ns;
		top_rst <= '0';
		wait for 600 ns;
		top_rst <= '1';
		wait for 100 ns;
		top_rst <= '0';
		wait;
	end process;
	
	process
	begin --sinal para testar banco com ula integrada
		wait for 100 ns;
		top_sel <= "00"; -- operação de soma (addi $1, $zero, 5)
		cte <= "0000000000000101";
		mux_sel <= '1'; -- vamos somar com constante, então seleção pra cte
		top_wr_en <= '1'; --instrução de soma grava no reg_a
		reg_a <= "000"; --$zero
		reg_b <= "010";
		reg_wr <= "001"; --$1
		wait for 100 ns;
		
		cte <= "0000000000000101"; --vamos fazer addi $2, $zero, 5
		reg_wr <= "010"; --$2, outros registradores continuam sem importância
		wait for 100 ns;
		
		mux_sel <= '0'; --vamos mudar para add $1, $1, $2 (escrita, regA, regB)
		reg_a <= "001";
		reg_b <= "010";
		reg_wr <= "001";
		wait for 100 ns;
		
		-- Bom, se deu tudo certo $1=10, $1=$2=5
		-- então vamos usar uma operação sub e subi
		-- sub $1, $1, $1 (vai fazer $1-$1 e gravar no $1)
		top_sel <= "01";
		reg_a <= "001";
		reg_b <= "001";
		reg_wr <= "001";
		wait for 100 ns;
		
		--Agora vamos fazer subi $2, $zero, 5 (tbm vai zerar o $2 assim)
		mux_sel <= '1';
		cte <= "0000000000000101";
		reg_a <= "000";
		reg_wr <= "010";
		wait for 100 ns;
		
		top_wr_en <= '0';
		wait;
	end process;
	
end architecture;
		
	