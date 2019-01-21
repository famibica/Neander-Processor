--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:46:35 10/11/2018
-- Design Name:   
-- Module Name:   /home/jtsantoro/Documents/Faculdade/SistemasDigitais/Trabalhos/trabalho2/tb_ula.vhd
-- Project Name:  trabalho2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ula
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
 
ENTITY tb_ula IS
END tb_ula;
 
ARCHITECTURE behavior OF tb_ula IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ula
    PORT(
         ula_in1 : IN  std_logic_vector(7 downto 0);
         ula_in2 : IN  std_logic_vector(7 downto 0);
         ula_sel : IN  std_logic_vector(2 downto 0);
         ula_NZ : OUT  std_logic_vector(1 downto 0);
         ula_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ula_in1 : std_logic_vector(7 downto 0) := "00000010";
   signal ula_in2 : std_logic_vector(7 downto 0) := "00000010";
   signal ula_sel : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal ula_NZ : std_logic_vector(1 downto 0);
   signal ula_out : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ula PORT MAP (
          ula_in1 => ula_in1,
          ula_in2 => ula_in2,
          ula_sel => ula_sel,
          ula_NZ => ula_NZ,
          ula_out => ula_out
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		
		ula_sel <= "001";
		wait for 100 ns;
		ula_sel <= "010";
		wait for 100 ns;
		ula_sel <= "011";
		wait for 100 ns;
		ula_sel <= "100";
		wait for 100 ns;
		ula_sel <= "101";
		wait for 100 ns;
		ula_sel <= "110";
		wait for 100 ns;
		ula_sel <= "111";
		wait for 100 ns;

		ula_in1 <= "01000100";
		ula_in2 <= "00000110";
		wait for 100 ns;
		
		ula_sel <= "000";
		wait for 100 ns;
		ula_sel <= "001";
		wait for 100 ns;
		ula_sel <= "010";
		wait for 100 ns;
		ula_sel <= "011";
		wait for 100 ns;
		ula_sel <= "100";
		wait for 100 ns;
		ula_sel <= "101";
		wait for 100 ns;
		ula_sel <= "110";
		wait for 100 ns;
		ula_sel <= "111";
		wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
