-- AUTHOR: Jonathan Primeau

library ieee;
use ieee.std_logic_1164.all;
 
entity SevenSegDecoder is
	port
	(
		in_bdc	: in std_logic_vector(3 downto 0);
		out_hex	: out std_logic_vector(6 downto 0)
	);
end SevenSegDecoder;
 
architecture Behavioral of SevenSegDecoder is
begin
	process(in_bdc)
	begin
		case in_bdc is
			when "0000" => out_hex <= "1000000"; -- 0
			when "0001" => out_hex <= "1111001"; -- 1
			when "0010" => out_hex <= "0100100"; -- 2
			when "0011" => out_hex <= "0110000"; -- 3
			when "0100" => out_hex <= "0011001"; -- 4
			when "0101" => out_hex <= "0010010"; -- 5
			when "0110" => out_hex <= "0000010"; -- 6
			when "0111" => out_hex <= "1111000"; -- 7
			when "1000" => out_hex <= "0000000"; -- 8
			when "1001" => out_hex <= "0011000"; -- 9
			when "1010" => out_hex <= "0001000"; -- A
			when "1011" => out_hex <= "0000011"; -- B
			when "1100" => out_hex <= "1000110"; -- C
			when "1101" => out_hex <= "0100001"; -- D
			when "1110" => out_hex <= "0000110"; -- E
			when "1111" => out_hex <= "0001110"; -- F
			when others => out_hex <= "1111111";
		end case;
	end process;
end Behavioral;