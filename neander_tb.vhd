LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY neander_tb IS
END neander_tb;
 
ARCHITECTURE behavior OF neander_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Neander
    PORT(
			  clk : IN  std_logic;
			  reset : IN  std_logic;
			  AC : OUT  std_logic_vector(7 downto 0);
			  PC : OUT  std_logic_vector(7 downto 0);
			  hlt : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal AC : std_logic_vector(7 downto 0);
   signal PC : std_logic_vector(7 downto 0);
   signal hlt : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Neander PORT MAP (
          clk => clk,
          reset => reset,
          AC => AC,
          PC => PC,
          hlt => hlt
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
	   reset <= '1';
      wait for CLK_PERIOD*10;
	
		reset <= '0';
		wait for CLK_PERIOD*2;	
      -- insert stimulus here 
		
      wait;
   end process;

END;
