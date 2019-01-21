--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:26:05 10/11/2018
-- Design Name:   
-- Module Name:   /home/jtsantoro/Documents/Faculdade/SistemasDigitais/Trabalhos/trabalho2/tb_mux2x1.vhd
-- Project Name:  trabalho2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux2x1
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_mux2x1 IS
END tb_mux2x1;
 
ARCHITECTURE behavior OF tb_mux2x1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux2x1
    PORT(
         mux_in1 : IN  std_logic_vector(7 downto 0);
         mux_in2 : IN  std_logic_vector(7 downto 0);
         mux_sel : IN  std_logic;
         mux_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal mux_in1 : std_logic_vector(7 downto 0) := "00001010";
   signal mux_in2 : std_logic_vector(7 downto 0) := "00010100";
   signal mux_sel : std_logic := '0';

 	--Outputs
   signal mux_out : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux2x1 PORT MAP (
          mux_in1 => mux_in1,
          mux_in2 => mux_in2,
          mux_sel => mux_sel,
          mux_out => mux_out
        );

   -- Clock process definitions
  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		mux_sel <= '1';
		wait for 100 ns;
		
		mux_sel <= '0';
		wait for 100 ns;
		
		mux_sel <= '1';
		wait for 100 ns;
		
		mux_sel <= '0';
		wait for 100 ns;
		
		-- insert stimulus here 

      wait;
   end process;

END;
