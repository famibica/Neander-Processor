--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:30:12 10/19/2018
-- Design Name:   
-- Module Name:   /home/jtsantoro/Documents/Faculdade/SistemasDigitais/Trabalhos/trabalho2/tb_neander.vhd
-- Project Name:  trabalho2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: neander
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
 
ENTITY tb_neander IS
END tb_neander;
 
ARCHITECTURE behavior OF tb_neander IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT neander
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         acumulador : OUT  std_logic_vector(8 downto 0);
         halt : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal acumulador : std_logic_vector(8 downto 0);
   signal halt : std_logic;

   -- Clock period definitions
   constant clk_period : time := 7.120 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: neander PORT MAP (
          clk => clk,
          rst => rst,
          acumulador => acumulador,
          halt => halt
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		

		rst <= '1';
		
		wait for clk_period;
		rst <= '0';
      -- insert stimulus here

      wait;
   end process;

END;
