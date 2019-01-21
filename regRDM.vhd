----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:15:53 10/17/2018 
-- Design Name: 
-- Module Name:    regrwM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegRDM is
    Port ( clk       : in  STD_LOGIC;
           rst 	   : in  STD_LOGIC;
           cargaRDM  : in  STD_LOGIC;
           rw 			: in  STD_LOGIC_VECTOR (0 to 0);
           reg_in1 	: in  STD_LOGIC_VECTOR (8 downto 0);
           reg_in2 	: in  STD_LOGIC_VECTOR (8 downto 0);
           reg_out 	: out  STD_LOGIC_VECTOR (8 downto 0));
end RegRDM;

architecture Behavioral of RegRDM is

	signal temp_in : STD_LOGIC_VECTOR(8 downto 0);
	
begin
	process(clk, rst)
	begin
		if(rst = '1') then
			temp_in <= "000000000";
		elsif(clk'event and clk='1') then
			if cargaRDM = '1' then
				temp_in <= reg_in1;
			elsif rw = "0" then
				temp_in <= reg_in2;
			else
				temp_in <= temp_in;
			end if;
		end if;
	end process;
	
	
	reg_out <= temp_in;


end Behavioral;

