library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoreg is
-- || Entradas ||
-- Seleção de quais registradores serão lidos (2 barramentos) 
	port( read_register_a	:	in unsigned(2 downto 0); -- arrumado, era: (3 downto 0 )
		  read_register_b	:	in unsigned(2 downto 0); -- arrumado, era: (3 downto 0 )
-- Barramento de dados para escrita (o valor a ser escrito) 
		  write_data		:	in unsigned(15 downto 0);
-- Seleção de qual registrador será escrito
		  write_register	:	in unsigned(2 downto 0); -- arrumado, era: (3 downto 0 )
-- write enable para habilitar a escrita apenas no momento correto
-- (é o clock enable dos registradores)
		  banco_wr_en		:	in std_logic;
-- clk (é o clock geral do processador)
		  banco_clk			:	in std_logic;
-- rst (reset, zera todos os registradores)
		  banco_rst			:	in std_logic;
-- || Saídas ||
-- Barramentos com os dados dos registradores lidos (2 barramentos)
		  read_data_a		:	out unsigned(15 downto 0);
		  read_data_b		:	out unsigned(15 downto 0)
	);
end entity;

-- Especificações adicionais:
-- - Faça oito registradores de 16 bits cada;
-- - O registrador zero possui a constante zero e não pode ser alterado.

architecture a_bancoreg of bancoreg is
	component reg16bits
	port( clk	  :	in std_logic;
		  rst	  :	in std_logic;
		  wr_en	  :	in std_logic;
		  data_in :	in unsigned(15 downto 0);
		  data_out:	out unsigned(15 downto 0)
	);
	end component;
	signal wr_en0, wr_en1, wr_en2, wr_en3, wr_en4, wr_en5, wr_en6, wr_en7: std_logic;
	signal data_out0, data_out1, data_out2, data_out3, data_out4, data_out5, data_out6, data_out7: unsigned(15 downto 0);
-- conferido (Zeni)
	begin
	reg0: reg16bits port map( clk => banco_clk, rst => banco_rst, wr_en => wr_en0, data_in => write_data, data_out => data_out0);
	reg1: reg16bits port map( clk => banco_clk, rst => banco_rst, wr_en => wr_en1, data_in => write_data, data_out => data_out1);
	reg2: reg16bits port map( clk => banco_clk, rst => banco_rst, wr_en => wr_en2, data_in => write_data, data_out => data_out2);
	reg3: reg16bits port map( clk => banco_clk, rst => banco_rst, wr_en => wr_en3, data_in => write_data, data_out => data_out3);
	reg4: reg16bits port map( clk => banco_clk, rst => banco_rst, wr_en => wr_en4, data_in => write_data, data_out => data_out4);
	reg5: reg16bits port map( clk => banco_clk, rst => banco_rst, wr_en => wr_en5, data_in => write_data, data_out => data_out5);
	reg6: reg16bits port map( clk => banco_clk, rst => banco_rst, wr_en => wr_en6, data_in => write_data, data_out => data_out6);
	reg7: reg16bits port map( clk => banco_clk, rst => banco_rst, wr_en => wr_en7, data_in => write_data, data_out => data_out7);
-- conferido (Zeni)	
	wr_en0 <= '0';
	wr_en1 <= banco_wr_en when write_register = "001" else '0';
	wr_en2 <= banco_wr_en when write_register = "010" else '0';
	wr_en3 <= banco_wr_en when write_register = "011" else '0';
	wr_en4 <= banco_wr_en when write_register = "100" else '0';
	wr_en5 <= banco_wr_en when write_register = "101" else '0';
	wr_en6 <= banco_wr_en when write_register = "110" else '0';
	wr_en7 <= banco_wr_en when write_register = "111" else '0';
-- conferido (Zeni)				
	read_data_a <= data_out0 when read_register_a = "000"
					else data_out1 when read_register_a = "001"
					else data_out2 when read_register_a = "010"
					else data_out3 when read_register_a = "011"
					else data_out4 when read_register_a = "100"
					else data_out5 when read_register_a = "101"
					else data_out6 when read_register_a = "110"
					else data_out7 when read_register_a = "111"
					else x"0000";
-- conferido (Zeni)		
	read_data_b <= data_out0 when read_register_b = "000"
					else data_out1 when read_register_b = "001"
					else data_out2 when read_register_b = "010"
					else data_out3 when read_register_b = "011"
					else data_out4 when read_register_b = "100"
					else data_out5 when read_register_b = "101"
					else data_out6 when read_register_b = "110"
					else data_out7 when read_register_b = "111"
					else x"0000";
-- conferido (Zeni)	
end architecture;