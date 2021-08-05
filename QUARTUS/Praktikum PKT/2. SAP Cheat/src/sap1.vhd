-- AUTHOR: Jonathan Primeau

library ieee;
use ieee.std_logic_1164.all;

entity sap1 is
	port
	(
		SW		: in std_logic_vector(9 downto 0);
		KEY	: in std_logic_vector(3 downto 0);
		LEDR	: out std_logic_vector(9 downto 0);
		LEDG	: out std_logic_vector(7 downto 0);
		HEX0	: out std_logic_vector(6 downto 0);
		HEX1	: out std_logic_vector(6 downto 0);
		HEX2	: out std_logic_vector(6 downto 0);
		HEX3	: out std_logic_vector(6 downto 0);
		
		CLOCK_50	: in std_logic
	);
end sap1;

architecture Structural of sap1 is

	signal address			: std_logic_vector(3 downto 0);
	signal disp_address	: std_logic_vector(3 downto 0);
	signal data				: std_logic_vector(7 downto 0);
	signal disp_data		: std_logic_vector(7 downto 0);
	signal addr_mode		: std_logic := '1';
	signal clr_mode		: std_logic := '1';
	signal step				: std_logic := '0';
	signal store			: std_logic := '0';
	signal div_clk			: std_logic;
	signal int_clk			: std_logic;
	signal halt				: std_logic;

	component SevenSegDecoder
		port
		(
			in_bdc	: in std_logic_vector(3 downto 0);
			out_hex	: out std_logic_vector(6 downto 0)
		);
	end component;
	
	component ClockDivider
		port
		(
			in_clk_50mhz	: in std_logic;
			out_clk_10hz	: out std_logic;
			out_clk_1hz		: out std_logic
		);
	end component;
	
	component sap1_top
		port
		(
			in_data		: in std_logic_vector(7 downto 0);
			in_address	: in std_logic_vector(3 downto 0);
			in_run		: in std_logic;
			in_auto		: in std_logic;
			in_store		: in std_logic;
			in_step		: in std_logic;
			in_start		: in std_logic;
			in_clk		: in std_logic;
			out_addr		: out std_logic_vector(3 downto 0);
			out_data		: out std_logic_vector(7 downto 0);
			out_halt		: out std_logic
		);
	end component;
	
begin
	LEDR <= SW;
	HEX2 <= (others => '1');
	
	CLK_DIV : ClockDivider
		port map
		(
			in_clk_50mhz => CLOCK_50,
			out_clk_10hz => open,
			out_clk_1hz => div_clk
		);
	
	addr_data_pb : process (KEY(3), SW, addr_mode)
	begin
		if KEY(3)'event and KEY(3) = '0' then
			addr_mode <= not(addr_mode);
		end if;
		if addr_mode = '1' then
			address <= SW(3 downto 0);
		else
			data <= SW(7 downto 0);
		end if;
		LEDG(7) <= addr_mode;
		LEDG(6) <= not(addr_mode);
	end process;
	
	store_pb : process (KEY(2), addr_mode, store)
	begin
		if addr_mode = '0' then
			store <= not(KEY(2));
			LEDG(5) <= store;
			LEDG(4) <= store;
		end if;
	end process;
	
	step_pb : process (KEY(1), step)
	begin
		step <= not(KEY(1));
		LEDG(3) <= step;
	end process;
	
	clr_start_pb : process (KEY(0), clr_mode)
	begin
		if KEY(0)'event and KEY(0) = '0' then
			clr_mode <= not(clr_mode);
		end if;
		LEDG(1) <= clr_mode;
		LEDG(0) <= not(clr_mode);
	end process;
	
	process (div_clk, clr_mode, halt, int_clk)
	begin
		if clr_mode = '0' and halt = '0' then
			int_clk <= div_clk;
		else
			int_clk <= '0';
		end if;
		LEDG(2) <= int_clk;
	end process;
	
	HEX_DISP0 : SevenSegDecoder
	port map
	(
		in_bdc => disp_data(3 downto 0),
		out_hex => HEX0
	);
	
	HEX_DISP1 : SevenSegDecoder
	port map
	(
		in_bdc => disp_data(7 downto 4),
		out_hex => HEX1
	);

	HEX_DISP3 : SevenSegDecoder
	port map
	(
		in_bdc => disp_address(3 downto 0),
		out_hex => HEX3
	);
	
	SAP_1 : sap1_top
	port map
	(
		in_data => data,
		in_address => address,
		in_run => SW(9),
		in_auto => SW(8),
		in_store => store,
		in_step => step,
		in_start => not(clr_mode),
		in_clk => int_clk,
		out_addr => disp_address,
		out_data => disp_data,
		out_halt => halt
	);

end Structural;

