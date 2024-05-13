library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
entity Procesor is
  Port (   clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end Procesor;

architecture ProcesorArchitecture of Procesor is

COMPONENT IFetch is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           RST : in STD_LOGIC;
           JUMP : in STD_LOGIC;
           PCSrc : in STD_LOGIC;
           JUMP_ADRESS : in STD_LOGIC_VECTOR (31 downto 0);
           BRANCH_ADRESS : in STD_LOGIC_VECTOR (31 downto 0);
           PCrs2 : out STD_LOGIC_VECTOR (31 downto 0);
           INSTRUCTION : out STD_LOGIC_VECTOR (31 downto 0));
END COMPONENT IFetch;

COMPONENT SEGMENTE is
    Port (
           clk : in STD_LOGIC;
           DIGITS : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT SEGMENTE;

COMPONENT MPG IS
  PORT (
 		CLK : IN std_logic;
 		BTN1 : IN STD_LOGIC;
  		ENABLE: OUT STD_LOGIC);
END COMPONENT MPG;

COMPONENT InstructionDecoder is
    Port ( RegWrite : in STD_LOGIC;
           CLK: in STD_LOGIC;
           EN: in STD_LOGIC;
           Instruction : in STD_LOGIC_VECTOR (25 downto 0);
           RegDst : in STD_LOGIC;
           ExtOp : in STD_LOGIC;
           WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           ReadData1 : out STD_LOGIC_VECTOR (31 downto 0);
           ReadData2 : out STD_LOGIC_VECTOR (31 downto 0);
           Ext_Immidiate : out STD_LOGIC_VECTOR (31 downto 0);
           Funct : out STD_LOGIC_VECTOR (5 downto 0);
           ShiftAmount : out STD_LOGIC_VECTOR (4 downto 0));
END COMPONENT InstructionDecoder;

COMPONENT MainControlUnit is
    Port ( Instruction : in STD_LOGIC_VECTOR (5 downto 0);
           RegDst : out STD_LOGIC;
           ExtOp : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           Branch : out STD_LOGIC;
           Jump : out STD_LOGIC;
           ALUOp : out STD_LOGIC_VECTOR (2 downto 0);
           MemWrite : out STD_LOGIC;
           MemToReg : out STD_LOGIC;
           RegWrite : out STD_LOGIC);
END COMPONENT MainControlUnit;

COMPONENT UnitateaDeExecutie is
    Port ( RD1 : in STD_LOGIC_VECTOR (31 downto 0);
           RD2 : in STD_LOGIC_VECTOR (31 downto 0);
           Ext_Imm : in STD_LOGIC_VECTOR (31 downto 0);
           ShiftAmount : in STD_LOGIC_VECTOR (4 downto 0);
           Funct : in STD_LOGIC_VECTOR (5 downto 0);
           ALUOp : in STD_LOGIC_VECTOR (2 downto 0);
           PC4 : in STD_LOGIC_VECTOR (31 downto 0);
           ALUSrc : in STD_LOGIC;
           ZeroFlag : out STD_LOGIC;
           ALURes : out STD_LOGIC_VECTOR (31 downto 0);
           BranchAddress : out STD_LOGIC_VECTOR (31 downto 0));
END COMPONENT UnitateaDeExecutie;

COMPONENT UnitateaDeMemorie is
    Port ( ALUResIn : in STD_LOGIC_VECTOR (31 downto 0);
           RD2 : in STD_LOGIC_VECTOR (31 downto 0);
           CLK: in STD_LOGIC;
           EN: in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           MemData : out STD_LOGIC_VECTOR (31 downto 0);
           ALUResOut : out STD_LOGIC_VECTOR (31 downto 0));
END COMPONENT UnitateaDeMemorie;

SIGNAL ENABLE : STD_LOGIC := '0';
SIGNAL RESET_BTN : STD_LOGIC := '0';
SIGNAL PC_SRC : STD_LOGIC := '0';
SIGNAL REG_DST : STD_LOGIC := '0';
SIGNAL EXT_OP : STD_LOGIC := '0';
SIGNAL ALU_SRC : STD_LOGIC := '0';
SIGNAL BRANCH : STD_LOGIC := '0';
SIGNAL JUMP : STD_LOGIC := '0';
SIGNAL ALU_OP : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
SIGNAL MEM_WRITE : STD_LOGIC := '0';
SIGNAL MEM_TO_REG : STD_LOGIC := '0';
SIGNAL REG_WRITE : STD_LOGIC := '0';
SIGNAL ZERO_FLAG : STD_LOGIC := '0';
SIGNAL INSTRUCTION : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL PC4 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL RD1 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL RD2 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL EXT_IMM : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL FUNCT : STD_LOGIC_VECTOR (5 DOWNTO 0) := (OTHERS => '0');
SIGNAL SHIFT_AMOUNT : STD_LOGIC_VECTOR (4 DOWNTO 0) := (OTHERS => '0');
SIGNAL JUMP_ADDRESS : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL BRANCH_ADDRESS : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL ALU_RES : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL MEM_DATA : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL ALU_RES_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL WRITE_DATA_MUX_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL DIGITS_MUX : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL SHIFTED_INSTR : STD_LOGIC_VECTOR (27 DOWNTO 0) := (OTHERS => '0');

begin

    C1: MPG PORT MAP (CLK, BTN(0), ENABLE);
    C2: MPG PORT MAP (CLK, BTN(1), RESET_BTN);
    C3: IFetch PORT MAP (CLK, ENABLE, RESET_BTN, JUMP, PC_SRC, JUMP_ADDRESS, BRANCH_ADDRESS, PC4, INSTRUCTION);
    C4: InstructionDecoder PORT MAP (REG_WRITE, CLK, ENABLE, INSTRUCTION(25 DOWNTO 0), REG_DST, EXT_OP, WRITE_DATA_MUX_OUT, RD1, RD2, EXT_IMM, FUNCT, SHIFT_AMOUNT);
    C5: MainControlUnit PORT MAP (INSTRUCTION(31 DOWNTO 26), REG_DST, EXT_OP, ALU_SRC, BRANCH, JUMP, ALU_OP, MEM_WRITE, MEM_TO_REG, REG_WRITE);
    C6: UnitateaDeExecutie PORT MAP (RD1, RD2, EXT_IMM, SHIFT_AMOUNT, FUNCT, ALU_OP, PC4, ALU_SRC, ZERO_FLAG, ALU_RES, BRANCH_ADDRESS);
    C7: UnitateaDeMemorie PORT MAP (ALU_RES, RD2, CLK, ENABLE, MEM_WRITE, MEM_DATA, ALU_RES_OUT);
    
    WRITE_DATA_MUX: PROCESS(ALU_RES_OUT, MEM_DATA, MEM_TO_REG)
    BEGIN
        IF MEM_TO_REG = '1' THEN
            WRITE_DATA_MUX_OUT <= MEM_DATA;
        ELSE
            WRITE_DATA_MUX_OUT <= ALU_RES_OUT;
        END IF;
    END PROCESS WRITE_DATA_MUX;
    
    SHIFTED_INSTR <= INSTRUCTION(25 DOWNTO 0) & "00";
    JUMP_ADDRESS <= PC4(31 DOWNTO 28) & SHIFTED_INSTR;
    PC_SRC <= ZERO_FLAG AND BRANCH;
    
    DIGITS_MUX_OUT: PROCESS(SW(7 DOWNTO 5), INSTRUCTION, PC4, RD1, RD2, EXT_IMM, ALU_RES, MEM_DATA, WRITE_DATA_MUX_OUT)
    BEGIN
        CASE SW(7 DOWNTO 5) IS
            WHEN "000" => DIGITS_MUX <= INSTRUCTION;
            WHEN "001" => DIGITS_MUX <= PC4;
            WHEN "010" => DIGITS_MUX <= RD1;
            WHEN "011" => DIGITS_MUX <= RD2;
            WHEN "100" => DIGITS_MUX <= EXT_IMM;
            WHEN "101" => DIGITS_MUX <= ALU_RES;
            WHEN "110" => DIGITS_MUX <= MEM_DATA;
            WHEN OTHERS => DIGITS_MUX <= WRITE_DATA_MUX_OUT;
        END CASE;
    END PROCESS DIGITS_MUX_OUT;
    
    C8: SEGMENTE PORT MAP(CLK, DIGITS_MUX, CAT, AN);
    
    LED(9 DOWNTO 0) <= ALU_OP & EXT_OP & ALU_SRC & BRANCH & JUMP & MEM_WRITE & MEM_TO_REG & REG_WRITE;

end ProcesorArchitecture;
