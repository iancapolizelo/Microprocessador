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
			wait for 100 ns;
			data_in <= "00010111"; --23
			wait for 100 ns;
			data_in <= "00011000"; --24
			wait for 100 ns;
			data_in <= "00011001"; --25
			wait for 100 ns;
			data_in <= "00011010"; --26
			wait for 100 ns;
			data_in <= "00011011"; --27
			wait for 100 ns;
			data_in <= "00011100"; --28
			wait for 100 ns;
			data_in <= "00011101"; --29
			wait for 100 ns;
			data_in <= "00011110"; --30
			wait for 100 ns;
			data_in <= "00011111"; --31
			wait for 100 ns;
			data_in <= "00100000"; --32
			wait for 100 ns;
			data_in <= "00100001"; --33
			wait for 100 ns;
			data_in <= "00100010"; --34
			wait for 100 ns;
			data_in <= "00100011"; --35
			wait for 100 ns;
			data_in <= "00100100"; --36
			wait for 100 ns;
			data_in <= "00100101"; --37
			wait for 100 ns;
			data_in <= "00100110"; --38
			wait for 100 ns;
			data_in <= "00100111"; --39
			wait for 100 ns;
			data_in <= "00101000"; --40
			wait for 100 ns;
			data_in <= "00101001"; --41
			wait for 100 ns;
			data_in <= "00101010"; --42
			wait for 100 ns;
			data_in <= "00101011"; --43
			wait for 100 ns;
			data_in <= "00101100"; --44
			wait for 100 ns;
			data_in <= "00101101"; --45
			wait for 100 ns;
			data_in <= "00101110"; --46
			wait;
		end process;
end architecture;