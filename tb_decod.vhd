--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:37:34 10/17/2018
-- Design Name:   
-- Module Name:   /home/jtsantoro/Documents/Faculdade/SistemasDigitais/Trabalhos/trabalho2/tb_decod.vhd
-- Project Name:  trabalho2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decod
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
 
ENTITY tb_decodificador IS
END tb_decodificador;
 
ARCHITECTURE behavior OF tb_decodificador IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decodificador
    PORT(
         decod_in : IN  std_logic_vector(3 downto 0);
         NOP_out : OUT  std_logic;
         STA_out : OUT  std_logic;
         LDA_out : OUT  std_logic;
         ADD_out : OUT  std_logic;
         OR_out : OUT  std_logic;
         AND_out : OUT  std_logic;
         NOT_out : OUT  std_logic;
         JMP_out : OUT  std_logic;
         JN_out : OUT  std_logic;
         JZ_out : OUT  std_logic;
         HLT_out : OUT  std_logic;
         SUB_out : OUT  std_logic;
         SHR_out : OUT  std_logic;
         SHL_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal decod_in : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal NOP_out : std_logic;
   signal STA_out : std_logic;
   signal LDA_out : std_logic;
   signal ADD_out : std_logic;
   signal OR_out : std_logic;
   signal AND_out : std_logic;
   signal NOT_out : std_logic;
   signal JMP_out : std_logic;
   signal JN_out : std_logic;
   signal JZ_out : std_logic;
   signal HLT_out : std_logic;
   signal SUB_out : std_logic;
   signal SHR_out : std_logic;
   signal SHL_out : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decodificador PORT MAP (
          decod_in => decod_in,
          NOP_out => NOP_out,
          STA_out => STA_out,
          LDA_out => LDA_out,
          ADD_out => ADD_out,
          OR_out => OR_out,
          AND_out => AND_out,
          NOT_out => NOT_out,
          JMP_out => JMP_out,
          JN_out => JN_out,
          JZ_out => JZ_out,
          HLT_out => HLT_out,
          SUB_out => SUB_out,
          SHR_out => SHR_out,
          SHL_out => SHL_out
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		decod_in <= "0001";
		wait for  100 ns;
		decod_in <= "0010";
		wait for  100 ns;
		decod_in <= "0011";
		wait for  100 ns;
		decod_in <= "0100";
		wait for  100 ns;
		decod_in <= "0101";
		wait for  100 ns;
		decod_in <= "0110";
		wait for  100 ns;
		decod_in <= "0111";
		wait for  100 ns;
		decod_in <= "1000";
		wait for  100 ns;
		decod_in <= "1001";
		wait for  100 ns;
		decod_in <= "1010";
		wait for  100 ns;
		decod_in <= "1011";
		wait for  100 ns;
		decod_in <= "1100";
		wait for  100 ns;
		decod_in <= "1101";
		wait for  100 ns;
		decod_in <= "1110";
		wait for  100 ns;
		decod_in <= "1111";

      -- insert stimulus here 

      wait;
   end process;

END;
