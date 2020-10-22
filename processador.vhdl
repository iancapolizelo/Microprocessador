--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
	port( proc_clk		:	in std_logic;
		  proc_rst		:	in std_logic;
		  proc_state 	:	out unsigned(1 downto 0);
		  proc_pc		:	out unsigned(7 downto 0);
		  proc_rom_dado :	out unsigned(15 downto 0);
		  proc_reg1		:	out unsigned(15 downto 0);
		  proc_reg2		:	out unsigned(15 downto 0);
		  proc_ula_out	:	out unsigned(15 downto 0);
		  proc_n_primos	:	out unsigned(15 downto 0)
	);
end entity;

architecture a_processador of processador is

-----Aqui ficam os componentes do processador:
	
	component bancoreg
		port( read_register_a	:	in unsigned(2 downto 0);
			  read_register_b	:	in unsigned(2 downto 0);
			  write_data		:	in unsigned(15 downto 0);
			  write_register	:	in unsigned(2 downto 0);
			  banco_wr_en		:	in std_logic;
			  banco_clk			:	in std_logic;
			  banco_rst			:	in std_logic;
			  read_data_a		:	out unsigned(15 downto 0);
			  read_data_b		:	out unsigned(15 downto 0)
		  );
	end component;
	
	component ULA
		port( entr0,entr1	: in unsigned(15 downto 0);
			  selec_op		: in unsigned(1 downto 0);
			  saida			: out unsigned(15 downto 0);
			  z				: out std_logic;
			  c				: out std_logic
			);
	end component;
	
	component pc
		port( pc_clk	   : in std_logic;
			  pc_rst	   : in std_logic;
			  pc_wr_en    : in std_logic;
			  data_in  : in unsigned(7 downto 0);
			  data_out : out unsigned(7 downto 0)
			);
	end component;
	
	component rom
		port(rom_clk		:	in std_logic;
			 rom_endereco	:	in unsigned(7 downto 0);
			 rom_dado		:	out unsigned(15 downto 0)
			);
	end component;
	
	component uc
		port(uc_clk	:	in std_logic;
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
			  jump_r_flag 	:	out std_logic;
			  ram_wr_en	:	out std_logic;
			  acess_ram	:	out std_logic
			);
	end component;
	
	component ram
		port(clk		:	in std_logic;
			 endereco	:	in unsigned(7 downto 0);
			 wr_en		:	in std_logic;
			 dado_in	:	in unsigned(15 downto 0);
			 dado_out	:	out unsigned(15 downto 0)
			);
	end component;
	
----Aqui ficam os sinais do processador:
	
	signal read_data_a, read_data_b, write_data : unsigned(15 downto 0);
	signal reg_a, reg_b : unsigned(2 downto 0);
	signal reg_wr_en, uc_reg_wr_en : std_logic;
	signal ula_sel : unsigned(1 downto 0);
	signal ula_b_sel, ula_a_sel : std_logic;
	signal ula_b, ula_a : unsigned(15 downto 0);
	signal cte_16 : unsigned(15 downto 0);
	
	signal pc_wr_en, jump_en : std_logic;
	signal pc_in, pc_out, cte, jump_addr : unsigned(7 downto 0);
	signal rom_dado : unsigned(15 downto 0);
	signal state : unsigned(1 downto 0);
	
	signal z, c, jump_r : std_logic;
	
	signal acess_ram, ram_wr_en : std_logic;
	signal ram_addr : unsigned(7 downto 0);
	signal ram_in, ram_out : unsigned(15 downto 0);
	
begin --architecture

----Aqui estão as ligações entre os componentes do processador:

	banco0: bancoreg port map( read_register_a => reg_a,
							   read_register_b => reg_b,
							   write_data => write_data,
							   write_register => reg_a, --Os dados sempre serão escritos no reg_a
							   banco_wr_en => reg_wr_en,
							   banco_clk => proc_clk,
							   banco_rst => proc_rst,
							   read_data_a => read_data_a,
							   read_data_b => read_data_b); 
		
	
		

	ula0: ULA port map( entr0 => ula_a,
						entr1 => ula_b,
						saida => write_data,
						selec_op => ula_sel,
						z => z,
						c => c);
	
	pc0: pc port map(pc_clk => proc_clk,
					 pc_rst => proc_rst,
					 pc_wr_en => pc_wr_en,
					 data_in => pc_in, 
					 data_out => pc_out);
					 
	rom0: rom port map(rom_clk => proc_clk,
					   rom_endereco => pc_out,
					   rom_dado => rom_dado);
					   
	uc0: uc port map(uc_clk => proc_clk,
					 uc_rst => proc_rst,
					 rom_dado => rom_dado,
					 jump_en => jump_en,
					 cte => cte,
					 state => state,
					 reg_a => reg_a,
					 reg_b => reg_b,
					 ula_sel => ula_sel,
					 ula_a_sel => ula_a_sel,
					 ula_b_sel => ula_b_sel,
					 reg_wr_en => uc_reg_wr_en,
					 z_in => z,
					 c_in => c,
					 jump_r_flag => jump_r,
					 ram_wr_en => ram_wr_en,
					 acess_ram => acess_ram);
					 
	ram0 : ram port map(clk => proc_clk,
						endereco => ram_addr,
						wr_en => ram_wr_en,
						dado_in => ram_in,
						dado_out => ram_out);
					 
----Aqui estão algumas operações realizados pelo processador pra tudo funcionar:					 
					 
	cte_16 <= x"FF" & cte when cte(7) = '1' else
			  x"00" & cte; --cte de 8 bits para 16
	
			
	pc_in <= pc_out + 1 when jump_en = '0' else --Contagem do PC
			 jump_addr;
			 
	jump_addr <= write_data(7 downto 0) when jump_r = '1' else
				 cte;
			 
	pc_wr_en <= '1' when state = "01" else --libera pra escrever no estado 1: decode/execute 
				'0';
				
	reg_wr_en <= uc_reg_wr_en when state = "01" else --libera pra escrever no registrador no estado 1
				'0';
				
	ula_b <= read_data_b when ula_b_sel = '0' else --Seleção para reg_b
			cte_16 when ula_b_sel = '1' and acess_ram = '0' else
			ram_out when ula_b_sel = '1' and acess_ram = '1' else
			"0000000000000000";
			
	ula_a <= read_data_a when ula_a_sel = '0' else
			 x"00" & pc_out when ula_a_sel = '1' else
			 x"0000";
			 
	ram_addr <= read_data_b(7 downto 0);
	
	ram_in <= read_data_a;
			
	proc_state <= state;
	
	proc_pc <= pc_out;
	
	proc_rom_dado <= rom_dado;
	
	proc_reg1 <= read_data_a;
	
	proc_reg2 <= read_data_b;
			
	proc_ula_out <= write_data;
	
	proc_n_primos <= read_data_b when reg_b = "110" else
					 read_data_a when reg_a = "110" else
					 "0000000000000000";
	
end architecture;
						
	
	