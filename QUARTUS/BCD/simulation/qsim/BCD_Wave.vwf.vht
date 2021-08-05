-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "03/07/2019 23:16:09"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          BCD_AGUNG_07111640000087
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY BCD_AGUNG_07111640000087_vhd_vec_tst IS
END BCD_AGUNG_07111640000087_vhd_vec_tst;
ARCHITECTURE BCD_AGUNG_07111640000087_arch OF BCD_AGUNG_07111640000087_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL SS : STD_LOGIC_VECTOR(1 TO 7);
SIGNAL sw : STD_LOGIC_VECTOR(3 DOWNTO 0);
COMPONENT BCD_AGUNG_07111640000087
	PORT (
	SS : OUT STD_LOGIC_VECTOR(1 TO 7);
	sw : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : BCD_AGUNG_07111640000087
	PORT MAP (
-- list connections between master ports and signals
	SS => SS,
	sw => sw
	);
-- sw[3]
t_prcs_sw_3: PROCESS
BEGIN
LOOP
	sw(3) <= '0';
	WAIT FOR 8000000 ps;
	sw(3) <= '1';
	WAIT FOR 8000000 ps;
	IF (NOW >= 16000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_sw_3;
-- sw[2]
t_prcs_sw_2: PROCESS
BEGIN
LOOP
	sw(2) <= '0';
	WAIT FOR 4000000 ps;
	sw(2) <= '1';
	WAIT FOR 4000000 ps;
	IF (NOW >= 16000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_sw_2;
-- sw[1]
t_prcs_sw_1: PROCESS
BEGIN
LOOP
	sw(1) <= '0';
	WAIT FOR 2000000 ps;
	sw(1) <= '1';
	WAIT FOR 2000000 ps;
	IF (NOW >= 16000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_sw_1;
-- sw[0]
t_prcs_sw_0: PROCESS
BEGIN
LOOP
	sw(0) <= '0';
	WAIT FOR 1000000 ps;
	sw(0) <= '1';
	WAIT FOR 1000000 ps;
	IF (NOW >= 16000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_sw_0;
END BCD_AGUNG_07111640000087_arch;
