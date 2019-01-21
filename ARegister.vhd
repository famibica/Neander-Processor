library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ARegister is
	Generic ( nbits : INTEGER := 1);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
			  increment : in STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (nbits-1 downto 0);
           Q : out  STD_LOGIC_VECTOR (nbits-1 downto 0));
end ARegister;

architecture Behavioral of ARegister is
	signal reg : STD_LOGIC_VECTOR (nbits-1 downto 0);
begin
	process (clk, reset)
	begin
		if (reset = '1') then
			reg <= (others => '0');
		elsif (clk'event and clk = '1') then
			if (load = '1') then
				reg <= D;
			elsif (increment = '1') then
				reg <= reg + '1';
			else
				reg <= reg;
			end if;
		end if;
	end process;

	Q <= reg;

end Behavioral;