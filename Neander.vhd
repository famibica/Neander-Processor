----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:03:54 10/17/2018 
-- Design Name: 
-- Module Name:    neander - Behavioral 
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

entity neander is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           acumulador : out  STD_LOGIC_VECTOR (8 downto 0);
           halt : out  STD_LOGIC);
end neander;

architecture Behavioral of neander is


COMPONENT PC
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		PC_in : IN std_logic_vector(8 downto 0);
		cargaPC : IN std_logic;
		incrementaPC : IN std_logic;          
		PC_out : OUT std_logic_vector(8 downto 0)
		);
END COMPONENT;


COMPONENT mux2x1
	PORT(
		sel : IN std_logic;
		in1 : IN std_logic_vector(8 downto 0);
		in2 : IN std_logic_vector(8 downto 0);          
		s : OUT std_logic_vector(8 downto 0)
		);
END COMPONENT;



COMPONENT reg9
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		reg_in : IN std_logic_vector(8 downto 0);
		cargaREG : IN std_logic;          
		reg_out : OUT std_logic_vector(8 downto 0)
		);
END COMPONENT;


COMPONENT memory
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    clkb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
  );
END COMPONENT;
	

COMPONENT RegRDM
PORT(
	clk : IN std_logic;
	rst : IN std_logic;
	cargaRDM : IN std_logic;
	rw : IN std_logic_vector(0 to 0);
	reg_in1 : IN std_logic_vector(8 downto 0);
	reg_in2 : IN std_logic_vector(8 downto 0);          
	reg_out : OUT std_logic_vector(8 downto 0)
	);
END COMPONENT;
	
COMPONENT ula
	PORT(
		ula_in1 : IN std_logic_vector(8 downto 0);
		ula_in2 : IN std_logic_vector(8 downto 0);
		ula_sel : IN std_logic_vector(2 downto 0);          
		ula_NZ : OUT std_logic_vector(1 downto 0);
		ula_out : OUT std_logic_vector(8 downto 0)
		);
END COMPONENT;


COMPONENT decodificador
	PORT(
		decod_in : IN std_logic_vector(3 downto 0);          
		NOP_out : OUT std_logic;
		STA_out : OUT std_logic;
		LDA_out : OUT std_logic;
		ADD_out : OUT std_logic;
		OR_out : OUT std_logic;
		AND_out : OUT std_logic;
		NOT_out : OUT std_logic;
		JMP_out : OUT std_logic;
		JN_out : OUT std_logic;
		JZ_out : OUT std_logic;
		HLT_out : OUT std_logic;
		MULT_out : OUT std_logic;
		MAIOR_out : OUT std_logic;
		MENOR_out : OUT std_logic
		);
END COMPONENT;
	

COMPONENT regNZ
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		nz_in : IN std_logic_vector(1 downto 0);
		cargaNZ : IN std_logic;          
		nz_out : OUT std_logic_vector(1 downto 0)
		);
END COMPONENT;


COMPONENT unidadeControle
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		N : IN std_logic;
		Z : IN std_logic;
		NOP_in : IN std_logic;
		STA_in : IN std_logic;
		LDA_in : IN std_logic;
		ADD_in : IN std_logic;
		OR_in : IN std_logic;
		AND_in : IN std_logic;
		NOT_in : IN std_logic;
		JMP_in : IN std_logic;
		JN_in : IN std_logic;
		JZ_in : IN std_logic;
		HLT_in : IN std_logic;
		MULT_in : IN std_logic;
		MAIOR_in : IN std_logic;   
		MENOR_in : IN std_logic; 		
		sel_ula : OUT std_logic_vector(2 downto 0);
		sel_rem : OUT std_logic;
		CargaAC : OUT std_logic;
		CargaPC : OUT std_logic;
		CargaREM : OUT std_logic;
		CargaRDM : OUT std_logic;
		CargaRI : OUT std_logic;
		CargaNZ : OUT std_logic;
		enableMEM : OUT std_logic_vector(0 to 0);
		incrementaPC : OUT std_logic;
		halt : OUT std_logic
		);
END COMPONENT;
	
