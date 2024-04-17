library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity UnitateaDeMemorie is
    Port ( ALUResIn : in STD_LOGIC_VECTOR (31 downto 0);
           RD2 : in STD_LOGIC_VECTOR (31 downto 0);
           CLK: in STD_LOGIC;
           EN: in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           MemData : out STD_LOGIC_VECTOR (31 downto 0);
           ALUResOut : out STD_LOGIC_VECTOR (31 downto 0));
end UnitateaDeMemorie;

architecture Behavioral of UnitateaDeMemorie is
type RAM_TYPE is array (0 to 63) of std_logic_vector(31 downto 0);
signal RAM : RAM_TYPE;
begin
    
    ALUResOut <= ALUResIn;
    MemData <= RAM(CONV_INTEGER(ALUResIn(7 DOWNTO 2)));
    MEM_PROCESS: PROCESS(CLK, ALUResIn, RD2, EN)
    BEGIN
        IF RISING_EDGE (CLK) THEN
            IF MemWrite = '1' AND EN = '1' THEN
                RAM(CONV_INTEGER(ALUResIn(7 DOWNTO 2)))<= RD2;
            END IF;
        END IF;
    END PROCESS MEM_PROCESS;

end Behavioral;
