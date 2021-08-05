library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity COUNTER_AGUNG_07111640000087 is
port ( clock, reset, set, mode : in std_logic;
		 number : in std_logic_vector (3 downto 0);
		 result : out std_logic_vector (3 downto 0));
end COUNTER_AGUNG_07111640000087;

architecture behave of COUNTER_AGUNG_07111640000087 is
signal temp : std_logic_vector (3 downto 0);
begin
	process (clock, reset, set)
	begin
		if reset = '1' then
			temp <= "0000";
		elsif (clock'event and clock = '1') then
			if set = '1' then
				temp <= number;
			elsif (set = '0' and mode = '1') then
				temp <= temp + 1;
			elsif (set = '0' and mode = '0') then
				temp <= temp - 1;
			end if;
		endif;
	end process;
	result <= temp;
end behave;