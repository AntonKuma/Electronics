-- AUTHOR: Jonathan Primeau

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity GenericRegister is
	generic ( n : integer := 8 );
	port
	(
		in_clk		: in std_logic;
		in_clr		: in std_logic;
		in_input		: in std_logic;
		in_output	: in std_logic;
		in_data		: in std_logic_vector(n-1 downto 0);
		out_data		: out std_logic_vector(n-1 downto 0)
	);
end GenericRegister;

architecture Behavioral of GenericRegister is
	signal tmp_data : std_logic_vector(n-1 downto 0);
begin
	process (in_clk, in_clr, in_input, in_output, tmp_data)
	begin
		if in_clr = '1' then
			tmp_data <= (others => '0');
		elsif in_clk'event and in_clk = '1' then
			if in_input = '1' then
				tmp_data <= in_data;
			end if;
		end if;
		if in_output = '0' then
			out_data <= (others => 'Z');
		else
			out_data <= tmp_data;
		end if;
	end process;
end Behavioral;