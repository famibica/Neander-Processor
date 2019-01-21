----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:03:55 10/16/2018 
-- Design Name: 
-- Module Name:    controle - Behavioral 
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

entity unidadeControle is

 Port ( 
		  -- Entradas
		  clk			: in STD_LOGIC;
		  rst			: in STD_LOGIC;
			
		  -- Entradas registrador NZ
		  N  : in  STD_LOGIC;
		  Z  : in  STD_LOGIC;
		  
		  -- Entradas decodificador
		  NOP_in 	: in  STD_LOGIC;
		  STA_in 	: in  STD_LOGIC;
		  LDA_in 	: in  STD_LOGIC;
		  ADD_in 	: in  STD_LOGIC;
		  OR_in 		: in  STD_LOGIC;
		  AND_in 	: in  STD_LOGIC;
		  NOT_in 	: in  STD_LOGIC;
		  JMP_in 	: in  STD_LOGIC;
		  JN_in 		: in  STD_LOGIC;
		  JZ_in 		: in  STD_LOGIC;
		  HLT_in 	: in  STD_LOGIC;
		  MULT_in 	: in  STD_LOGIC;
		  MAIOR_in 	: in  STD_LOGIC;
		  MENOR_in 	: in  STD_LOGIC;
			  
		  -- Selecionadores 
		  sel_ula		: out STD_LOGIC_VECTOR(2 downto 0);   -- Seleciona operacao na ULA
		  sel_rem	   : out STD_LOGIC;  						  -- Seleciona no mux REM: 00-PC 01-RDM 10-MULT

		  -- Carga dos Registradores
		  CargaAC		: out STD_LOGIC;
		  CargaPC		: out STD_LOGIC;
		  CargaREM		: out STD_LOGIC;
		  CargaRDM		: out STD_LOGIC;
		  CargaRI 		: out STD_LOGIC;
		  CargaNZ		: out STD_LOGIC;
		  
		  -- Escreve na memoria
		  enableMEM 	: out STD_LOGIC_VECTOR (0 to 0);
		  
		  -- Incrementa PC
		  incrementaPC : out STD_LOGIC;
		 
		  -- Para sinal
		  halt			: out STD_LOGIC);
			  
end unidadeControle;

architecture Behavioral of unidadeControle is

	type T_STATE is (t0,t1,t2,t3,t4,t5,t6,t7,t1_espera,t2_espera,t3_espera);
	signal estado, prox_estado : T_STATE;
	
begin

