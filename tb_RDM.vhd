--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:37:13 10/17/2018
-- Design Name:   
-- Module Name:   /home/jtsantoro/Documents/Faculdade/SistemasDigitais/Trabalhos/trabalho2/tb_RDM.vhd
-- Project Name:  trabalho2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegRDM
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
 
ENTITY tb_RDM IS
END tb_RDM;
 
ARCHITECTURE behavior OF tb_RDM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegRDM
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         cargaRDM : IN  std_logic;
         rw : IN  std_logic_vector(0 downto 0);
         reg_in1 : IN  std_logic_vector(7 downto 0);
         reg_in2 : IN  std_logic_vector(7 downto 0);
         reg_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal cargaRDM : std_logic := '0';
   signal rw : std_logic_vector(0 downto 0) := (others => '0');
   signal reg_in1 : std_logic_vector(7 downto 0) := (others => '0');
   signal reg_in2 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal reg_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegRDM PORT MAP (
          clk => clk,
          rst => rst,
          cargaRDM => cargaRDM,
          rw => rw,
          reg_in1 => reg_in1,
          reg_in2 => reg_in2,
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
		
		reg_in1 <= "00010111";
		reg_in2 <= "00000011";
		wait for clk_period;
		rw <= "1";
		wait for clk_period;
		cargaRDM <= '1';
		wait for clk_period;
		rw <= "0";	
		wait for clk_period;
		rst <= '1';
		wait for clk_period;
		rst <= '0';
		wait for clk_period;
		cargaRDM <= '0';
      wait;
   end process;

END;
