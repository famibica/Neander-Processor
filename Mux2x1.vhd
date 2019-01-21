library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux2x1 is
    Port ( D1 : in  STD_LOGIC_VECTOR (7 downto 0);
           D2 : in  STD_LOGIC_VECTOR (7 downto 0);
           sel : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (7 downto 0));
end Mux2x1;

architecture Behavioral of Mux2x1 is
begin
	with sel select
		Q <= 	D1 when '0',
				D2 when '1',
				(others => '0') when others;

end Behavioral;