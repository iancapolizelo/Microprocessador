library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
	port( enable       : in std_logic;
		  sel          : in std_logic;
		  entr0, entr1 : in std_logic;
		  saida        : out std_logic
	);
end entity;

architecture a_mux2x1 of mux2x1 is
begin
	saida <=	'0'   when enable='0' and sel='0' else
				'0'   when enable='0' and sel='1' else
				entr0 when enable='1' and sel='0' else
				entr1 when enable='1' and sel='1' else
				'0';
end architecture;