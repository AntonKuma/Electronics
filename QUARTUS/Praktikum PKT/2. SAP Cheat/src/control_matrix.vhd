-- AUTHOR: Jonathan Primeau

library ieee;
use ieee.std_logic_1164.all;

--			T1		T2		T3		T4		T5		T6
-- LDA	Ep,Lm	Cp		Em,Li	Ei,Lm	Em,La	XX
-- ADD							Ei,Lm	Em,Lb	Eu,La
-- SUB							Ei,Lm	Em,Lb	Su,Eu,La
-- OUT							Ea,Lo	XX		XX
-- HLT							XX		XX		XX

entity ControlMatrix is
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
end ControlMatrix;

architecture Behavioral of ControlMatrix is
	type state_type is (S1, S2, S3, S4, S5, S6);
	signal next_state, current_state : state_type;
	signal ctrl : std_logic_vector(11 downto 0) := (others => '0');
begin
	out_ctrl <= ctrl;
	
	state_reg: process(in_clk, in_clr)
	begin
		if in_clr = '1' then
			current_state <= S1;
		elsif in_clk'event and in_clk = '1' then
			 current_state <= next_state;
		end if;
	end process;

	-- Lo Lb Eu Su Ea La Ei Li Em Lm Ep Cp
	-- 11 10 09 08 07 06 05 04 03 02 01 00
	
	combinational_logic : process (current_state)
	begin
		ctrl <= (others => '0');
		case current_state is
		when S1 => -- Fetch address
			ctrl <= (1=>'1', 2=>'1', others=>'0'); -- Ep(1), Lm(2)
			next_state <= S2;
		when S2 => -- Increment program counter
			ctrl <= (0=>'1', others=>'0'); -- Cp(0)
			next_state <= S3;
		when S3 => -- Load instruction
			ctrl <= (3=>'1', 4=>'1', others=>'0'); -- Em(3), Li(4)
			next_state <= S4;
		when S4 =>
			if in_lda = '1' or in_add = '1' or in_sub = '1' then
				ctrl <= (5=>'1', 2=>'1', others=>'0'); -- Ei(5), Lm(2)
				--next_state <= S5;
			elsif in_out = '1' then
				ctrl <= (7=>'1', 11=>'1', others=>'0'); -- Ea(7), Lo(11)
				--next_state <= S1;
			else
				--next_state <= S1;
			end if;
			next_state <= S5;
		when S5 =>
			if in_lda = '1' then
				ctrl <= (3=>'1', 6=>'1', others=>'0'); -- Em(3), La(6)
				--next_state <= S1;
			elsif in_add = '1' or in_sub = '1' then
				ctrl <= (3=>'1', 10=>'1', others=>'0'); -- Em(3), Lb(10)
				--next_state <= S6;
			else
				--next_state <= S1;
			end if;
			next_state <= S6;
		when S6 =>
			if in_add = '1' or in_sub = '1' then
				ctrl <= (9=>'1', 6=>'1', others=>'0'); -- Eu(9), La(6)
				if in_sub = '1' then
					ctrl(8) <= '1'; -- Su(8)
				end if;
			end if;
			next_state <= S1;
		when others =>
			ctrl <= (others=>'0');
			next_state <= S1;
		end case;

	end process;
end Behavioral;