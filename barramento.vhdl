library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Esse barramento é para um mux4x1 de largura de 8 bits. Mas dá pra usar de exemplo ai pros outros

-- dá pra ver que são 4 entradas (do mux) com unsigned com 8 valores (8bits)
entity barramento is
	port(	entr0 : in unsigned(7 downto 0);
			entr1 : in unsigned(7 downto 0);
			entr2 : in unsigned(7 downto 0);
			entr3 : in unsigned(7 downto 0);
			sel   : in unsigned(1 downto 0); --bits de seleção num só bus
			saida : out unsigned(7 downto 0)
		);
end entity;

architecture a_barramento of barramento is
begin
	saida <=	entr0 when sel="00" else
				entr1 when sel="01" else
				entr2 when sel="10" else
				entr3 when sel="11" else
				"00000000";
end architecture;