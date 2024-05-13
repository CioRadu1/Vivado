library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
entity UnitateaDeExecutie is
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
end UnitateaDeExecutie;

architecture Behavioral of UnitateaDeExecutie is

SIGNAL Ext_ImmShifted : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL MUX_SIGNAL : STD_LOGIC_VECTOR (31 DOWNTO 0); 
SIGNAL ALUControl : STD_LOGIC_VECTOR (2 DOWNTO 0); 

begin
      
      MUX_PROCESS: PROCESS (ALUSrc, RD2, Ext_Imm)
      BEGIN
          IF ALUSrC = '0' THEN 
             MUX_SIGNAL <= RD2;
          ELSIF ALUSrc = '1' THEN
             MUX_SIGNAL <= Ext_Imm;
          END IF;
      END PROCESS MUX_PROCESS;
      
      Ext_ImmShifted <= Ext_ImmShifted(29 DOWNTO 0) & "00";
      
      ALUControlProcess: PROCESS(ALUOp, Funct)
      BEGIN
          CASE ALUOp IS 
               WHEN "101" => 
                    CASE Funct IS 
                        WHEN "000001" => ALUControl <= "000";
                        WHEN "100000" => ALUControl <= "100";
                        WHEN "001000" => ALUControl <= "001";
                        WHEN "010000" => ALUControl <= "110";
                        WHEN "000100" => ALUControl <= "101";
                        WHEN "000010" => ALUControl <= "010";
                        WHEN "100001" => ALUControl <= "011";
                        WHEN "010100" => ALUControl <= "111";
                        WHEN OTHERS => ALUControl <="UUU";
                    END CASE;
               WHEN "010" => ALUControl <= "000";
               WHEN "011" => ALUControl <= "100";
               WHEN "100" => ALUControl <= "010";
               WHEN "110" => ALUControl <= "111";
               WHEN OTHERS => ALUControl <= "UUU";
          END CASE;
      END PROCESS ALUControlProcess;
      
      BranchAddress <= Ext_ImmShifted + PC4;

      ALUProcess: PROCESS(RD1, MUX_SIGNAL, ALUControl, ShiftAmount)
      BEGIN
          CASE ALUControl IS    
             WHEN "000" => ALURes <= RD1 + MUX_SIGNAL;
             WHEN "100" => ALURes <= RD1 - MUX_SIGNAL;
             WHEN "001" => ALURes <= TO_STDLOGICVECTOR(TO_BITVECTOR(MUX_SIGNAL) SLL CONV_INTEGER(ShiftAmount));
             WHEN "110" => ALURes <= TO_STDLOGICVECTOR(TO_BITVECTOR(MUX_SIGNAL) SRL CONV_INTEGER(ShiftAmount));
             WHEN "101" => ALURes <= RD1 AND MUX_SIGNAL;
             WHEN "010" => ALURes <= RD1 OR MUX_SIGNAL;
             WHEN "011" => ALURes <= RD1 XOR MUX_SIGNAL;
             WHEN "111" => IF SIGNED(RD1) < SIGNED(MUX_SIGNAL) THEN
                               ALURes <= X"00000001";
                           ELSE ALURes <= X"00000000";
                           END IF;
             WHEN OTHERS => ALURes <= (OTHERS => 'X');
          END CASE;
      END PROCESS ALUProcess;
end Behavioral;
