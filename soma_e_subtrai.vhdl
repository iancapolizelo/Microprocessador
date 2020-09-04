library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soma_e_subtrai is
	port(	x,y		  : in unsigned(7 downto 0);
			soma,subt : out unsigned(7 downto 0)
		);
end entity;

architecture a_soma_e_subtrai of soma_e_subtrai is
begin
	soma <= x+y;
	subt <= x-y;
end architecture;

