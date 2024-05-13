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
    Port ( CLK: in STD_LOGIC;
           EN: in STD_LOGIC;
           RegWrite : in STD_LOGIC;
           Instruction : in STD_LOGIC_VECTOR (25 downto 0);
           WriteAddress : in STD_LOGIC_VECTOR (4 DOWNTO 0);
           ExtOp : in STD_LOGIC;
           WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           ReadData1 : out STD_LOGIC_VECTOR (31 downto 0);
           ReadData2 : out STD_LOGIC_VECTOR (31 downto 0);
           Ext_Immidiate : out STD_LOGIC_VECTOR (31 downto 0);
           Funct : out STD_LOGIC_VECTOR (5 downto 0);
           ShiftAmount : out STD_LOGIC_VECTOR (4 downto 0);
           RT : out STD_LOGIC_VECTOR (4 DOWNTO 0);
           RD : out STD_LOGIC_VECTOR (4 DOWNTO 0));
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
           RD : in STD_LOGIC_VECTOR (4 DOWNTO 0);
           RT : in STD_LOGIC_VECTOR (4 DOWNTO 0);
           RegDst : in STD_LOGIC ;
           RegWriteAddress : out STD_LOGIC_VECTOR(4 DOWNTO 0);
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

COMPONENT IF_ID is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           Instruction_In : in STD_LOGIC_VECTOR (31 downto 0);
           PC4_In : in STD_LOGIC_VECTOR (31 downto 0);
           Instruction_Out : out STD_LOGIC_VECTOR (31 downto 0);
           PC4_OuT : out STD_LOGIC_VECTOR (31 downto 0));
END COMPONENT IF_ID;

COMPONENT ID_EX is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           RD1_In : in STD_LOGIC_VECTOR (31 downto 0);
           RD2_In : in STD_LOGIC_VECTOR (31 downto 0);
           Ext_Imm_In : in STD_LOGIC_VECTOR (31 downto 0);
           Func_In : in STD_LOGIC_VECTOR (5 downto 0);
           Shift_In : in STD_LOGIC_VECTOR (4 downto 0);
           RegRD_In : in STD_LOGIC_VECTOR (4 downto 0);
           RegRT_In : in STD_LOGIC_VECTOR (4 downto 0);
           RD1_Out : out STD_LOGIC_VECTOR (31 downto 0);
           RD2_Out : out STD_LOGIC_VECTOR (31 downto 0);
           Ext_Imm_Out : out STD_LOGIC_VECTOR (31 downto 0);
           Func_Out : out STD_LOGIC_VECTOR (5 downto 0);
           Shift_Out : out STD_LOGIC_VECTOR (4 downto 0);
           RegRD_Out : out STD_LOGIC_VECTOR (4 downto 0);
           RegRT_Out : out STD_LOGIC_VECTOR (4 downto 0);
           MemToReg : in STD_LOGIC;
           RegWrite : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           Branch : in STD_LOGIC;
           ALUOp : in STD_LOGIC_VECTOR (2 downto 0);
           ALUSrc : in STD_LOGIC;
           RegDst : in STD_LOGIC;
           PC4_In : in STD_LOGIC_VECTOR (31 downto 0);
           PC4_Out : out STD_LOGIC_VECTOR (31 downto 0);
           WB : out STD_LOGIC_VECTOR (1 downto 0);
           M : out STD_LOGIC_VECTOR (1 downto 0);
           EX : out STD_LOGIC_VECTOR (4 downto 0));
END COMPONENT ID_EX;

COMPONENT EX_MEM is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           WB_In : in STD_LOGIC_VECTOR (1 downto 0);
           M_In : in STD_LOGIC_VECTOR (1 downto 0);
           PC4_In : in STD_LOGIC_VECTOR (31 downto 0);
           ZeroFlag_In : in STD_LOGIC;
           ALURes_In : in STD_LOGIC_VECTOR (31 downto 0);
           RD2_In : in STD_LOGIC_VECTOR (31 downto 0);
           RegWriteData_In : in STD_LOGIC_VECTOR (4 downto 0);
           WB_Out : out STD_LOGIC_VECTOR (1 downto 0);
           M_Out : out STD_LOGIC_VECTOR (1 downto 0);
           ZeroFlag_Out : out STD_LOGIC;
           PC4_Out : out STD_LOGIC_VECTOR (31 downto 0);
           ALURes_Out : out STD_LOGIC_VECTOR (31 downto 0);
           RD2_Out : out STD_LOGIC_VECTOR (31 downto 0);
           RegWriteData_Out : out STD_LOGIC_VECTOR (4 downto 0));
