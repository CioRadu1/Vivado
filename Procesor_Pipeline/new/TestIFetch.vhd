library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity TestIFetch is
     Port (clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end TestIFetch;


architecture Behavioral of TestIFetch is

COMPONENT MPG IS
  PORT (
 		CLK : IN std_logic;
 		BTN1 : IN STD_LOGIC;
  		ENABLE: OUT STD_LOGIC);
END COMPONENT MPG;

COMPONENT SEGMENTE is
    Port (
           clk : in STD_LOGIC;
           DIGITS : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT SEGMENTE;

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
enD COMPONENT IFetch;

SIGNAL ENABLE_FETCH : STD_LOGIC;
SIGNAL INSTRC : STD_LOGIC_VECTOR (31 DOWNTO 0):=(OTHERS => '0');
SIGNAL PC2 : STD_LOGIC_VECTOR (31 DOWNTO 0):=(OTHERS => '0');
SIGNAL NUM : STD_LOGIC_VECTOR (31 DOWNTO 0):=(OTHERS => '0');

begin
    C1: MPG PORT MAP (CLK, BTN(0), ENABLE_FETCH);
    C2: IFETCH PORT MAP (CLK, ENABLE_FETCH, BTN(1), SW(0), SW(1), X"00000000", X"00000010", PC2, INSTRC);
    
    MUX_PROCESS: PROCESS(SW(7), INSTRC, PC2)
    BEGIN
        IF SW(7) = '1' THEN 
            NUM <= PC2;
        ELSE 
            NUM <= INSTRC;
        END IF;
    END PROCESS MUX_PROCESS;

    C3: SEGMENTE PORT MAP (CLK, NUM, CAT, AN);

end Behavioral;
