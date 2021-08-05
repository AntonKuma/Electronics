-- AUTHOR: Jonathan Primeau

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ClockDivider is
	port
	(
		in_clk_50mhz	: in std_logic;
		out_clk_10hz	: out std_logic;
		out_clk_1hz		: out std_logic
	);
end ClockDivider;

architecture Behavioral of ClockDivider is
	signal count_10hz : integer := 0;
	signal count_1hz : integer := 0;
	signal clk_10hz_tmp : std_logic := '1';
	signal clk_1hz_tmp : std_logic := '1';
begin
	gen_1hz : process (in_clk_50mhz, clk_1hz_tmp)
	begin
		if in_clk_50mhz'event and in_clk_50mhz = '1' then
			if count_1hz < 25000000 then
				count_1hz <= count_1hz + 1;
			else
				count_1hz <= 0;
				clk_1hz_tmp <= not clk_1hz_tmp;
			end if;
		end if;
		out_clk_1hz <= clk_1hz_tmp;
	end process;
	
	gen_10hz : process (in_clk_50mhz, clk_10hz_tmp)
	begin
		if in_clk_50mhz'event and in_clk_50mhz = '1' then
			if count_10hz < 2500000 then
				count_10hz <= count_10hz + 1;
			else
				count_10hz <= 0;
				clk_10hz_tmp <= not clk_10hz_tmp;
			end if;
		end if;
		out_clk_10hz <= clk_10hz_tmp;
	end process;

end Behavioral;