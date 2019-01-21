--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:37:50 10/17/2018
-- Design Name:   
-- Module Name:   /home/jtsantoro/Documents/Faculdade/SistemasDigitais/Trabalhos/trabalho2/tb_controle.vhd
-- Project Name:  trabalho2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: unidadeControle
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
 
ENTITY tb_unidadeControle IS
END tb_unidadeControle;
 
ARCHITECTURE behavior OF tb_unidadeControle IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT unidadeControle
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         N : IN  std_logic;
         Z : IN  std_logic;
         NOP_in : IN  std_logic;
         STA_in : IN  std_logic;
         LDA_in : IN  std_logic;
         ADD_in : IN  std_logic;
         OR_in : IN  std_logic;
         AND_in : IN  std_logic;
         NOT_in : IN  std_logic;
         JMP_in : IN  std_logic;
         JN_in : IN  std_logic;
         JZ_in : IN  std_logic;
         HLT_in : IN  std_logic;
         SUB_in : IN  std_logic;
         SHR_in : IN  std_logic;
         SHL_in : IN  std_logic;
         sel_ula : OUT  std_logic_vector(2 downto 0);
         sel_rem : OUT  std_logic;
         CargaAC : OUT  std_logic;
         CargaPC : OUT  std_logic;
         CargaREM : OUT  std_logic;
         CargaRDM : OUT  std_logic;
         CargaRI : OUT  std_logic;
         CargaNZ : OUT  std_logic;
         enableMEM : OUT  std_logic_vector(0 downto 0);
         incrementaPC : OUT  std_logic;
         halt : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal N : std_logic := '0';
   signal Z : std_logic := '0';
   signal NOP_in : std_logic := '0';
   signal STA_in : std_logic := '0';
   signal LDA_in : std_logic := '0';
   signal ADD_in : std_logic := '0';
   signal OR_in : std_logic := '0';
   signal AND_in : std_logic := '0';
   signal NOT_in : std_logic := '0';
   signal JMP_in : std_logic := '0';
   signal JN_in : std_logic := '0';
   signal JZ_in : std_logic := '0';
   signal HLT_in : std_logic := '0';
   signal SUB_in : std_logic := '0';
   signal SHR_in : std_logic := '0';
   signal SHL_in : std_logic := '0';

 	--Outputs
   signal sel_ula : std_logic_vector(2 downto 0);
   signal sel_rem : std_logic;
   signal CargaAC : std_logic;
   signal CargaPC : std_logic;
   signal CargaREM : std_logic;
   signal CargaRDM : std_logic;
   signal CargaRI : std_logic;
   signal CargaNZ : std_logic;
   signal enableMEM : std_logic_vector(0 downto 0);
   signal incrementaPC : std_logic;
   signal halt : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: unidadeControle PORT MAP (
          clk => clk,
          rst => rst,
          N => N,
          Z => Z,
          NOP_in => NOP_in,
          STA_in => STA_in,
          LDA_in => LDA_in,
          ADD_in => ADD_in,
          OR_in => OR_in,
          AND_in => AND_in,
          NOT_in => NOT_in,
          JMP_in => JMP_in,
          JN_in => JN_in,
          JZ_in => JZ_in,
          HLT_in => HLT_in,
          SUB_in => SUB_in,
          SHR_in => SHR_in,
          SHL_in => SHL_in,
          sel_ula => sel_ula,
          sel_rem => sel_rem,
          CargaAC => CargaAC,
          CargaPC => CargaPC,
          CargaREM => CargaREM,
          CargaRDM => CargaRDM,
          CargaRI => CargaRI,
          CargaNZ => CargaNZ,
          enableMEM => enableMEM,
          incrementaPC => incrementaPC,
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		NOP_in <= '1';
		wait for clk_period*2;
		NOP_in <= '0';
		wait for clk_period;
		ADD_in <= '1';
		wait for clk_period*10;
		ADD_in <= '0';
		wait for clk_period;
		SUB_in <= '1';
		wait for clk_period*10;
		SUB_in <= '0';
		rst <= '0';
		
      wait;
   end process;

END;
