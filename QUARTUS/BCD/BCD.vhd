library ieee;
use ieee.std_logic_1164.all;

entity BCD_AGUNG_07111640000087 is port ( 
	sw	: in std_logic_vector (3 downto 0);
	SS	: out std_logic_vector (1 to 7)); 
end BCD_AGUNG_07111640000087;

architecture behave of BCD_AGUNG_07111640000087 is
constant	NOL		: std_logic_vector (3 downto 0) := "0000";
constant	SATU		: std_logic_vector (3 downto 0) := "0001";
constant	DUA		: std_logic_vector (3 downto 0) := "0010";
constant	TIGA		: std_logic_vector (3 downto 0) := "0011";
constant	EMPAT		: std_logic_vector (3 downto 0) := "0100";
constant	LIMA		: std_logic_vector (3 downto 0) := "0101";
constant	ENAM		: std_logic_vector (3 downto 0) := "0110";
constant	TUJUH		: std_logic_vector (3 downto 0) := "0111";
constant	DELAPAN	: std_logic_vector (3 downto 0) := "1000";
constant SEMBILAN	: std_logic_vector (3 downto 0) := "1001";
constant SEPULUH	: std_logic_vector (3 downto 0) := "1010";
constant SEBELAS	: std_logic_vector (3 downto 0) := "1011";
constant DUABLAS	: std_logic_vector (3 downto 0) := "1100";
constant TIGABLAS	: std_logic_vector (3 downto 0) := "1101";
constant PATBLAS	: std_logic_vector (3 downto 0) := "1110";
constant MABLAS	: std_logic_vector (3 downto 0) := "1111";

begin
	process (sw)
	begin
		case sw is
			when	NOL		=> SS <= "0000001";
			when	SATU		=> SS <= "1001111";
			when	DUA		=> SS <= "0010010";
			when	TIGA		=> SS <= "0000110";
			when	EMPAT		=> SS <= "1001100";
			when	LIMA		=> SS <= "0100100";
			when	ENAM		=> SS <= "0100000";
			when	TUJUH		=> SS <= "0001111";
			when	DELAPAN	=> SS <= "0000000";
			when	SEMBILAN	=> SS <= "0000100";
			when	SEPULUH	=> SS <= "0001000";
			when	SEBELAS	=> SS <= "1100000";
			when	DUABLAS	=> SS <= "0110001";
			when	TIGABLAS	=> SS <= "1000010";
			when	PATBLAS	=> SS <= "0110000";
			when	MABLAS	=> SS <= "0111000";
		end case;
	end process;
end behave;