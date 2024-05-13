library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity IFetch is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           RST : in STD_LOGIC;
           JUMP : in STD_LOGIC;
           PCSrc : in STD_LOGIC;
           JUMP_ADRESS : in STD_LOGIC_VECTOR (31 downto 0);
           BRANCH_ADRESS : in STD_LOGIC_VECTOR (31 downto 0);
           PCrs2 : out STD_LOGIC_VECTOR (31 downto 0);
           INSTRUCTION : out STD_LOGIC_VECTOR (31 downto 0));
end IFetch;

architecture ARCH_OF_IFETCH of IFetch is

COMPONENT ROM is
    Port ( ADDR : in STD_LOGIC_VECTOR (4 downto 0);
           DO : out STD_LOGIC_VECTOR (31 downto 0));
END COMPONENT ROM;

SIGNAL INPC : STD_LOGIC_VECTOR (31 DOWNTO 0):=(OTHERS => '0');
SIGNAL OUTPC : STD_LOGIC_VECTOR (31 DOWNTO 0):=(OTHERS => '0');
SIGNAL MUX_BRANCH_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0):=(OTHERS => '0');
SIGNAL MUX_JUMP_OUT : STD_LOGIC_VECTOR (31 DOWNTO 0):=(OTHERS => '0');
begin

    RM: ROM PORT MAP (OUTPC(6 DOWNTO 2), INSTRUCTION);
    PC: PROCESS (CLK, RST) 
        BEGIN 
            IF RST = '1' THEN 
                OUTPC <= (OTHERS => '0');
                ELSE IF RISING_EDGE(CLK) THEN
                    IF EN = '1' THEN 
                        OUTPC <= INPC;
                    END IF;
                END IF;    
            END IF;
    END PROCESS PC;
    
    PCrs2 <= OUTPC + 4; 
    
    MUX_BRANCH: PROCESS(PCSrc, OUTPC, BRANCH_ADRESS)
    BEGIN 
       IF PCSrc = '1' THEN 
          MUX_BRANCH_OUT <= BRANCH_ADRESS;
       ELSE 
          MUX_BRANCH_OUT <= OUTPC + 4; 
       END IF;
    END PROCESS MUX_BRANCH;
    
    MUX_JUMP: PROCESS(JUMP, JUMP_ADRESS, MUX_BRANCH_OUT)
    BEGIN 
       IF JUMP = '1' THEN 
          MUX_JUMP_OUT <= JUMP_ADRESS;
       ELSE 
          MUX_JUMP_OUT <= MUX_BRANCH_OUT; 
       END IF;
    END PROCESS MUX_JUMP;

    INPC <= MUX_JUMP_OUT;
    
end ARCH_OF_IFETCH;
