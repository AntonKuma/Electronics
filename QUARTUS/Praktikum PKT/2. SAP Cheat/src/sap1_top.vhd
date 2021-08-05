-- AUTHOR: Jonathan Primeau

library ieee;
use ieee.std_logic_1164.all;

entity sap1_top is
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
		--out_bus		: out std_logic_vector(7 downto 0);
		out_halt		: out std_logic
	);
end sap1_top;

architecture Structural of sap1_top is

	signal int_clk	: std_logic;

	signal Cp		: std_logic;
	signal Ep		: std_logic;
	signal Lm		: std_logic;
	signal Em		: std_logic;
	signal Li		: std_logic;
	signal Ei		: std_logic;
	signal La		: std_logic;
	signal Ea		: std_logic;
	signal Su		: std_logic;
	signal Eu		: std_logic;
	signal Lb		: std_logic;
	signal Lo		: std_logic;
	
	signal iLDA		: std_logic;
	signal iADD		: std_logic;
	signal iSUB		: std_logic;
	signal iOUT		: std_logic;

	signal w_bus		: std_logic_vector(7 downto 0);
	signal mar_out		: std_logic_vector(3 downto 0);
	signal inst_out	: std_logic_vector(3 downto 0);
	signal a_out		: std_logic_vector(7 downto 0);
	signal b_out		: std_logic_vector(7 downto 0);
	signal o_out		: std_logic_vector(7 downto 0);
	signal ctrl			: std_logic_vector(11 downto 0);
	
	signal address		: std_logic_vector(3 downto 0);
	signal data			: std_logic_vector(7 downto 0);
	
	component BinaryCounter
		generic ( n : natural := 4 );
		port
		(
			in_clk		: in std_logic;
			in_clr		: in std_logic;
			in_count		: in std_logic;
			in_output	: in std_logic;
			out_data		: out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component RAM
		port
		(
			in_read		: in std_logic;
			in_write		: in std_logic;
			in_output	: in std_logic;
			in_addr		: in std_logic_vector(3 downto 0);
			in_data		: in std_logic_vector(7 downto 0);
			out_data		: out std_logic_vector(7 downto 0)
		);
	end component;
	
	component ArithmeticLogicUnit
		generic ( n : natural := 8 );
		port
		(
			in_a			: in std_logic_vector(n-1 downto 0);
			in_b			: in std_logic_vector(n-1 downto 0);
			in_sub		: in std_logic;
			in_output 	: in std_logic;
			out_data		: out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component GenericRegister
		generic ( n : natural := 8 );
		port
		(
			in_clk		: in std_logic;
			in_clr		: in std_logic;
			in_input		: in std_logic;
			in_output	: in std_logic;
			in_data		: in std_logic_vector(n-1 downto 0);
			out_data		: out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component InstructionDecoder
		port
		(
			in_inst	: in std_logic_vector(3 downto 0);
			out_lda	: out std_logic;
			out_add	: out std_logic;
			out_sub	: out std_logic;
			out_out	: out std_logic;
			out_hlt	: out std_logic
		);
	end component;
	
	component ControlMatrix
		port
		(
			in_clk	: in std_logic;
			in_clr	: in std_logic;
			in_lda	: in std_logic;
			in_add	: in std_logic;
			in_sub	: in std_logic;
			in_out	: in std_logic;
			out_ctrl	: out std_logic_vector(11 downto 0)
		);
	end component;
	
begin
	Cp <= ctrl(0);
	Ep <= ctrl(1);
	Lm <= ctrl(2);
	Em <= ctrl(3);
	Li <= ctrl(4);
	Ei <= ctrl(5);
	La <= ctrl(6);
	Ea <= ctrl(7);
	Su <= ctrl(8);
	Eu <= ctrl(9);
	Lb <= ctrl(10);
	Lo <= ctrl(11);
	
	address <= in_address when in_run = '0' else mar_out;
	data <= in_data when in_run = '0' else (others => 'Z');
	out_addr <= address;
	out_data <= o_out;

	PC	: BinaryCounter
		port map
		(
			in_clk => in_clk,
			in_clr => not(in_start),
			in_count => Cp,
			in_output => Ep,
			out_data => w_bus(3 downto 0)
		);
		
	MAR : GenericRegister
		generic map ( n => 4 )
		port map
		(
			in_clk => in_clk,
			in_clr => '0',
			in_input => Lm,
			in_output => '1',
			in_data => w_bus(3 downto 0),
			out_data => mar_out
		);
		
	Memory : RAM
		port map
		(
			in_read => not(in_store),
			in_write => in_store,
			in_output => Em,
			in_addr => address,
			in_data => data,
			out_data => w_bus(7 downto 0)
		);
		
	IH_reg : GenericRegister
		generic map ( n => 4 )
		port map
		(
			in_clk => in_clk,
			in_clr => not(in_start),
			in_input => Li,
			in_output => Ei,
			in_data => w_bus(7 downto 4),
			out_data => inst_out
		);
		
	IL_reg : GenericRegister
		generic map ( n => 4 )
		port map
		(
			in_clk => in_clk,
			in_clr => '0',
			in_input => Li,
			in_output => Ei,
			in_data => w_bus(3 downto 0),
			out_data => w_bus(3 downto 0)
		);
		
	A_REG : GenericRegister
		generic map ( n => 8 )
		port map
		(
			in_clk => in_clk,
			in_clr => '0',
			in_input => La,
			in_output => Ea,
			in_data => w_bus(7 downto 0),
			out_data => a_out -- TODO + link to bus
		);
		
	ALU : ArithmeticLogicUnit
		port map
		(
			in_a => a_out,
			in_b => b_out,
			in_sub => Su,
			in_output => Eu,
			out_data => w_bus(7 downto 0)
		);
		
	B_REG : GenericRegister
		generic map ( n => 8 )
		port map
		(
			in_clk => in_clk,
			in_clr => '0',
			in_input => Lb,
			in_output => '1',
			in_data => w_bus(7 downto 0),
			out_data => b_out
		);
		
	O_REG : GenericRegister
		generic map ( n => 8 )
		port map
		(
			in_clk => in_clk,
			in_clr => '0',
			in_input => Lo,
			in_output => '1',
			in_data => a_out,
			out_data => o_out
		);
		
	INST_DEC : InstructionDecoder
		port map
		(
			in_inst => inst_out,
			out_lda => iLDA,
			out_add => iADD,
			out_sub => iSUB,
			out_out => iOUT,
			out_hlt => out_halt
		);
		
	CTRL_MATRIX : ControlMatrix
		port map
		(
			in_clk => in_clk,
			in_clr => not(in_start),
			in_lda => iLDA,
			in_add => iADD,
			in_sub => iSUB,
			in_out => iOUT,
			out_ctrl	=> ctrl
		);
end Structural;