process(clk,rst)
	begin
		if(rst = '1') then
			estado <= t0;
		elsif(clk'event and clk = '1') then
			estado <= prox_estado;
		end if;
end process;

process(estado, N, Z, NOP_in, STA_in, LDA_in, ADD_in, OR_in, AND_in, NOT_in, JMP_in, JN_in, JZ_in, 
			HLT_in, MULT_in, MAIOR_in, MENOR_in)
	begin
		sel_ula <= "000";
		sel_rem <= '0';
		cargaAC <= '0';
		cargaPC <= '0';
		cargaREM <= '0';
		cargaRDM <= '0';
      cargaRI <= '0';
		cargaNZ <= '0';
		enableMEM <= "0";
		incrementaPC <= '0';
		halt <= '0';
	
		prox_estado <= t0;	
	
		case estado is
		
			when t0 =>	sel_rem <= '0';
							cargaAC <= '0';
							cargaPC <= '0';
							cargaREM <= '1';
							cargaRDM <= '0';
							cargaRI <= '0';
							cargaNZ <= '0';
							incrementaPC <= '0';
							halt <= '0';
							
							prox_estado <= t1;
			
			when t1 =>	cargaREM <= '0';
							enableMEM <= "0";
							incrementaPC <= '1';
							
							prox_estado <= t1_espera;
			
			when t1_espera =>
							prox_estado <= t2;
							
			when t2 =>  cargaRI <= '1';
							incrementaPC <= '0';
							
							prox_estado <= t3;
							
			when t3 =>  cargaRI <= '0';
			
							if(NOP_in = '1') then
								prox_estado <= t0;	
								
							elsif((STA_in or LDA_in or ADD_in or OR_in or AND_in or JMP_in or MULT_in or MAIOR_in or MENOR_in) = '1') then
								cargaREM <= '1';
								sel_rem <= '0';
								prox_estado <= t2_espera;
														
							elsif(NOT_in = '1') then
								sel_ula <= "011";
								cargaAC <= '1';
								cargaNZ <= '1';
								prox_estado <= t0;	
							
							elsif(JN_in = '1') then
								if(N = '1') then
									cargaREM <= '1';
									sel_rem <= '0';
									prox_estado <= t2_espera;
								else
									incrementaPC <= '1';
									prox_estado <= t0;
								end if;
								
							elsif(JZ_in = '1') then
								if(Z = '1') then
									cargaREM <= '1';
									sel_rem <= '0';
									prox_estado <= t2_espera;
								else
									incrementaPC <= '1';
									prox_estado <= t0;
								end if;
					
							elsif(HLT_in = '1') then
								halt <= '1';
								
							end if;
			
			when t2_espera => 
								prox_estado <= t4;
								
			when t4 =>							
							if((STA_in or LDA_in or ADD_in or OR_in or AND_in or MULT_in or MAIOR_in or MENOR_in) = '1') then
								cargaREM <= '0';
								enableMEM <= "0";
								incrementaPC <= '1';
								prox_estado <= t5;								
							
							elsif(JMP_in = '1') then
								cargaREM <= '0';
								enableMEM <= "0";
								prox_estado <= t5;
								
							elsif(JN_in = '1') then
								if(N = '1') then
									cargaREM <= '0';
									enableMEM <= "0";
									prox_estado <= t5;
								end if;
								
							elsif(JZ_in = '1') then
								if(Z = '1') then
									cargaREM <= '0';
									enableMEM <= "0";
									prox_estado <= t5;		
								end if;
							
							end if;
							
			when t5 =>
							if((STA_in or LDA_in or ADD_in or OR_in or AND_in or MULT_in or MAIOR_in or MENOR_in) = '1') then
								incrementaPC <= '0';
								sel_rem <= '1';
								cargaREM <= '1';
								prox_estado <= t6;							
										
							elsif(JMP_in = '1') then
								cargaPC <= '1';
								prox_estado <= t0;
								
							elsif(JN_in = '1') then
								if(N = '1') then
									cargaPC <= '1';
									prox_estado <= t0;
								end if;
								
							elsif(JZ_in = '1') then
								if(Z = '1') then
									cargaPC <= '1';
									prox_estado <= t0;		
								end if;
					
							end if;
			
			
			when t6 =>
							if(STA_in = '1') then
								cargaREM <= '0';
								cargaRDM <= '1';
								prox_estado <= t3_espera;
								
							elsif((LDA_in or ADD_in or OR_in or AND_in or MULT_in or MAIOR_in or MENOR_in) = '1') then
								cargaREM <= '0';
								enableMEM <= "0";
								prox_estado <= t3_espera;
								
							end if;		
			
			when t3_espera =>
								prox_estado <= t7;
								
			when t7 =>
							if(STA_in = '1') then
								cargaRDM <= '0';
								enableMEM <= "1";
								prox_estado <= t0;
								
							elsif(LDA_in = '1') then
								sel_ula <= "100";
								cargaAC <= '1';
								cargaNZ <= '1';
								prox_estado <= t0;
								
							elsif(ADD_in = '1') then
								sel_ula <= "000";
								cargaAC <= '1';
								cargaNZ <= '1';
								prox_estado <= t0;
								
							elsif(OR_in = '1') then
								sel_ula <= "010";
								cargaAC <= '1';
								cargaNZ <= '1';
								prox_estado <= t0;
								
							elsif(AND_in = '1') then
								sel_ula <= "001";
								cargaAC <= '1';
								cargaNZ <= '1';
								prox_estado <= t0;
														
							elsif(MULT_in = '1') then
								sel_ula <= "101";
								cargaAC <= '1';
								cargaNZ <= '1';
								prox_estado <= t0;
							
							elsif(MAIOR_in = '1') then
								sel_ula <= "110";
								cargaAC <= '1';
								cargaNZ <= '1';
								prox_estado <= t0;
							
							elsif(MENOR_in = '1') then
								sel_ula <= "111";
								cargaAC <= '1';
								cargaNZ <= '1';
								prox_estado <= t0;
		
							end if;
						
		end case;
				
end process;

end Behavioral;

