library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity MainControlUnit is
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
end MainControlUnit;

architecture Behavioral of MainControlUnit is
begin
    Main: PROCESS(INSTRUCTION) 
          BEGIN
              CASE INSTRUCTION IS
                    WHEN "000000" => RegDst <= '1'; 
                                     ALUSrc <= '0';
                                     Branch <= '0';
                                     Jump <= '0';
                                     MemWrite <= '0';
                                     MemToReg <= '0';
                                     RegWrite <= '1';
                                     ALUOp <= "101";     
                                        
                    WHEN "010001" => RegDst <= '0';
                                     ExtOp <= '1'; 
                                     ALUSrc <= '1';
                                     Branch <= '0';
                                     Jump <= '0';
                                     MemWrite <= '0';
                                     MemToReg <= '0';
                                     RegWrite <= '1';
                                     ALUOp <= "010";
                                     
                    WHEN "000101" => RegDst <= '0';
                                     ExtOp <= '1'; 
                                     ALUSrc <= '1';
                                     Branch <= '0';
                                     Jump <= '0';
                                     MemWrite <= '0';
                                     MemToReg <= '1';
                                     RegWrite <= '1';
                                     ALUOp <= "010";
                                     
                    WHEN "000001" => RegDst <= '0';
                                     ExtOp <= '1'; 
                                     ALUSrc <= '1';
                                     Branch <= '0';
                                     Jump <= '0';
                                     MemWrite <= '1';
                                     RegWrite <= '0';
                                     ALUOp <= "010";
                                     
                    WHEN "001001" => RegDst <= '0';
                                     ExtOp <= '1'; 
                                     ALUSrc <= '0';
                                     Branch <= '1';
                                     Jump <= '0';
                                     MemWrite <= '0';
                                     RegWrite <= '0';
                                     ALUOp <= "011";
                                     
                    WHEN "101000" => RegDst <= '0';
                                     ExtOp <= '0'; 
                                     ALUSrc <= '1';
                                     Branch <= '0';
                                     Jump <= '0';
                                     MemWrite <= '0';
                                     RegWrite <= '1';
                                     ALUOp <= "100";
                                     
                    WHEN "101001" => RegDst <= '0';
                                     ExtOp <= '1'; 
                                     ALUSrc <= '1';
                                     Branch <= '0';
                                     Jump <= '0';
                                     MemWrite <= '0';
                                     RegWrite <= '1';
                                     ALUOp <= "110";
                                     
                    WHEN "000100" => Jump <= '0';
                                     MemWrite <= '0';
                                     RegWrite <= '0';
                                     ALUOp <= "110";
                                     
                    WHEN OTHERS =>   RegDst <= 'X';
                                     ExtOp <= 'X'; 
                                     ALUSrc <= 'X';
                                     Branch <= 'X';
                                     Jump <= 'X';
                                     MemWrite <= 'X';
                                     MemToReg <= 'X';
                                     RegWrite <= 'X';
                                     ALUOp <= "XXX";
               END CASE;
          END PROCESS Main;


end Behavioral;
