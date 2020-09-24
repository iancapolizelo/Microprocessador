-- Trabalho de Gustavo Henrique Zeni e Ianca Polizelo

  
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is 
	port( 	proc_clk : in std_logic;
			proc_state : out unsigned(1 downto 0);
			proc_rst : in std_logic;
			proc_pc: out unsigned(7 downto 0);
			proc_rom_dado: out unsigned(15 downto 0); --16 bits
			proc_reg1: out unsigned(15 downto 0);
			proc_reg2: out unsigned(15 downto 0);
			proc_ula_out: out unsigned(15 downto 0)
	);
end entity;

architecture a_processador of processador is
	component rom
		port( clk    : in std_logic;
			  endereco : in unsigned(7 downto 0);
			  dado     : out unsigned(15 downto 0) --16 bits
	);
	end component;
	
	component uc is  
	port( 	uc_clk: in std_logic;
			uc_rst : in std_logic;
			rom_dado: in unsigned(15 downto 0); --16 bits
			jump_en : out std_logic;
			cte : out unsigned(7 downto 0); -- 8 bits
			state : out unsigned(1 downto 0); --2 bits
			reg_a : out unsigned(2 downto 0); --3 bits
			reg_b : out unsigned(2 downto 0); --3 bits
			ula_sel: out unsigned(1 downto 0); --2 bits
			ula_b_sel: out std_logic;
			reg_wr_en: out std_logic
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
	
	component bancoreg
		port ( 	read_register_a : in unsigned(2 downto 0);
		  		read_register_b : in unsigned(2 downto 0);
		  		write_data : in unsigned(15 downto 0);
		  		write_register : in unsigned(2 downto 0);
		  		banco_wr_en : in std_logic;
		  		banco_clk : in std_logic;
		  		banco_rst : in std_logic;
		  		read_data_a : out unsigned(15 downto 0);
		  		read_data_b : out unsigned(15 downto 0)
			
		);
	end component;

	component ula
		port ( 	entrada1: in unsigned (15 downto 0); --a
        		entrada2: in unsigned (15 downto 0); --b
        		saida: out unsigned (15 downto 0); 	 --s
        		sel: in unsigned (1 downto 0)
			
		);
	end component;

	signal rom_dado : unsigned(15 downto 0);
	signal pc_in, pc_out, cte : unsigned(7 downto 0);
	signal jump_en, pc_wr_en : std_logic;
	signal state : unsigned(1 downto 0);
	
	signal mux, read_data_a, read_data_b, write_data : unsigned (15 downto 0);
	signal reg_a, reg_b, reg_wr : unsigned (2 downto 0);
	signal reg_wr_en: std_logic;
	signal ula_sel: unsigned(1 downto 0);
	signal ula_b_sel: std_logic;
	signal ula_b: unsigned(15 downto 0);
	signal cte_16: unsigned(15 downto 0);
begin
	rom0: rom port map( clk => proc_clk, 
						endereco => pc_out, 
						dado => rom_dado);

	uc0: uc port map ( uc_clk => proc_clk,
						uc_rst => proc_rst,
						rom_dado => rom_dado,
						jump_en => jump_en,
						cte => cte,
						state => state,
						reg_a => reg_a,
						reg_b => reg_b,
						ula_sel => ula_sel,
						ula_b_sel => ula_b_sel,
						reg_wr_en => reg_wr_en);

	pc0: pc port map ( pc_clk => proc_clk,
						pc_wr_en => pc_wr_en,
						pc_rst => proc_rst,
						data_in => pc_in,
						data_out => pc_out);
						
	banco0: bancoreg port map( 	read_register_a => reg_a,
		  						read_register_b => reg_b,
		  						write_data => write_data,
		  						write_register => reg_wr,
		  						banco_wr_en => reg_wr_en,
		  						banco_clk => proc_clk,
		  						banco_rst => proc_rst,
		  						read_data_a => read_data_a,
		  						read_data_b => read_data_b);
								
	ula0: ula port map( entrada1 => read_data_a, 
						entrada2 => ula_b, 
						saida => write_data, 
						sel => ula_sel);
	
	cte_16 <= resize(unsigned(cte), 16);
		
	pc_in <= pc_out + 1 when jump_en = '0' else
			cte when jump_en = '1' else
			pc_out;
			
	pc_wr_en <= '1' when state = "01" else
				'0';
				
	ula_b <= read_data_b when ula_b_sel = '0'
					else cte_16 when ula_b_sel = '1'
					else x"0000";			
	
	proc_state <= state;
	
	proc_pc <= pc_out;
	
	proc_rom_dado <= rom_dado;
	
	proc_reg1 <= read_data_a;
	
	proc_reg2 <= mux;
	
	proc_ula_out <= write_data;

end architecture ; -- arch