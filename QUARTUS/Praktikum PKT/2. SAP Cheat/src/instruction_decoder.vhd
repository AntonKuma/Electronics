-- AUTHOR: Jonathan Primeau

library ieee;
use ieee.std_logic_1164.all;

entity InstructionDecoder is
	port
	(
		in_inst	: in std_logic_vector(3 downto 0);
		out_lda	: out std_logic;
		out_add	: out std_logic;
		out_sub	: out std_logic;
		out_out	: out std_logic;
		out_hlt	: out std_logic
	);
end InstructionDecoder;

architecture Behavioral of InstructionDecoder is
	signal instruction : std_logic_vector(4 downto 0);
begin
	process (in_inst)
	begin
		case in_inst is
			when "0000" => instruction <= "00001";
			when "0001" => instruction <= "00010";
			when "0010" => instruction <= "00100";
			when "1110" => instruction <= "01000";
			when "1111" => instruction <= "10000";
			when others => instruction <= "00000";
		end case;
	end process;
	
	out_lda <= instruction(0);
	out_add <= instruction(1);
	out_sub <= instruction(2);
	out_out <= instruction(3);
	out_hlt <= instruction(4);
end Behavioral;