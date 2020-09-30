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
			pc_wr_en <= '1';
			wait for 100 ns;
			data_in <= "00000000";
			wait for 100 ns;
			data_in <= "00000001";
			wait for 100 ns;
			data_in <= "00000010";
			wait for 100 ns;
			data_in <= "00000011";
			wait for 100 ns;
			data_in <= "00000100";
			wait for 100 ns;
			data_in <= "00000101"; --5
			wait for 100 ns;
			data_in <= "00000110"; --6
			wait for 100 ns;
			data_in <= "00000111"; --7
			wait for 100 ns;
			data_in <= "00001000"; --8
			wait for 100 ns;
			data_in <= "00001001"; --9
			wait for 100 ns;
			data_in <= "00001010"; --10
			wait for 100 ns;
			data_in <= "00001011"; --11
			wait for 100 ns;
			data_in <= "00001100"; --12
			wait for 100 ns;
			data_in <= "00001101"; --13
			wait for 100 ns;
			data_in <= "00001110"; --14
			wait for 100 ns;
			data_in <= "00001111"; --15
			wait for 100 ns;
			data_in <= "00010000"; --16
			wait for 100 ns;
			data_in <= "00010001"; --17
			wait for 100 ns;
			data_in <= "00010010"; --18
			wait for 100 ns;
			data_in <= "00010011"; --19
			wait for 100 ns;
			data_in <= "00010100"; --20
			wait for 100 ns;
			data_in <= "00010101"; --21
			wait for 100 ns;
			data_in <= "00010110"; --22
			wait;
		end process;
end architecture;