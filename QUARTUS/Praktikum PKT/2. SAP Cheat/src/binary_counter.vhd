-- AUTHOR: Jonathan Primeau

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BinaryCounter is
	generic ( n : natural := 4 );
	port
	(
		in_clk		: in std_logic;
		in_clr		: in std_logic;
		in_count		: in std_logic;
		in_output	: in std_logic;
		out_data		: out std_logic_vector(n-1 downto 0)
	);
end BinaryCounter;

architecture Behavioral of BinaryCounter is
	signal tmp_data : std_logic_vector(n-1 downto 0);
begin
	process (in_clk, in_clr, in_output, in_count, tmp_data)
	begin
		if in_clr = '1' then
			tmp_data <= (others => '0');
		elsif in_clk'event and in_clk='0' then
			if in_count = '1' then
				tmp_data <= tmp_data + 1;
			end if;
		end if;
		if in_output = '0' then
			out_data <= (others => 'Z');
		else
			out_data <= tmp_data;
		end if;
	end process;
end Behavioral;