-- AUTHOR: Jonathan Primeau

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity RAM is
	port
	(
		in_read		: in std_logic;
		in_write		: in std_logic;
		in_output	: in std_logic;
		in_addr		: in std_logic_vector(3 downto 0);
		in_data		: in std_logic_vector(7 downto 0);
		out_data		: out std_logic_vector(7 downto 0)
	);
end RAM;

architecture Behavioral of RAM is
	type ram is array (0 to 15) of std_logic_vector(7 downto 0);
	signal memory : ram;
	signal tmp_data : std_logic_vector(7 downto 0);
begin
	memory <= (
			0 => "00001001" ,  -- LDA 9h
			1 => "11101111" ,  -- OUT
			2 => "00011010" ,  -- ADD Ah
			3 => "11101111" ,  -- OUT
			4 => "00011011" ,  -- ADD Bh
			5 => "00101100" ,  -- SUB Ch
			6 => "11101111" ,  -- OUT
			7 => "11111111" ,  -- HLT 
			8 => "11111111" ,
			9 => "00000101" ,  --5
			10=> "00000111" ,  --7
			11=> "00000011" ,  --3
			12=> "00000100" ,  --4
			13=> "11111111" , 
			14=> "11111111" , 
			15=> "11111111" );
				
	process (in_read, in_output, in_addr, memory, tmp_data)
	begin
		if in_read = '1' then
			tmp_data <= memory(conv_integer(in_addr));
		end if;
		if in_output = '0' then
			out_data <= (others => 'Z');
		else
			out_data <= tmp_data;
		end if;
	end process;
--	process (in_write)
--	begin
--		if in_write = '1' then
--			memory(conv_integer(in_addr)) <= in_data;
--		end if;
--	end process;
end Behavioral;