signal cargaAC, cargaPC, cargaREM, cargaRDM, cargaRI, cargaNZ, incrementaPC, sel_rem: STD_LOGIC;
signal enableMEM : STD_LOGIC_VECTOR (0 to 0);
signal NZ_in, NZ_out : STD_LOGIC_VECTOR(1 downto 0);
signal sel_ula : STD_LOGIC_VECTOR(2 downto 0);
signal ULA_out, muxREM_out, opcode, PC_out, AC_out, RDM_out, REM_out, mem: std_logic_vector(8 downto 0);
signal inst_NOP, inst_STA, inst_LDA, inst_ADD, inst_OR, inst_AND, inst_NOT, inst_JMP, inst_JN, inst_JZ,
		 inst_HLT, inst_MULT, inst_MAIOR, inst_MENOR : STD_LOGIC;	
  
begin

	programCounter: PC PORT MAP(
		clk => clk,
		rst => rst,
		PC_in => RDM_out,
		cargaPC => cargaPC,
		incrementaPC => incrementaPC,
		PC_out => PC_out
	);
	
	muxREM: mux2x1 PORT MAP(
		in1 => PC_out,
		in2 => RDM_out,
		sel => sel_rem,
		s => muxREM_out
	);

	regEM : reg9 PORT MAP (
		clk => clk,
		rst => rst,
		reg_in => muxREM_out,
		cargaREG => cargaREM,
		reg_out => REM_out
	);
	
	BRAM : memory PORT MAP (
		clka => clk,
		wea => enableMEM,
		addra => REM_out,
		dina => AC_out,
		clkb => clk,
		addrb => REM_out,
		doutb => mem
	);
	
	Inst_RegRDM: RegRDM PORT MAP(
		clk => clk,
		rst => rst,
		cargaRDM => cargaRDM,
		rw => enableMEM,
		reg_in1 => AC_out,
		reg_in2 => mem,
		reg_out => RDM_out
	);
	
	regI : reg9 PORT MAP (
		clk => clk,
		rst => rst,
		reg_in => RDM_out,
		cargaREG => cargaRI,
		reg_out => opcode
	);
	
	regAC : reg9 PORT MAP (
		clk => clk,
		rst => rst,
		reg_in => ULA_out,
		cargaREG => cargaAC,
		reg_out => AC_out
	);
	
	alu: ula PORT MAP(
		ula_in1 => AC_out,
		ula_in2 => RDM_out,
		ula_sel => sel_ula,
		ula_NZ => NZ_in,
		ula_out => ULA_out
	);
	
	decoder: decodificador PORT MAP(
		decod_in => opcode (7 downto 4),
		NOP_out => inst_NOP,
		STA_out => inst_STA,
		LDA_out => inst_LDA,
		ADD_out => inst_ADD,
		OR_out => inst_OR,
		AND_out => inst_AND,
		NOT_out => inst_NOT,
		JMP_out => inst_JMP,
		JN_out => inst_JN,
		JZ_out => inst_JZ,
		HLT_out => inst_HLT,
		MULT_out => inst_MULT,
		MAIOR_out => inst_MAIOR,
		MENOR_out => inst_MENOR
	);
	
   nz: regNZ PORT MAP(
		clk => clk,
		rst => rst,
		nz_in => NZ_in,
		cargaNZ => cargaNZ,
		nz_out => NZ_out
	);
  
  
   controlUnit: unidadeControle PORT MAP(
		clk => clk,
		rst => rst,
		N => NZ_out(1),
		Z => NZ_out(0),
		NOP_in => inst_NOP,
		STA_in => inst_STA,
		LDA_in => inst_LDA,
		ADD_in => inst_ADD,
		OR_in => inst_OR,
		AND_in => inst_AND,
		NOT_in => inst_NOT,
		JMP_in => inst_JMP,
		JN_in => inst_JN,
		JZ_in => inst_JZ,
		HLT_in => inst_HLT,
		MULT_in => inst_MULT,
		MAIOR_in => inst_MAIOR,
		MENOR_in => inst_MENOR,
		sel_ula => sel_ula,
		sel_rem => sel_rem,
		CargaAC => cargaAC,
		CargaPC => cargaPC,
		CargaREM => cargaREM,
		CargaRDM => cargaRDM,
		CargaRI => cargaRI,
		CargaNZ => cargaNZ,
		enableMEM => enableMEM,
		incrementaPC => incrementaPC,
		halt => halt
	);
	
	acumulador <= AC_out;
end Behavioral;

