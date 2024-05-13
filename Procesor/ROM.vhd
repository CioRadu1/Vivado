library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity ROM is
    Port ( 
           ADDR : in STD_LOGIC_VECTOR (4 downto 0);
           DO : out STD_LOGIC_VECTOR (31 downto 0));
end ROM;

architecture Behavioral of ROM is
type ROM_TYPE is array (0 to 31) of std_logic_vector(31 downto 0);
signal ROM : ROM_TYPE := (

             B"000101_00000_00001_0000000000000000",   -- 0. lw $1, 0($0)    # Citim A
             B"000101_11111_00010_0000000000010000",   -- 1. lw $2, 16($31)    # Citim N
             B"010001_11111_00011_0000000000000001",   -- 2. addi $3, $31, 1  # Ini?ializ?m indicele i = 1
             B"010001_11111_01000_0000000000000001",   -- 3. addi $8, $31, 1  # Ini?ializ?m rezultatul cu 1
             
             B"001001_00011_00010_0000000000001000",   -- 4. beq $3, $2, 9 # verificam daca i = N-
             B"000101_00001_00101_0000000000000000",   -- 5. lw $5, 0($1)  # Citim elementul i
             B"000101_00001_00110_0000000000000100",   -- 6. lw $6, 4($1)  # Salvam i+1 in registul 6
             B"000000_00110_00101_00111_00000_010100",   -- 7. slt $7, $6, $5  # Comparam elementul curent cu urm?torul $7 = 1 daca $6 < $5
             B"001001_00111_01000_0000000000000011",   -- 8. beq $7, $8, 3 # Daca se gaseste un element neordonat iesim din bucla si scriem 0 pe $8
             B"010001_00011_00011_0000000000000001", -- 9. addi $3, $3, 1 # Iteram i 
             B"010001_00001_00001_0000000000000100", -- 10. addi $1, $1, 4 # Trecem la urmatorul element din sir
             B"000100_00000000000000000000000100", -- 11. j 4 # Sarim la loop
            
             B"000000_01000_01000_00111_00000_100000", -- 12. sub $8, $8, $7 # Scriem 0 pe iesire
  
others => X"00000000");

begin
     do <= ROM(conv_integer(addr));
end Behavioral;
