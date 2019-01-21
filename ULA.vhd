library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ULA is
    Port ( X : in  STD_LOGIC_VECTOR (7 downto 0);
           Y : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           Q : out  STD_LOGIC_VECTOR (7 downto 0);
           NZ : out  STD_LOGIC_VECTOR (1 downto 0));
end ULA;

architecture Behavioral of ULA is
	signal result : STD_LOGIC_VECTOR (7 downto 0);
begin

	process(sel, X, Y)
	begin

		case sel is
			when "000" => 
				result <= X + Y;
			when "001" => 
				result <= X and Y;
			when "010" => 
				result <= X or Y;
			when "011" => 
				result <= not X;
			when "100" => 
				result <= Y;		
			when "101" => 
				result <= X - Y;
			when "110" =>
				result <= std_logic_vector(unsigned(X(3 downto 0)) * unsigned(Y(3 downto 0)));
			when others =>
				result <= (others => '0');
		end case;
		
	end process;
	
	process(result)
	begin
	if (result = 0) then
			NZ(0) <= '1';
	    else
			NZ(0) <= '0';
	    end if ;

	    if (result(7) = '1') then
			NZ(1) <= '1';
	    else
			NZ(0) <= '0';
	    end if;
	end process;
	
   Q <= result;
	
end Behavioral;