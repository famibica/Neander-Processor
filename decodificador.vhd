----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:39:51 10/15/2018 
-- Design Name: 
-- Module Name:    decod - Behavioral 
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

entity decodificador is
    Port ( decod_in : in  STD_LOGIC_VECTOR (3 downto 0);
           NOP_out : out  STD_LOGIC;
           STA_out : out  STD_LOGIC;
           LDA_out : out  STD_LOGIC;
           ADD_out : out  STD_LOGIC;
           OR_out : out  STD_LOGIC;
           AND_out : out  STD_LOGIC;
           NOT_out : out  STD_LOGIC;
           JMP_out : out  STD_LOGIC;
           JN_out : out  STD_LOGIC;
           JZ_out : out  STD_LOGIC;
           HLT_out : out  STD_LOGIC;
           MULT_out : out  STD_LOGIC;
			  MAIOR_out : out STD_LOGIC;
			  MENOR_out : out  STD_LOGIC);
end decodificador;

architecture Behavioral of decodificador is

begin

process(decod_in)
begin

	if (decod_in = "0000") then 	 -- NOP 0
		NOP_out <= '1';
	else
		NOP_out <= '0';
	end if;
	
	if (decod_in = "0001") then -- STA 16
		STA_out <= '1';
	else
		STA_out <= '0';
	end if;
	
	if (decod_in = "0010") then -- LDA 32
		LDA_out <= '1';
	else
		LDA_out <= '0';
	end if;
	
	if (decod_in = "0011") then -- ADD 48
		ADD_out <= '1';
	else
		ADD_out <= '0';
	end if;
	
	if (decod_in = "0100") then -- OR 64
		OR_out  <= '1';
	else
		OR_out <= '0';
	end if;
	
	if (decod_in = "0101") then -- AND 80
		AND_out <= '1';
	else
		AND_out <= '0';
	end if;	
		
	if (decod_in = "0110") then -- NOT 96
		NOT_out <= '1';
	else
		NOT_out <= '0';
	end if;	
		
	if (decod_in = "1000") then -- JMP 128
		JMP_out <= '1';
	else
		JMP_out <= '0';
	end if;	
		
	if (decod_in = "1001") then -- JN 144
		JN_out  <= '1';
	else
		JN_out <= '0';
	end if;	
		
	if (decod_in = "1010") then -- JZ 160
		JZ_out  <= '1';
	else
		JZ_out <= '0';
	end if;	
	
	if (decod_in = "1111") then -- HLT 240
		HLT_out <= '1';
	else
		HLT_out <= '0';
	end if;	
	
	if (decod_in = "0111") then -- MULT 112
		MULT_out <= '1';
	else
		MULT_out <= '0';
	end if;	
	
	if (decod_in = "1011") then -- MAIOR 176
		MAIOR_out <= '1';
	else
		MAIOR_out <= '0';
	end if;	
	
	if (decod_in = "1100") then -- MENOR 192
		MENOR_out <= '1';
	else
		MENOR_out <= '0';
	end if;	

	
end process;

end Behavioral;

