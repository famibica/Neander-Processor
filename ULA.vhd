----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:44:49 10/09/2018 
-- Design Name: 
-- Module Name:    ula - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ula is
    Port ( ula_in1 : in  STD_LOGIC_VECTOR (8 downto 0);
           ula_in2 : in  STD_LOGIC_VECTOR (8 downto 0);
           ula_sel : in  STD_LOGIC_VECTOR (2 downto 0);
           ula_NZ : out  STD_LOGIC_VECTOR (1 downto 0);
           ula_out : out  STD_LOGIC_VECTOR (8 downto 0));
end ula;

architecture Behavioral of ula is

	signal temp_out : STD_LOGIC_VECTOR (8 downto 0);
	
begin
	
	process(ula_sel, ula_in1, ula_in2)
	begin
			case ula_sel is
						when "000" => temp_out <= ula_in1 + ula_in2;
						when "001" => temp_out <= ula_in1 and ula_in2;
						when "010" => temp_out <= ula_in1 or ula_in2;
						when "011" => temp_out <= not ula_in1;
						when "100" => temp_out <= ula_in2;
						when "101" => temp_out <= '0'& ula_in1(3 downto 0) * ula_in2(3 downto 0);
						when "110" => if(ula_in1 > ula_in2) then
										  temp_out <= ula_in1;
										  else
										  temp_out <= ula_in2;
										  end if;
						when "111" => if(ula_in1 < ula_in2) then
										  temp_out <= ula_in1;
										  else
										  temp_out <= ula_in2;
										  end if;
						when others => temp_out <= ula_in2;
			end case;
	end process;
		
	
	-- Negativo
	ula_NZ(1) <= '1' when temp_out(8) = '1' else '0';
	
	-- Zero
	ula_NZ(0) <= '1' when temp_out = "000000000" else '0';

	-- Resultado
	ula_out <= temp_out;

end Behavioral;

