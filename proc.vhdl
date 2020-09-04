-- Trabalho de Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity proc is 
	port( 	proc_clk : in std_logic;
			proc_wr_en : in std_logic;
			proc_rst : in std_logic;
			proc_en : in std_logic
	);
end entity;

architecture a_proc of proc is
	component rom
		port( clk    : in std_logic;
			  endereco : in unsigned(7 downto 0);
			  dado     : out unsigned(12 downto 0)
	);
	end component;
	
	component uc is  
	port( 	uc_clk: in std_logic;
			uc_rst : in std_logic;
			uc_en : in std_logic;
			rom_dado: in unsigned(12 downto 0);
			jump_en : out std_logic;
			jump_addr : out unsigned(7 downto 0);
			state : out std_logic
	);
	end component;
	
	component pc
		port(  pc_clk : in std_logic;
		    pc_rst : in std_logic;
		    pc_wr_en : in std_logic;
		    data_in : in unsigned(7 downto 0);
		    data_out : out unsigned(7 downto 0)
	);
	end component;
	
	

	signal rom_dado : unsigned(12 downto 0);
	signal pc_in, pc_out, jump_addr : unsigned(7 downto 0); --VERIFICAR PINOS!!!!!!!!!!!
	signal jump_en, state, pc_wr_en : std_logic;
	
begin
	rom0: rom port map( clk => proc_clk, 
						endereco => pc_out, 
						dado => rom_dado);

	uc0: uc port map ( uc_clk => proc_clk,
						uc_rst => proc_rst,
						uc_en => proc_en,
						rom_dado => rom_dado,
						jump_en => jump_en,
						jump_addr => jump_addr,
						state => state);

	pc0: pc port map ( pc_clk => proc_clk,
						pc_wr_en => pc_wr_en,
						pc_rst => proc_rst,
						data_in => pc_in,
						data_out => pc_out);
						
	
						
	pc_in <= pc_out + 1 when jump_en = '0' else
			jump_addr when jump_en = '1' else
			pc_out;
			
	pc_wr_en <= state;

end architecture ; -- arch