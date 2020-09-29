--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Agora o professor pediu pra mudar o nome do arquivo de top_level pra processador
--E também falou quais pinos podem estar visíveis agora
entity processador is
	port( proc_clk		:	in std_logic;
		  proc_rst		:	in std_logic;
		  proc_state 	:	out unsigned(1 downto 0);
		  proc_pc		:	out unsigned(7 downto 0);
		  proc_rom_dado :	out unsigned(15 downto 0);
		  proc_reg1		:	out unsigned(15 downto 0);
		  proc_reg2		:	out unsigned(15 downto 0);
		  proc_ula_out	:	out unsigned(15 downto 0)
	);
end entity;

architecture a_processador of processador is

	component bancoreg --Temos que colocar o banco de registradores aqui pra poder ligar na ULA
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
	
	component ULA --E aqui temos que colocar a ULA pra poder ligar com o banco
		port( entr0,entr1	 	: in unsigned(15 downto 0);
			  selec_op  		: in unsigned(1 downto 0);
			  saida				: out unsigned(15 downto 0)
			);
	end component;
	
	component pc --Agora vamos ligar o PC na rom. Basta ligar a saída do PC direto na entrada de endereços da rom
		port( pc_clk	   : in std_logic;
			  pc_rst	   : in std_logic;
			  pc_wr_en    : in std_logic; -- clock enable
			  data_in  : in unsigned(7 downto 0);
			  data_out : out unsigned(7 downto 0) --essa é a saída do pc
			);
	end component;
	
	component rom
		port(rom_clk		:	in std_logic;
			 rom_endereco	:	in unsigned(7 downto 0);
			 rom_dado		:	out unsigned(15 downto 0) --essa é a saída da rom
			);
	end component;
	
	component uc
		port(uc_clk		:	in std_logic;
			 uc_rst		:	in std_logic;
			 rom_dado	:	in unsigned(15 downto 0);
			 jump_en	:	out std_logic; 
			 cte		:	out unsigned(7 downto 0);
			 state		:	out unsigned(1 downto 0); 
			 reg_a		:	out unsigned(2 downto 0);
			 reg_b		:	out unsigned(2 downto 0);
			 ula_sel	:	out unsigned(1 downto 0);
			 ula_b_sel	:	out std_logic;
			 reg_wr_en	:	out std_logic
			);
	end component;
	
	signal read_data_a, read_data_b, write_data : unsigned(15 downto 0);
	signal reg_a, reg_b : unsigned(2 downto 0);
	signal reg_wr_en, uc_reg_wr_en : std_logic;
	signal ula_sel : unsigned(1 downto 0);
	signal ula_b_sel : std_logic;
	signal ula_b : unsigned(15 downto 0);
	signal cte_16 : unsigned(15 downto 0);
	
	signal pc_wr_en, jump_en : std_logic;
	signal pc_in, pc_out, cte : unsigned(7 downto 0);
	signal rom_dado : unsigned(15 downto 0);
	signal state : unsigned(1 downto 0);
	
begin --architecture
	--Aqui estamos criando um banco de registradores e fazendo as ligações com os pinos do top_level
	banco0: bancoreg port map( read_register_a => reg_a, --o read_register_a do banco está ligado no reg_a do top
							   read_register_b => reg_b, --o read_register_b do banco está ligado no reg_b do top
							   write_data => write_data, --aqui o write_data do banco está sendo ligado no sinal write_data
							   write_register => reg_a, --write_register do banco no sinal write_register
							   banco_wr_en => reg_wr_en, --wr_en do banco ligado no wr_en do top geral
							   banco_clk => proc_clk, --clk do banco no clk do top geral
							   banco_rst => proc_rst, --rst do banco no rst do top geral
							   read_data_a => read_data_a, --read_data_a do banco ligado no sinal do top
							   read_data_b => read_data_b); --read_data_b do banco ligado no sinal do top
		
	--Aqui estamos criando uma ULA, que até agora é necessário apenas uma ULA para as contas
	ula0: ULA port map( entr0 => read_data_a, --aqui estamos ligando a entrada0 da ULA no sinal read_data_a do top, que está ligado no read_data_a do banco
											  --levando assim, read_data_a do bando com entr0 da ula0
						entr1 => ula_b, --aqui estamos ligando a entr1 da ULA no sinal de mux do top, que irá fazer a seleção entre read_data_b ou cte
						saida => write_data, --ligando saida da ULA na entrada de dados do banco
						selec_op => ula_sel); --e ligando a selec_op da ULA no sel do top
	
	pc0: pc port map(pc_clk => proc_clk,
					 pc_rst => proc_rst,
					 pc_wr_en => pc_wr_en,
					 data_in => pc_in, 
					 data_out => pc_out); --ligando a saída do pc ao sinal pc_out, que vai ser ligado no rom_endereço
					 
	rom0: rom port map(rom_clk => proc_clk,
					   rom_endereco => pc_out, --ligando endereço da rom em pc_out, que tá ligado com saída do pc
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
					 ula_b_sel => ula_b_sel,
					 reg_wr_en => uc_reg_wr_en);
					 
	cte_16 <= resize(unsigned(cte), 16); --cte estendido
			
	pc_in <= pc_out + 1 when jump_en = '0' else
			 cte when jump_en = '1' else
			 pc_out;
			 
	pc_wr_en <= '1' when state = "01" else
				'0';
				
	reg_wr_en <= uc_reg_wr_en when state = "01" else
				'0';
				
	--Agora temos que fazer o mux do top selecionar entre read_data_b ou cte
	ula_b <= read_data_b when ula_b_sel = '0' else
			cte_16 when ula_b_sel = '1' else
			"0000000000000000";
			
	proc_state <= state;
	
	proc_pc <= pc_out;
	
	proc_rom_dado <= rom_dado;
	
	proc_reg1 <= read_data_a;
	
	proc_reg2 <= ula_b;
			
	--Agora temos que ligar a saída do top na estrada do banco de dados
	proc_ula_out <= write_data;
	
end architecture;
						
	
	