END COMPONENT EX_MEM;

COMPONENT MEM_WB is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           ReadData_In : in STD_LOGIC_VECTOR (31 downto 0);
           WB_In : in STD_LOGIC_VECTOR (1 downto 0);
           ALURes_In : in STD_LOGIC_VECTOR (31 downto 0);
           RegWriteData_In : in STD_LOGIC_VECTOR (4 downto 0);
           ReadData_Out : out STD_LOGIC_VECTOR (31 downto 0);
           WB_Out : out STD_LOGIC_VECTOR (1 downto 0);
           ALURes_Out : out STD_LOGIC_VECTOR (31 downto 0);
           RegWriteData_Out : out STD_LOGIC_VECTOR (4 downto 0));
END COMPONENT MEM_WB;

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
SIGNAL ZERO_FLAG_OUT : STD_LOGIC := '0';
SIGNAL INSTRUCTION : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL PC4 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL INSTRUCTION_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL PC4_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL PC4_OUT2 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL PC4_OUT3 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL RD1 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL RD2 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL RD1_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL RD2_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL RD2_OUT1 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL EXT_IMM : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL FUNCT : STD_LOGIC_VECTOR (5 DOWNTO 0) := (OTHERS => '0');
SIGNAL SHIFT_AMOUNT : STD_LOGIC_VECTOR (4 DOWNTO 0) := (OTHERS => '0');
SIGNAL EXT_IMM_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL FUNCT_OUT : STD_LOGIC_VECTOR (5 DOWNTO 0) := (OTHERS => '0');
SIGNAL SHIFT_AMOUNT_OUT : STD_LOGIC_VECTOR (4 DOWNTO 0) := (OTHERS => '0');
SIGNAL rWD_FINAL : STD_LOGIC_VECTOR (4 DOWNTO 0) := (OTHERS => '0');
SIGNAL rWD_1 : STD_LOGIC_VECTOR (4 DOWNTO 0) := (OTHERS => '0');
SIGNAL rWD_1_OUT : STD_LOGIC_VECTOR (4 DOWNTO 0) := (OTHERS => '0');
SIGNAL RegD1 : STD_LOGIC_VECTOR (4 DOWNTO 0) := (OTHERS => '0');
SIGNAL RegT1 : STD_LOGIC_VECTOR (4 DOWNTO 0) := (OTHERS => '0');
SIGNAL RegD1_OUT : STD_LOGIC_VECTOR (4 DOWNTO 0) := (OTHERS => '0');
SIGNAL RegT1_OUT : STD_LOGIC_VECTOR (4 DOWNTO 0) := (OTHERS => '0');
SIGNAL JUMP_ADDRESS : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL BRANCH_ADDRESS : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL ALU_RES : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL MEM_DATA : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL MEM_DATA_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL ALU_RES_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL ALU_RES_FINAL : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL ALU_RES_OUT1 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL WRITE_DATA_MUX_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL DIGITS_MUX : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL SHIFTED_INSTR : STD_LOGIC_VECTOR (27 DOWNTO 0) := (OTHERS => '0');
SIGNAL WB1_OUT : STD_LOGIC_VECTOR (1 DOWNTO 0) := (OTHERS => '0');
SIGNAL M1_OUT : STD_LOGIC_VECTOR (1 DOWNTO 0) := (OTHERS => '0');
SIGNAL EX1_OUT : STD_LOGIC_VECTOR (4 DOWNTO 0) := (OTHERS => '0');
SIGNAL WB2_OUT : STD_LOGIC_VECTOR (1 DOWNTO 0) := (OTHERS => '0');
SIGNAL M2_OUT : STD_LOGIC_VECTOR (1 DOWNTO 0) := (OTHERS => '0');
SIGNAL WB3_OUT : STD_LOGIC_VECTOR (1 DOWNTO 0) := (OTHERS => '0');

