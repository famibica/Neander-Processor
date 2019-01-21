--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:36:54 10/17/2018
-- Design Name:   
-- Module Name:   /home/jtsantoro/Documents/Faculdade/SistemasDigitais/Trabalhos/trabalho2/tb_reg8.vhd
-- Project Name:  trabalho2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: reg8
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
 
ENTITY tb_reg8 IS
END tb_reg8;
 
ARCHITECTURE behavior OF tb_reg8 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg8
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         reg_in : IN  std_logic_vector(7 downto 0);
         cargaREG : IN  std_logic;
         reg_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal reg_in : std_logic_vector(7 downto 0) := (others => '0');
   signal cargaREG : std_logic := '0';

 	--Outputs
   signal reg_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg8 PORT MAP (
          clk => clk,
          rst => rst,
          reg_in => reg_in,
          cargaREG => cargaREG,
          reg_out => reg_out
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		reg_in <= "00010111";
		wait for clk_period*2;
		cargaREG <= '1';
		wait for clk_period;
		reg_in <= "00000011";
		wait for clk_period;
		reg_in <= "01100000";
		wait for clk_period;
		cargaREG <= '0';
		wait for clk_period*2;
		rst <= '1';
		
      wait;
   end process;

END;
