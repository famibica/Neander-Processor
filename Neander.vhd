library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Neander is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           AC : out  STD_LOGIC_VECTOR (7 downto 0);
           PC : out  STD_LOGIC_VECTOR (7 downto 0);
           hlt : out  STD_LOGIC
			 );
end Neander;

architecture Behavioral of Neander is

	-- Maquina de Estados

	type tstate is (
						-- Qualquer instrucao
						load_rem_pc,
						read_inst,
						load_ri,
						decod,

						-- STA / LDA / ADD / OR / AND / SUB / MUL
						read_adress_cycle,
						load_rem_mem,

						-- LDA / ADD / OR / AND / SUB / XOR
						read_data,
						perform_op,

						-- STA
						write_data,

						-- JMP / JN / JZ
						jump_cycle,
						jump_to,

						-- HLT
						halt_state

					);

	signal state : tstate;
	signal next_state : tstate := load_rem_pc;

	-- Memoria: Sinais intermediarios
	signal MEM_READ : STD_LOGIC;
	signal MEM_WRITE : STD_LOGIC_VECTOR (0 downto 0);
	signal MEM_OUT : STD_LOGIC_VECTOR (7 downto 0);

	-- PC: Sinais intermediarios

	signal PC_OUT : STD_LOGIC_VECTOR (7 downto 0);
	signal PC_INC : STD_LOGIC;
	signal PC_LOAD : STD_LOGIC;

	-- REM: Sinais intermediarios

	signal REM_IN : STD_LOGIC_VECTOR (7 downto 0);
	signal REM_OUT : STD_LOGIC_VECTOR (7 downto 0);
	signal REM_LOAD : STD_LOGIC;

	-- NZ: Sinais intermediarios

	signal NZ_IN : STD_LOGIC_VECTOR (1 downto 0);
	signal NZ_OUT : STD_LOGIC_VECTOR (1 downto 0);
	signal NZ_LOAD : STD_LOGIC;

	-- AC: Sinais intermediarios

	signal AC_IN : STD_LOGIC_VECTOR (7 downto 0);
	signal AC_OUT : STD_LOGIC_VECTOR (7 downto 0);
	signal AC_LOAD : STD_LOGIC;

	-- INST: Sinais intermediarios

	signal INST_OUT : STD_LOGIC_VECTOR (3 downto 0);
	signal INST_LOAD : STD_LOGIC;

	-- Seletores:

	signal MUX_SEL : STD_LOGIC;
	signal ULA_SEL : STD_LOGIC_VECTOR (2 downto 0);

	-- Declaracao de Componentes
	
	component ARegister
		Generic ( nbits : INTEGER := 1);
	    Port ( clk : in  STD_LOGIC;
	           reset : in  STD_LOGIC;
	           load : in  STD_LOGIC;
			   increment : in STD_LOGIC;
	           D : in  STD_LOGIC_VECTOR (nbits-1 downto 0);
	           Q : out  STD_LOGIC_VECTOR (nbits-1 downto 0));
	end component;

	component ULA
	    Port ( X : in  STD_LOGIC_VECTOR (7 downto 0);
	           Y : in  STD_LOGIC_VECTOR (7 downto 0);
	           sel : in  STD_LOGIC_VECTOR (2 downto 0);
	           Q : out  STD_LOGIC_VECTOR (7 downto 0);
	           NZ : out STD_LOGIC_VECTOR (1 downto 0));
	end component;

	component Mux2x1
	    Port ( D1 : in  STD_LOGIC_VECTOR (7 downto 0);
	           D2 : in  STD_LOGIC_VECTOR (7 downto 0);
	           sel : in  STD_LOGIC;
	           Q : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	component BRAM
	    Port ( clka : in  STD_LOGIC;
			   ena : in  STD_LOGIC;
			   wea : in  STD_LOGIC_VECTOR (0 downto 0);
			   addra : in  STD_LOGIC_VECTOR (7 downto 0);
			   dina : in  STD_LOGIC_VECTOR (7 downto 0);
			   clkb : in STD_LOGIC;
			   addrb : in STD_LOGIC_VECTOR (7 downto 0);
			   doutb : out  STD_LOGIC_VECTOR(7 downto 0));
	end component;


begin

	-- Instanciacao de Componentes

	PC_REG: ARegister
		generic map (nbits => 8)
		port map (
			clk => clk,
			reset => reset,
			load => PC_LOAD,
			increment => PC_INC,
			D => MEM_OUT,
			Q => PC_OUT
		);

	AC_REG: ARegister
		generic map (nbits => 8)
		port map (
			clk => clk,
			reset => reset,
			load => AC_LOAD,
			increment => '0',
			D => AC_IN,
			Q => AC_OUT
		);

	REM_REG: ARegister
		generic map (nbits => 8)
		port map (
			clk => clk,
			reset => reset,
			load => REM_LOAD,
			increment => '0',
			D => REM_IN,
			Q => REM_OUT
		);

	NZ_REG: ARegister
		generic map (nbits => 2)
		port map (
			clk => clk,
			reset => reset,
			load => NZ_LOAD,
			increment => '0',
			D => NZ_IN,
			Q => NZ_OUT
		);

	INST_REG: ARegister
		generic map (nbits => 4)
		port map (
			clk => clk,
			reset => reset,
			load => INST_LOAD,
			increment => '0',
			D => MEM_OUT (7 downto 4),
			Q => INST_OUT
		);

	REM_MUX: Mux2x1
		port map (
			D1 => PC_OUT,
			D2 => MEM_OUT,
			sel => MUX_SEL,
			Q => REM_IN
		);

	ULA_BOX: ULA
		port map (
			X => AC_OUT,
			Y => MEM_OUT,
			sel => ULA_SEL,
			Q => AC_IN,
			NZ => NZ_IN 
		);

	MEMORY: BRAM
		port map (
			clka => clk,
			ena => MEM_READ,
			wea => MEM_WRITE,
			addra => REM_OUT,
			dina => AC_OUT,
			clkb => clk,
			addrb => REM_OUT,
			doutb => MEM_OUT
		);


	-- Maquina de Estados

	process (clk, reset)
	begin

		if (reset = '1') then
			state <= load_rem_pc;
		elsif (clk'event and clk = '1') then
			state <= next_state;
		end if;
	end process;

	process (state, next_state, INST_OUT, NZ_OUT)
	begin

		PC_LOAD <= '0';
		PC_INC <= '0';
		AC_LOAD <= '0';
		REM_LOAD <= '0';
		NZ_LOAD <= '0';
		INST_LOAD <= '0';
		ULA_SEL <= "111";
		MUX_SEL <= '0';
		hlt <= '0';
		MEM_READ <= '0';
		MEM_WRITE <= "0";

			case state is
				when load_rem_pc => 
					REM_LOAD <= '1';
					next_state <= read_inst;
				when read_inst =>
					PC_INC <= '1';
					MEM_READ <= '1';
					next_state <= load_ri;
				when load_ri =>
					INST_LOAD <= '1';
					next_state <= decod;
				when decod =>

					case INST_OUT is
						when "0001" | "0010" | "0011" | "0100" | "0101" | "1100" | "1101" =>	-- STA / LDA / ADD / AND / OR / SUB / MUL
							REM_LOAD <= '1';
							next_state <= read_adress_cycle;	
						when "0110" =>															-- NOT
							ULA_SEL <= "011";
							NZ_LOAD <= '1';
							AC_LOAD <= '1';
							next_state <= load_rem_pc;
						when "1000" =>															-- JMP
							REM_LOAD <= '1';							
							next_state <= jump_cycle;
						when "1001" =>															-- JN
							if (NZ_OUT(1) = '1') then
								REM_LOAD <= '1';
								next_state <= jump_cycle;
							else
								PC_INC <= '1';
								next_state <= load_rem_pc;
							end if;
						when "1010" =>															-- JZ
							if (NZ_OUT(0) = '1') then
								REM_LOAD <= '1';
								next_state <= jump_cycle;
							else
								PC_INC <= '1';
								next_state <= load_rem_pc;
							end if;
						when "1111" =>															-- HLT
							hlt <= '1';
							next_state <= halt_state;
						when others =>
							next_state <= load_rem_pc;
					end case;

				when jump_cycle =>
					MEM_READ <= '1';
					next_state <= jump_to;
				when jump_to =>
					PC_LOAD <= '1';
					next_state <= load_rem_pc;

				when read_adress_cycle =>
					MEM_READ <= '1';
					PC_INC <= '1';
					next_state <= load_rem_mem;
				when load_rem_mem =>
					MUX_SEL <= '1';
					REM_LOAD <= '1';
					if (INST_OUT = "0001") then
						next_state <= write_data;
					else
						next_state <= read_data;
					end if;

				when write_data =>
					MEM_WRITE <= "1";
					next_state <= load_rem_pc;

				when read_data =>
					MEM_READ <= '1';
					next_state <= perform_op;
				when perform_op =>
					AC_LOAD <= '1';
					NZ_LOAD <= '1';
					next_state <= load_rem_pc;
					case INST_OUT is
						when "0010" =>
							ULA_SEL <= "100";
						when "0011" =>
							ULA_SEL <= "000";
						when "0100" =>
							ULA_SEL <= "010";
						when "0101" =>
							ULA_SEL <= "001";
						when "1100" =>
							ULA_SEL <= "101";
						when "1101" =>
							ULA_SEL <= "110";
						when others =>
					end case;

				when halt_state =>
					hlt <= '1';

				when others =>
					next_state <= next_state;

			end case;
	end process;
	
	AC <= AC_OUT;
	PC <= PC_OUT;

end Behavioral;