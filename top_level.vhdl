--Trabalho realizado por: Gustavo Henrique Zeni e Ianca Polizelo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
	port( mux_sel	:	in std_logic; --Aqui o pino de seleção de vai ser read_data_b ou cte
		  cte		:	in unsigned(15 downto 0); -- Uma constante externa
		  top_clk	:	in std_logic; -- clock geral que vai ligar tudo
		  top_rst	:	in std_logic; -- reset geral que vai ligar tudo
		  top_en	:	in std_logic;
		  top_wr_en	:	in std_logic; -- wr_en geral que vai ligar tudo
		  top_sel	:	in unsigned(1 downto 0); -- pino pra ligar na seleção da ula
		  reg_a		:	in unsigned(2 downto 0); -- registrador A
		  reg_b		:	in unsigned(2 downto 0); -- registrador B
		  reg_wr	:	in unsigned(2 downto 0); -- registrador em que será escrito
		  debugger	:	out unsigned(15 downto 0); -- pino de saída do top ligado na saída da ULA para debuggar
		  rom_out	:	out unsigned(15 downto 0) --pino para aparecer a saída da rom no top
	);
end entity;

architecture a_top_level of top_level is
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
		port(uc_clk	:	in std_logic;
			 uc_rst	:	in std_logic;
			 uc_en		:	in std_logic;
			 rom_dado	:	in unsigned(15 downto 0);
			 jump_en	:	out std_logic;
			 jump_addr	:	out unsigned(7 downto 0);
			 state		:	out std_logic
			);
	end component;
	
	signal mux, read_data_a, read_data_b, write_data : unsigned(15 downto 0);
	
	signal pc_wr_en, jump_en, state : std_logic;
	signal pc_in, pc_out, jump_addr : unsigned(7 downto 0);
	signal rom_clk : std_logic;
	signal rom_dado : unsigned(15 downto 0);
	
begin --architecture
	--Aqui estamos criando um banco de registradores e fazendo as ligações com os pinos do top_level
	banco0: bancoreg port map( read_register_a => reg_a, --o read_register_a do banco está ligado no reg_a do top
							   read_register_b => reg_b, --o read_register_b do banco está ligado no reg_b do top
							   write_data => write_data, --aqui o write_data do banco está sendo ligado no sinal write_data
							   write_register => reg_wr, --write_register do banco no sinal write_register
							   banco_wr_en => top_wr_en, --wr_en do banco ligado no wr_en do top geral
							   banco_clk => top_clk, --clk do banco no clk do top geral
							   banco_rst => top_rst, --rst do banco no rst do top geral
							   read_data_a => read_data_a, --read_data_a do banco ligado no sinal do top
							   read_data_b => read_data_b); --read_data_b do banco ligado no sinal do top
		
	--Aqui estamos criando uma ULA, que até agora é necessário apenas uma ULA para as contas
	ula0: ULA port map( entr0 => read_data_a, --aqui estamos ligando a entrada0 da ULA no sinal read_data_a do top, que está ligado no read_data_a do banco
											  --levando assim, read_data_a do bando com entr0 da ula0
						entr1 => mux, --aqui estamos ligando a entr1 da ULA no sinal de mux do top, que irá fazer a seleção entre read_data_b ou cte
						saida => write_data, --ligando saida da ULA na entrada de dados do banco
						selec_op => top_sel); --e ligando a selec_op da ULA no sel do top
	
	pc0: pc port map(pc_clk => top_clk,
					 pc_rst => top_rst,
					 pc_wr_en => pc_wr_en,
					 data_in => pc_in, 
					 data_out => pc_out); --ligando a saída do pc ao sinal pc_out, que vai ser ligado no rom_endereço
					 
	rom0: rom port map(rom_clk => top_clk,
					   rom_endereco => pc_out, --ligando endereço da rom em pc_out, que tá ligado com saída do pc
					   rom_dado => rom_dado);
					   
	uc0: uc port map(uc_clk => top_clk,
					 uc_rst => top_rst,
					 uc_en => top_en,
					 rom_dado => rom_dado,
					 jump_en => jump_en,
					 jump_addr => jump_addr,
					 state => state);
						
	--Agora temos que fazer o mux do top selecionar entre read_data_b ou cte
	mux <= read_data_b when mux_sel = '0' else
			cte when mux_sel = '1' else
			"0000000000000000";
			
	pc_in <= pc_out + 1 when jump_en = '0' else
			 jump_addr when jump_en = '1' else
			 pc_out;
			 
	pc_wr_en <= state;
			
	--Agora temos que ligar a saída do top na estrada do banco de dados
	debugger <= write_data;
	
	rom_out <= rom_dado;

end architecture;
						
	
	