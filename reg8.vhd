----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:39:22 10/15/2018 
-- Design Name: 
-- Module Name:    reg8 - Behavioral 
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

entity reg9 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           reg_in : in  STD_LOGIC_VECTOR (8 downto 0);
           cargaREG : in  STD_LOGIC;
           reg_out : out  STD_LOGIC_VECTOR (8 downto 0));
end reg9;

architecture Behavioral of reg9 is

signal temp_reg : STD_LOGIC_VECTOR (8 downto 0);

begin

process(clk, rst)
begin
	if(rst = '1') then
		temp_reg <= "000000000";
	elsif (clk'event and clk = '1') then
		if (cargaREG = '1') then
			temp_reg <= reg_in;
		else
			temp_reg <= temp_reg;
		end if;
	end if;
end process;

reg_out <= temp_reg;

end Behavioral;

