----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:57:50 10/15/2018 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           PC_in : in  STD_LOGIC_VECTOR (8 downto 0);
           cargaPC : in  STD_LOGIC;
           incrementaPC : in  STD_LOGIC;
           PC_out : out  STD_LOGIC_VECTOR (8 downto 0));
end PC;

architecture Behavioral of PC is

signal temp : STD_LOGIC_VECTOR (8 downto 0) := (others => '0') ;

begin

process(clk, rst, temp)
begin
	if(rst = '1') then
		temp <= "000000000";
	elsif(clk'event and clk = '1') then
		if(cargaPC = '0') and incrementaPC = '1' then
			temp <= temp +1;
		elsif cargaPC = '1' and incrementaPC = '0' then
			temp <= PC_in;
		else
			temp <= temp;
		end if;
	end if;
end process;

PC_out <= temp;

end Behavioral;

