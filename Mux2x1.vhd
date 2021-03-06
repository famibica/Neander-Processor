----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:49:28 10/19/2018 
-- Design Name: 
-- Module Name:    mux2x1 - Behavioral 
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

entity mux2x1 is
		Port ( sel : in  STD_LOGIC;
				 in1 : in  STD_LOGIC_VECTOR (8 downto 0);
				 in2 : in  STD_LOGIC_VECTOR (8 downto 0);
				 s : out  STD_LOGIC_VECTOR (8 downto 0));
end mux2x1;

architecture Behavioral of mux2x1 is

begin
	process(sel, in1, in2)
		begin
			if(sel = '0') then
				s <= in1;
			else 
				s <= in2;
			end if;
	end process;

end Behavioral;

