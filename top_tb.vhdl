library ieee;
library ieee.std_logic_1164.all;
library ieee.numeric_std.all;

entity top_tb is
end;

architecture a_top_tb of top_tb is
	component top
	port(	mux_sel	: in std_logic;
			cte		: in unsigned(15 downto 0);
			top_clk : in std_logic;
			top_wr_en : in std_logic;
			top_rst : in std_logic;
			top_sel : in unsigned(1 downto 0);
			debugger : out unsigned (15 downto 0);
			reg_a : in unsigned (2 downto 0);
			reg_b : in unsigned (2 downto 0);
			reg_wr : in unsigned (2 downto 0)
	);
end component;

	signal cte, debugger : unsigned(15 downto 0);
	signal top_sel : unsigned(1 downto 0);
	signal reg_a, reg_b, reg_wr : unsigned(2 downto 0);
	signal mux_sel, top_clk, top_wr_en, top_rst : std_logic;
	
	begin
	uut: top port map ( mux_sel => mux_sel,
					    cte => cte,
					    top_clk => top_clk,
					    top_wr_en => top_wr_en,
					    top_rst => top_rst,
					    top_sel => top_sel,
					    debugger => debugger,
					    reg_a => reg_a,
					    reg_b => reg_b,
					    reg_wr => reg_wr);
	process
	begin
		top_clk <= '0';
		wait for 50 ns;
		top_clk <= '1';
		wait for 50 ns;
	end process;

	process -- sinal de reset
	begin
		top_rst <= '1';
		wait for 100 ns;
		top_rst <= '0';
		wait;
	end process;

	process
	begin
		wait for 100 ns;
		top_sel <= "00";   --addi $1, $zero, 4
		cte <= x"0004";
		mux_sel <= '1';
		top_wr_en <= '1';
		reg_a <= "000";
		reg_b <= "010";
		reg_wr <= "001";
		wait for 100 ns;

		cte <= x"0003";   --addi $2, $zero, 3
		reg_wr <= "010";
		wait for 100 ns;

		mux_sel <= '0';  --add $1, $1, $2
		reg_a <= "001";
		reg_b <= "010";
		reg_wr <= "001";
		wait for 100 ns;

		top_wr_en <= '0';
		wait;
	end process;

end architecture; 