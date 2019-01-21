----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:15:38 10/15/2018 
-- Design Name: 
-- Module Name:    regNZ - Behavioral 
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

entity regNZ is
	 Port ( clk : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
			  nz_in : in  STD_LOGIC_VECTOR(1 downto 0);
			  cargaNZ : in  STD_LOGIC;
			  nz_out : out  STD_LOGIC_VECTOR(1 downto 0));
end regNZ;

architecture Behavioral of regNZ is

signal temp_nz : STD_LOGIC_VECTOR(1 downto 0);

begin

process(clk, rst)
begin
	if(rst = '1') then
		temp_nz <= "00";
	elsif(clk'event and clk = '1') then
		if(cargaNZ = '1') then
			temp_nz <= nz_in;
		else
			temp_nz <= temp_nz;
		end if;
	end if;
end process;

nz_out <= temp_nz;

end Behavioral;

