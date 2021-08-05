-- AUTHOR: Jonathan Primeau

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ArithmeticLogicUnit is
	generic ( n : natural := 8 );
	port
	(
		in_a			: in std_logic_vector(n-1 downto 0);
		in_b			: in std_logic_vector(n-1 downto 0);
		in_sub		: in std_logic;
		in_output 	: in std_logic;
		out_data		: out std_logic_vector(n-1 downto 0)
	);
end ArithmeticLogicUnit;

architecture Behavioral of ArithmeticLogicUnit is
begin
	process (in_a, in_b, in_sub, in_output)
	begin
		if in_output = '0' then
			out_data <= (others => 'Z');
		else
			if in_sub = '0' then
				out_data <= unsigned(in_a) + unsigned(in_b);
			else
				out_data <= unsigned(in_a) - unsigned(in_b);
			end if;
		end if;
	end process;
end Behavioral;