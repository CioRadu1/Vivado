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
signal RAM : RAM_TYPE :=(
    X"0000000F",--00
    X"00000000",--01
    X"00000000",--02
    X"00000000",--03
    X"00000005",--04
    X"00000000",--05
    X"00000000",--06
    X"00000000",--07
    X"00000000",--08
    X"00000000",--09
    X"00000000",--10
    X"00000000",--11
    X"00000000",--12  
    X"00000000",--13
    X"00000000",--14
    X"00000001",--15
    X"00000002",--16
    X"00000003",--17
    X"00000004",--18
    X"00000005",--19
    X"00000006",--20      
OTHERS => X"00000000");
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