begin

    C1: MPG PORT MAP (CLK, BTN(0), ENABLE);
    C2: MPG PORT MAP (CLK, BTN(1), RESET_BTN);
    C3: IFetch PORT MAP (CLK, ENABLE, RESET_BTN, JUMP, PC_SRC, JUMP_ADDRESS, BRANCH_ADDRESS, PC4, INSTRUCTION);
    C4: IF_ID PORT MAP (CLK, ENABLE, INSTRUCTION, PC4, INSTRUCTION_OUT, PC4_OUT);
    C5: InstructionDecoder PORT MAP (CLK, ENABLE, WB3_OUT(0), INSTRUCTION_OUT(25 DOWNTO 0),rWD_FINAL, EXT_OP, WRITE_DATA_MUX_OUT, RD1, RD2, EXT_IMM, FUNCT, SHIFT_AMOUNT, RegD1, RegT1);
    C6: ID_EX PORT MAP (CLK, ENABLE, RD1, RD2, EXT_IMM, FUNCT, SHIFT_AMOUNT, RegD1, RegT1, RD1_OUT, RD2_OUT, EXT_IMM_OUT, FUNCT_OUT, SHIFT_AMOUNT_OUT, RegD1_OUT, RegT1_OUT, MEM_TO_REG, REG_WRITE, MEM_WRITE, BRANCH, ALU_OP, ALU_SRC, REG_DST, PC4_OUT, PC4_OUT2, WB1_OUT, M1_OUT, EX1_OUT);
    C7: MainControlUnit PORT MAP (INSTRUCTION_OUT(31 DOWNTO 26), REG_DST, EXT_OP, ALU_SRC, BRANCH, JUMP, ALU_OP, MEM_WRITE, MEM_TO_REG, REG_WRITE); 
    C8: UnitateaDeExecutie PORT MAP (RD1_OUT, RD2_OUT, EXT_IMM_OUT, SHIFT_AMOUNT_OUT, FUNCT_OUT, EX1_OUT(4 DOWNTO 2), PC4_OUT2, EX1_OUT(1), RegD1_OUT, RegT1_OUT, EX1_OUT(0), rWD_1, ZERO_FLAG, ALU_RES, BRANCH_ADDRESS);
    C9: EX_MEM PORT MAP (CLK, ENABLE, WB1_OUT, M1_OUT, BRANCH_ADDRESS, ZERO_FLAG, ALU_RES, RD2_OUT, rWD_1, WB2_OUT, M2_OUT, ZERO_FLAG_OUT, PC4_OUT3, ALU_RES_OUT1, RD2_OUT1, rWD_1_OUT);
    C10: UnitateaDeMemorie PORT MAP (ALU_RES_OUT1, RD2_OUT1, CLK, ENABLE, M2_OUT(0), MEM_DATA , ALU_RES_OUT);
    C11: MEM_WB PORT MAP (CLK, ENABLE, MEM_DATA, WB2_OUT, ALU_RES_OUT, rWD_1_OUT, MEM_DATA_OUT, WB3_OUT, ALU_RES_FINAL, rWD_FINAL);
    
    WRITE_DATA_MUX: PROCESS(ALU_RES_FINAL, MEM_DATA_OUT, WB3_OUT(1))
    BEGIN
        IF WB3_OUT(1) = '1' THEN
            WRITE_DATA_MUX_OUT <=  MEM_DATA_OUT;
        ELSE
            WRITE_DATA_MUX_OUT <= ALU_RES_FINAL;
        END IF;
    END PROCESS WRITE_DATA_MUX;
    
    SHIFTED_INSTR <= INSTRUCTION_OUT(25 DOWNTO 0) & "00";
    JUMP_ADDRESS <= PC4_OUT(31 DOWNTO 28) & SHIFTED_INSTR;
    PC_SRC <= ZERO_FLAG_OUT AND M2_OUT(1);
    
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
    
    C12: SEGMENTE PORT MAP(CLK, DIGITS_MUX, CAT, AN);
    
    LED(9 DOWNTO 0) <= ALU_OP & EXT_OP & ALU_SRC & BRANCH & JUMP & MEM_WRITE & MEM_TO_REG & REG_WRITE;

end ProcesorArchitecture;
