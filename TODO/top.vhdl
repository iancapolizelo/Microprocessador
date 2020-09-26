library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
	port(	mux_sel	:	in std_logic;
			cte		:	in unsigned(15 downto 0);
			top_clk :	in std_logic;
			top_wr_en:	in std_logic;
			top_rst	:	in std_logic;
			top_sel	:	in unsigned(1 downto 0);
			debugger:	out unsigned(15 downto 0);
			reg_a	:	in unsigned(2 downto 0);
			reg_b	:	in unsigned(2 downto 0);
			reg_wr	:	in unsigned(2 downto 0)
	);
end entity;

architecture a_top of top is
	component bancoreg
		port(	read_register_a	:	in unsigned(2 downto 0);
				read_register_b	:	in unsigned(2 downto 0);
				write_data		:	in unsigned(15 downto 0);
				write_register	:	in unsigned(2 downto 0);
				banco_wr_en		:	in std_logic;
				banco_clk		:	in std_logic;
				banco_rst		:	in std_logic;
				read_data_a		:	out unsigned(15 downto 0);
				read_data_b		:	out unsigned(15 downto 0)
		);
	end component;
	
	component ULA
		port( entr0,entr1	 					 : in unsigned(15 downto 0);   
			  selec_op		 					 : in unsigned(1 downto 0);
		      saida								 : out unsigned(15 downto 0)
		);
	end component;
	
	signal mux, read_data_a, read_data_b, write_data : unsigned(15 downto 0);
	
	begin
		banco0: bancoreg port map(	read_register_a => reg_a,
									read_register_b => reg_b,
									write_data => write_data,
									write_register => reg_wr,
									banco_wr_en => top_wr_en,
									banco_clk => top_clk,
									banco_rst => top_rst,
									read_data_a => read_data_a,
									read_data_b => read_data_b);
		ULA0: ULA port map(	entr0 => read_data_a, entr1 => mux, saida => write_data, selec_op => top_sel);
		
		mux <= read_data_b when mux_sel = '0'
			else cte when mux_sel = '1'
			else x"0000";
			
		debugger <= write_data;
		
end architecture;