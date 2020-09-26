library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoreg_tb is
end;

architecture a_bancoreg_tb of bancoreg_tb is 
	component bancoreg 
		port( read_register_a	:	in unsigned(2 downto 0); 
			read_register_b		:	in unsigned(2 downto 0); 
			write_data			:	in unsigned(15 downto 0);
			write_register		:	in unsigned(2 downto 0); 
			banco_wr_en			:	in std_logic;
			banco_clk			:	in std_logic;
			banco_rst			:	in std_logic;
			read_data_a			:	out unsigned(15 downto 0);
			read_data_b			:	out unsigned(15 downto 0)
			);
	end component;
	signal read_register_a, read_register_b : unsigned(2 downto 0);
	signal write_data : unsigned(15 downto 0);
	signal write_register : unsigned(2 downto 0);
	signal banco_wr_en, banco_clk, banco_rst : std_logic;
	signal read_data_a, read_data_b : unsigned(15 downto 0);
	
-- uut: ligando o pino => no sinal
	begin 
		uut: bancoreg port map (read_register_a => read_register_a,
								read_register_b => read_register_b, 
								write_data		=> write_data,
								write_register	=> write_register, 
								banco_wr_en		=> banco_wr_en,
								banco_clk		=> banco_clk,
								banco_rst 		=> banco_rst,
								read_data_a		=> read_data_a,
								read_data_b		=> read_data_b);
		
		process -- sinal de clock
		begin 
			banco_clk <= '0';
			wait for 50 ns;
			banco_clk <= '1';
			wait for 50 ns;
		end process;
		
		process -- sinal de reset
		begin 
			banco_rst <= '1';
			wait for 100 ns;
			banco_rst <= '0';
			wait for 600 ns;
			banco_rst <= '1';
			wait for 100 ns;
			banco_rst <= '0';
			wait;
		end process;
		
		
		process -- sinal de teste
		begin 
			banco_wr_en <= '0';
			wait for 100 ns;
			banco_wr_en <= '1';
			write_register <= "001";
			write_data <= "0000000000000011";
			wait for 100 ns;
			banco_wr_en <= '0';
			read_register_a <= "001";
			read_register_b <= "011";
			wait for 100 ns;
			banco_wr_en <= '1';
			write_register <= "010";
			write_data <= "0000000000111110";
			wait for 100 ns;
			banco_wr_en <= '0';
			read_register_a <= "001";
			read_register_b <= "010";
			wait;
		end process;
end architecture;
