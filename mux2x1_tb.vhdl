library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_tb is
end;

architecture a_mux2x1_tb of mux2x1_tb is
	component mux2x1 	-- indica que vamos usar um compomente pronto de outro arquivo. Tem que ser exatamente igual a interface definida lá
		port( enable       : in std_logic;
		      sel          : in std_logic;
		      entr0, entr1 : in std_logic;
		      saida        : out std_logic
	     );
	end component;
	
	signal enable, sel, entr0, entr1, saida : std_logic;
	begin
		uut: mux2x1 port map(enable => enable,
							 sel => sel,
							 entr0 => entr0,
							 entr1 => entr1,
							 saida => saida);
							 
		process
		begin
			enable <= '0';
			sel <= '-';
			entr0 <= '-';
			entr1 <= '-';
			saida <= '0';
			wait for 50 ns;
			enable <= '1';
			sel <= '0';
			entr0 <= '0';
			entr1 <= '-';
			saida <= '0';
			wait for 50 ns;
			enable <= '1';
			sel <= '0';
			entr0 <= '1';
			entr1 <= '-';
			saida <= '1';
			wait for 50 ns;
			enable <= '1';
			sel <= '1';
			entr0 <= '-';
			entr1 <= '0';
			saida <= '0';
			wait for 50 ns;
			enable <= '1';
			sel <= '1';
			entr0 <= '-';
			entr1 <= '1';
			saida <= '1';
			wait for 50 ns;
			wait;
		end process;
end architecture;