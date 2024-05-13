library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity InstructionDecoder is
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
end InstructionDecoder;

architecture Behavioral of InstructionDecoder is

COMPONENT REG_FILE is
    Port ( RA1 : in STD_LOGIC_VECTOR (4 downto 0);
           RA2 : in STD_LOGIC_VECTOR (4 downto 0);
           RW_ENABLE: IN STD_LOGIC;
           EN: IN STD_LOGIC;
           CLK : in STD_LOGIC;
           WD : in STD_LOGIC_VECTOR (31 downto 0);
           WA : in STD_LOGIC_VECTOR (4 downto 0);
           RD1 : out STD_LOGIC_VECTOR (31 downto 0);
           RD2 : out STD_LOGIC_VECTOR (31 downto 0));
END COMPONENT REG_FILE;

begin
    
    REG: REG_FILE PORT MAP(Instruction(25 DOWNTO 21), Instruction(20 DOWNTO 16), RegWrite, EN, CLK, WriteData, WriteAddress, ReadData1, ReadData2);
    Funct <= Instruction(5 DOWNTO 0);
    ShiftAmount <= Instruction(10 DOWNTO 6);
     RT <= Instruction(20 DOWNTO 16);
     RD <= Instruction(15 DOWNTO 11);
    Ext_Unit: PROCESS(ExtOp, Instruction)
              BEGIN
                 IF ExtOp = '1' THEN 
                    Ext_Immidiate <= Instruction(15) & Instruction(15) & Instruction(15) & Instruction(15)
                                     & Instruction(15) & Instruction(15) & Instruction(15) & Instruction(15)
                                     & Instruction(15) & Instruction(15) & Instruction(15) & Instruction(15) 
                                     & Instruction(15) & Instruction(15) & Instruction(15) & Instruction(15) 
                                     & Instruction(15 downto 0);
                 ELSIF ExtOp = '0' THEN
                    Ext_Immidiate <= X"0000" & Instruction(15 downto 0);
                 END IF;
    END PROCESS Ext_Unit;
     
end Behavioral;
