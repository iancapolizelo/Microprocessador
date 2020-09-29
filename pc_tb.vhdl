library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end;

architecture a_pc_tb of pc_tb is
	component pc
		port( pc_clk	: in std_logic;
			  pc_rst	: in std_logic;
			  pc_wr_en : in std_logic;
			  data_in : in unsigned(7 downto 0);
			  data_out : out unsigned(7 downto 0)
			  );
	end component;
	signal pc_clk, pc_rst, pc_wr_en : std_logic;
	signal data_in, data_out : unsigned(7 downto 0);
	
	begin
		uut: pc port map(pc_clk => pc_clk,
						 pc_rst => pc_rst,
						 pc_wr_en => pc_wr_en,
						 data_in => data_in,
						 data_out => data_out);
		
		process -- sinal de clock
		begin
			pc_clk <= '0';
			wait for 50 ns;
			pc_clk <= '1';
			wait for 50 ns;
		end process;
		
		process -- sinal de reset
		begin
			pc_rst <= '1';
			wait for 100 ns;
			pc_rst <= '0';
			wait;
		end process;
		
		process -- sinais dos casos de teste
		begin
			pc_wr_en <= '0';
			wait for 100 ns;
			data_in <= "11111111";
			wait for 100 ns;
			pc_wr_en <= '1';
			data_in <= "10101010";
			wait for 100 ns;
			pc_wr_en <= '1';
			data_in <= "00000000";
			wait for 100 ns;
			pc_wr_en <= '0';
			data_in <= "00000001";
			wait for 100 ns;
			pc_wr_en <= '0';
			data_in <= "10001001";
			wait for 100 ns;
			pc_wr_en <= '1';
			data_in <= "11111111";
			wait;
		end process;
end architecture;